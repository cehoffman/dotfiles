#import <AppKit/AppKit.h>
#import <Carbon/Carbon.h>
#import <signal.h>

NSString *iTerm2Identifier = @"com.googlecode.iterm2";
EventHotKeyRef hotKeyRef;

void shutdown(int signum) {
  UnregisterEventHotKey(hotKeyRef);
  [[NSApplication sharedApplication] terminate:nil];
}

OSStatus hotkey_handler(EventHandlerCallRef next, EventRef event, void *data) {
  NSRunningApplication *iTerm2;
  NSArray *apps = [NSRunningApplication
                   runningApplicationsWithBundleIdentifier:iTerm2Identifier];

  if ([apps count] == 0) return noErr;
  iTerm2 = [apps objectAtIndex:0];
  if (!iTerm2) return noErr;

  if ([iTerm2 ownsMenuBar]) {
    [iTerm2 hide];
  } else {
    [iTerm2 activateWithOptions:NSApplicationActivateIgnoringOtherApps];
  }

  return noErr;
}

int main(int argc, char **argv) {
  EventHotKeyID hotKeyID;
  EventTypeSpec eventType;

  eventType.eventClass = kEventClassKeyboard;
  eventType.eventKind = kEventHotKeyPressed;

  hotKeyID.signature = 'htk1';
  hotKeyID.id = 1;

  InstallApplicationEventHandler(&hotkey_handler, 1, &eventType, NULL, NULL);

  // Installed F1 as the hotkey to watch for
  if (!RegisterEventHotKey(122, 0x800000, hotKeyID,
                           GetEventDispatcherTarget(), 0, &hotKeyRef)) {
    signal(SIGTERM, shutdown);
    signal(SIGINT, shutdown);

    // Really wish I could figure out the run loop magic to make the hotkey
    // presses deliverable, but so far this is the only way I've found
    [[NSApplication sharedApplication] run];
  }

  return EXIT_FAILURE;
}
