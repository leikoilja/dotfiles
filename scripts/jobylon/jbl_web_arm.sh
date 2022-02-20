#!/bin/sh

# Script to patch jbl-web with settings files which allow developing on Macbook
# M1 arm architecture

JBL_WEB_PATH="/Users/leikoilja/Development/Jobylon/jbl-web"

cd $JBL_WEB_PATH

# Test file
OLD="SOUTH_TESTS_MIGRATE = True"
NEW="SOUTH_TESTS_MIGRATE = False"
FILENAME="./jbl_web/settings/test.py"
sed -i '' "s/${OLD}/${NEW}/" ${FILENAME}

# Whoosh
OLD="JBL_TEST_HAYSTACK_BACKEND=Elastic"
NEW="# JBL_TEST_HAYSTACK_BACKEND=Elastic"
FILENAME="./.env"
sed -i '' "s/${OLD}/${NEW}/" ${FILENAME}

OLD="#JBL_TEST_HAYSTACK_BACKEND='Whoosh'"
NEW="JBL_TEST_HAYSTACK_BACKEND='Whoosh'"
FILENAME="./.env"
sed -i '' "s/${OLD}/${NEW}/" ${FILENAME}

TEXT="
# Whoosh
\n# Default
\nHAYSTACK_CONNECTIONS['default']['ENGINE'] = 'haystack.backends.whoosh_backend.WhooshEngine'
\nHAYSTACK_CONNECTIONS['default']['PATH'] = normpath(join(DJANGO_ROOT, 'whoosh.index'))
\n# Jobs
\nHAYSTACK_CONNECTIONS['jobs']['ENGINE'] = 'haystack.backends.whoosh_backend.WhooshEngine'
\nHAYSTACK_CONNECTIONS['jobs']['PATH'] = normpath(join(DJANGO_ROOT, 'whoosh.index'))
"
FILENAME="./jbl_web/settings/common.py"
echo $TEXT >> $FILENAME
