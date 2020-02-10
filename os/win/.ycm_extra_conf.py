import os

def FlagsForFile(filename, **kwargs):
    print(os.path.basename(filename))
    if os.path.basename(filename) is 'iTerm2HotKey.m':
        flags = ['-fobjc-arc', '-framework', 'Carbon', '-framework', 'AppKit']
    return {
        'flags': flags,
        'do_cache': True
    }
