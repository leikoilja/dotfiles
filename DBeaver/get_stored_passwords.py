
# https://stackoverflow.com/questions/39928401/recover-db-password-stored-in-my-dbeaver-connection

# requires pycryptodome lib (pip install pycryptodome)

import base64
import json
import os
import sys

from Crypto.Cipher import AES

default_paths = [
  '~/Library/DBeaverData/workspace6/General/.dbeaver/credentials-config.json',
  # '~/.local/share/DBeaverData/workspace6/General/.dbeaver/credentials-config.json',
  # '~/.local/share/.DBeaverData/workspace6/General/.dbeaver/credentials-config.json',
  # '~/AppData/Roaming/DBeaverData/workspace6/General/.dbeaver/credentials-config.json',
]

if len(sys.argv) < 2:
  for path in default_paths:
    filepath = os.path.expanduser(path)
    try:
      f = open(filepath, 'rb')
      f.close()
      break
    except Exception as e:
      pass
else:
  filepath = sys.argv[1]

print(filepath)

#PASSWORD_DECRYPTION_KEY = bytes([-70, -69, 74, -97, 119, 74, -72, 83, -55, 108, 45, 101, 61, -2, 84, 74])
PASSWORD_DECRYPTION_KEY = bytes([186, 187, 74, 159, 119, 74, 184, 83, 201, 108, 45, 101, 61, 254, 84, 74])

data = open(filepath, 'rb').read()

decryptor = AES.new(PASSWORD_DECRYPTION_KEY, AES.MODE_CBC, data[:16])
padded_output = decryptor.decrypt(data[16:])
output = padded_output.rstrip(padded_output[-1:])

try:
  print(json.dumps(json.loads(output), indent=4, sort_keys=True))
except:
  print(output)