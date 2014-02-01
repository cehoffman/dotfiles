#!/usr/bin/env python

import re
from ctypes.util import find_library
from ctypes import (
    byref,
    c_uint32,
    c_void_p,
    create_string_buffer,
    memmove,
    cdll,
)


security = cdll.LoadLibrary(find_library('Security'))

def get_password(server, username):
  server = server.encode('utf-8')
  username = username.encode('utf-8')
  length = c_uint32()
  data = c_void_p()

  status = security.SecKeychainFindInternetPassword(None,
      len(server), server,
      0, None,
      len(username), username,
      0, None, 0,
      1768776048, 1953261156,
      byref(length), byref(data), None)

  if status == 0:
    password = create_string_buffer(length.value)
    memmove(password, data.value, length.value)
    password = password.raw
    security.SecKeychainItemFreeContent(None, data)
  else:
    password = None

  return password

if __name__ == '__main__':
  print get_password('mail.emerson.com'.encode('utf-8'), 'emrsn.org\\choffman'.encode('utf-8'))

mappings = {
    'gmail': {
        'INBOX': 'inbox',
        # '[Gmail]/Sent Mail': 'sent',
        # '[Gmail]/Spam': 'spam',
        '[Gmail]/Trash': 'trash',
        # '[Gmail]/Drafts': 'drafts'
    },
    'apple': {
        'INBOX': 'inbox',
        'Sent Messages': 'sent',
        'Deleted Messages': 'trash',
        'Drafts': 'drafts'
    },
    'emerson': {
        'INBOX': 'inbox',
        'Drafts': 'drafts',
        'Sent': 'sent',
        'Trash': 'trash',
    }
}

inv = {}
for k in mappings:
    inv[k + '.inv'] = dict(zip(mappings[k].values(), mappings[k].keys()))
mappings = dict(mappings.items() + inv.items())

excluded = {
    'emerson': [
        'Junk',
        'Junk E-mail',
        'Sync Issues.*',
        'Unsent Messages',
        'Sent Messages'
    ],
    'gmail': [
        '.*' # Exlude all gmail folders by default
    ],
    'apple': [
        '.*'
    ]
}

included = {
    'gmail': [
        r'INBOX',
        r'\[Gmail\]/Trash',
        # r'\[Gmail\]/Sent Mail',
        # r'\[Gmail\]/Drafts'
    ],
    'apple': [
        r'INBOX',
        r'Sent Messages',
        r'Deleted Messages'
    ]
}

def local_name(account, folder):
    return mappings.get(account, {}).get(folder, folder)

def remote_name(account, folder):
    return mappings.get(account + '.inv', {}).get(folder, folder)

def sync(account, folder):
    result = True

    for pattern in included.get(account, []):
        if re.search(pattern, folder):
            return True

    for pattern in excluded.get(account, []):
        result = result and (re.search(pattern, folder) == None)

    return result
