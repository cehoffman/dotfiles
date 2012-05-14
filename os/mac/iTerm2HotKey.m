#import <AppKit/AppKit.h>
#import <Carbon/Carbon.h>
#import <signal.h>

NSString *iTerm2Identifier = @"com.googlecode.iterm2";
EventHotKeyRef hotKeyRef;
pid_t lastActive = 0;

@interface AppListener : NSObject
+(AppListener *)sharedListener;
-(void)notified:(NSNotification *)theNotification;
@end

@implementation AppListener
+(AppListener *)sharedListener {
  static __strong AppListener *_shared = nil;
  if (_shared == nil) _shared = [[self alloc] init];
  return _shared;
}

-(void)notified:(NSNotification *)aNotification {
  NSRunningApplication *sender;
  NSString *ident;

  sender = [[aNotification userInfo] valueForKey:NSWorkspaceApplicationKey];
  ident = [sender bundleIdentifier];

  if (ident && ![ident isEqualToString:iTerm2Identifier]) {
    lastActive = [sender processIdentifier];
  }
}
@end

void shutdown(int signum) {
  UnregisterEventHotKey(hotKeyRef);
  [[[NSWorkspace sharedWorkspace] notificationCenter]
    removeObserver:[AppListener sharedListener]];
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
    // This guards incase we have not initialized the lastActive yet
    if (lastActive) {
      // Recheck lastActive application to make sure it is still in existence
      NSRunningApplication *lastApp = [NSRunningApplication
        runningApplicationWithProcessIdentifier:lastActive];

      if (lastApp) {
        [lastApp activateWithOptions:NSApplicationActivateIgnoringOtherApps];
      }
    } else {
      // Since we don't know who to activate, just hide to achieve effect
      [iTerm2 hide];
    }
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

  // Install F1 as the hotkey to watch for
  if (!RegisterEventHotKey(122, 0x800000, hotKeyID,
                           GetEventDispatcherTarget(), 0, &hotKeyRef)) {
    signal(SIGTERM, shutdown);
    signal(SIGINT, shutdown);

    // Needed to use notification on application loading so the selector
    // version of listening for application deactivations doesn't complain
    // about release autopools that I can't setup when using ARC
    __block __weak id observer = [[NSNotificationCenter defaultCenter]
      addObserverForName:NSApplicationDidFinishLaunchingNotification
                  object:nil
                   queue:nil
              usingBlock: ^(NSNotification *aNotification) {
                [[NSNotificationCenter defaultCenter] removeObserver:observer];

                // The block form apparently has some sort of bug. It does
                // not work for notifications from the workspace. Nothing is
                // sent.
                [[[NSWorkspace sharedWorkspace] notificationCenter]
                  addObserver:[AppListener sharedListener]
                     selector:@selector(notified:)
                         name:NSWorkspaceDidDeactivateApplicationNotification
                       object:nil];
              }];

    // Really wish I could figure out the run loop magic to make the hotkey
    // presses deliverable, but so far this is the only way I've found
    [NSApplication sharedApplication];
    [NSApp disableRelaunchOnLogin];
    [NSApp run];
  }

  return EXIT_FAILURE;
}
