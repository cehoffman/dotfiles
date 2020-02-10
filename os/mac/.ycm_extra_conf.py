import os

files = {
    'iTerm2HotKey.m': [
        '-ObjC',
        '-fobjc-arc',
        '-framework', 'Carbon',
        '-framework', 'AppKit'
    ],
    'NetworkLocationChanger.m': [
        '-ObjC',
        '-fobjc-arc',
        '-framework', 'SystemConfiguration',
        '-framework', 'AppKit',
        '-framework', 'CoreWLAN'
    ],
}

def FlagsForFile(filename, **kwargs):
  return {
      'flags': files.get(os.path.basename(filename), []),
      'do_cache': True
      }
