#!/bin/bash

# Mostly inspired by
# https://github.com/JamesTurland/JimsGarage/blob/main/Kubernetes/K3S-Deploy/k3s.sh
echo -e " \033[36;5m         _  _________   ___         _        _ _           \033[0m"
echo -e " \033[36;5m        | |/ |__ / __| |_ _|_ _  __| |_ __ _| | |          \033[0m"
echo -e " \033[36;5m        | ' < |_ \__ \  | || ' \(_-|  _/ _\` | | |          \033[0m"
echo -e " \033[36;5m        |_|\_|___|___/ |___|_||_/__/\__\__,_|_|_|          \033[0m"
echo -e " \033[36;5m                                                           \033[0m"
echo -e " \033[32;5m                                                           \033[0m"


#############################################
# YOU SHOULD ONLY NEED TO EDIT THIS SECTION #
#############################################

# Version of Kube-VIP to deploy
KVVERSION="v0.8.4"

# K3S Version
k3sVersion="v1.30.5+k3s1"

# Set the IP addresses of the master and work nodes
master1=10.0.0.11
master2=10.0.0.12
master3=10.0.0.13
worker1=10.0.0.14
worker2=10.0.0.15

# User of remote machines
user=ubuntu

# Interface used on remotes
interface=eth0

# Set the virtual IP address (VIP)
vip=10.0.0.10

# Array of master nodes
masters=($master2 $master3)

# Array of worker nodes
workers=($worker1 $worker2)

# Array of all
all=($master1 $master2 $master3 $worker1 $worker2)

# Array of all minus master
allnomaster1=($master2 $master3 $worker1 $worker2)

# Loadbalancer IP range
lbrange=10.0.0.100-10.0.0.150

# ssh certificate name variable
certName=id_k3s_rsa

# ssh certificate directory
certDir=~/Development/dotfiles/kubernetes/.ssh

#############################################
#            DO NOT EDIT BELOW              #
#############################################

# add ssh keys for all nodes
for node in "${all[@]}"; do
  ssh-copy-id $user@$node
  ssh-copy-id -i $certDir/$certName $user@$node
done

# Install policycoreutils for each node
for newnode in "${all[@]}"; do
  ssh $user@$newnode -i $certDir/$certName sudo su <<EOF
  NEEDRESTART_MODE=a apt-get install policycoreutils -y
  exit
EOF
  echo -e " \033[32;5mPolicyCoreUtils installed!\033[0m"
done

# Step 1: Bootstrap First k3s Node
mkdir -p ~/.kube
k3sup install \
  --ip $master1 \
  --user $user \
  --tls-san $vip \
  --cluster \
  --k3s-version $k3sVersion \
  --k3s-extra-args "--disable traefik --disable servicelb --flannel-iface=$interface --node-ip=$master1 --node-taint node-role.kubernetes.io/master=true:NoSchedule" \
  --merge \
  --sudo \
  --local-path $HOME/.kube/config \
  --ssh-key $certDir/$certName \
  --context k3s-ha
echo -e " \033[32;5mFirst Node bootstrapped successfully!\033[0m"

# Step 2: Install Kube-VIP for HA
# Kube-VIP must be installed before adding additional nodes
kubectl apply -f https://kube-vip.io/manifests/rbac.yaml

# Step 3: Download kube-vip
# curl -sO https://raw.githubusercontent.com/JamesTurland/JimsGarage/main/Kubernetes/K3S-Deploy/kube-vip
# cat kube-vip | sed 's/$interface/'$interface'/g; s/$vip/'$vip'/g' > ./kube-vip.yaml
# Note: set svc_enable to true if you want to use metallb

# Step 4: Copy kube-vip.yaml to master1
scp -i $certDir/$certName ./kube-vip.yaml $user@$master1:~/kube-vip.yaml

# Step 5: Connect to Master1 and move kube-vip.yaml
ssh $user@$master1 -i $certDir/$certName <<- EOF
  sudo mkdir -p /var/lib/rancher/k3s/server/manifests
  sudo mv kube-vip.yaml /var/lib/rancher/k3s/server/manifests/kube-vip.yaml
EOF

# Step 6: Add new master nodes (servers) & workers
for newnode in "${masters[@]}"; do
  k3sup join \
    --ip $newnode \
    --user $user \
    --sudo \
    --k3s-version $k3sVersion \
    --server \
    --server-ip $master1 \
    --ssh-key $certDir/$certName \
    --k3s-extra-args "--disable traefik --disable servicelb --flannel-iface=$interface --node-ip=$newnode --node-taint node-role.kubernetes.io/master=true:NoSchedule" \
    --server-user $user
  echo -e " \033[32;5mMaster node joined successfully!\033[0m"
done

# add workers
for newagent in "${workers[@]}"; do
  k3sup join \
    --ip $newagent \
    --user $user \
    --sudo \
    --k3s-version $k3sVersion \
    --server-ip $master1 \
    --ssh-key $certDir/$certName \
    --k3s-extra-args "--node-label \"longhorn=true\" --node-label \"worker=true\""
  echo -e " \033[32;5mAgent node joined successfully!\033[0m"
done

# Step 7: Install kube-vip as network LoadBalancer - Install the kube-vip Cloud Provider
kubectl apply -f https://raw.githubusercontent.com/kube-vip/kube-vip-cloud-provider/main/manifest/kube-vip-cloud-controller.yaml

# Step 8: IP range for LoadBalancer
kubectl create configmap -n kube-system kubevip --from-literal range-global=$lbrange

# # Step 9: Test with Nginx
# kubectl apply -f https://raw.githubusercontent.com/inlets/inlets-operator/master/contrib/nginx-sample-deployment.yaml -n default
# kubectl expose deployment nginx-1 --port=80 --type=LoadBalancer -n default
#
# echo -e " \033[32;5mWaiting for K3S to sync and LoadBalancer to come online\033[0m"
#
# while [[ $(kubectl get pods -l app=nginx -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}') != "True" ]]; do
#    sleep 1
# done
#
# # Step 10: Deploy IP Pools and l2Advertisement
# kubectl wait --namespace metallb-system \
#                  --for=condition=ready pod \
#                  --selector=component=controller \
#                  --timeout=120s
# kubectl apply -f ipAddressPool.yaml
# kubectl apply -f https://raw.githubusercontent.com/JamesTurland/JimsGarage/main/Kubernetes/K3S-Deploy/l2Advertisement.yaml
#
# kubectl get nodes
# kubectl get svc
# kubectl get pods --all-namespaces -o wide
#
# echo -e " \033[32;5mHappy Kubing! Access Nginx at EXTERNAL-IP above\033[0m"