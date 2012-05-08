#!/usr/bin/env python

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
  server = server.encode('ascii')
  username = username.encode('ascii')
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
  print get_password('imap.gmail.com'.encode('ascii'), 'cehoffman@gmail.com'.encode('ascii'))

