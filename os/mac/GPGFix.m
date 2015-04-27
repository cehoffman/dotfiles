#import <xpc/xpc.h>
#import <AppKit/AppKit.h>
#import <Carbon/Carbon.h>
#import <IOKit/IOKitLib.h>
#import <IOKit/IOMessage.h>
#import <sys/proc_info.h>
#import <libproc.h>
#import <libgen.h>
#import <signal.h>

// Method for listing processes taken from:
// http://stackoverflow.com/questions/3018054/retrieve-names-of-running-processes
static void closeSCDaemon() {
  static char *bad_actors[] = {"scdaemon", "pcsc-wrapper", NULL};
  pid_t pids[1024];
  bzero(pids, sizeof(pids));
  proc_listpids(PROC_ALL_PIDS, 0, pids, sizeof(pids));

  for (int i = proc_listpids(PROC_ALL_PIDS, 0, NULL, 0) - 1; i >= 0; i--) {
    if (!pids[i]) continue;

    char pathBuffer[PROC_PIDPATHINFO_MAXSIZE];
    bzero(pathBuffer, sizeof(pathBuffer));

    proc_pidpath(pids[i], pathBuffer, sizeof(pathBuffer));
    if (*pathBuffer != '\0') {
      for (int j = 0; bad_actors[j] != NULL; j++) {
        if (strstr(basename(pathBuffer), bad_actors[j])) {
          NSLog(@"Found %s pid %d", bad_actors[j], pids[i]);
          kill(pids[i], SIGQUIT);
        }
      }
    }
  }
}

void handleDisplayNotification(void *context, io_service_t y, natural_t msgType, void *msgArgument) {
  static enum {on, dimmed, off} state = on;

  switch (msgType) {
  case kIOMessageDeviceWillPowerOff:
    state++;
    if (state == dimmed) {
      NSLog(@"Display has dimmed");
    } else if (state == off) {
      NSLog(@"Display has gone to sleep");
    }
    break;
  case kIOMessageDeviceHasPoweredOn:
    if (state == dimmed) {
      NSLog(@"Display is waking from dimmed");
    } else {
      NSLog(@"Display has woken");
      closeSCDaemon();
    }
    state = on;
    break;
  }
}

static void listenForDisplaySleepWake() {
  io_service_t displayWrangler;
  IONotificationPortRef notificationPort;
  io_object_t notifier;

  displayWrangler = IOServiceGetMatchingService(kIOMasterPortDefault,
                                                IOServiceNameMatching("IODisplayWrangler"));
  if (!displayWrangler) {
    NSLog(@"Failed getting display service");
    abort();
  }

  notificationPort = IONotificationPortCreate(kIOMasterPortDefault);
  if (!notificationPort) {
    NSLog(@"Failed to create notification port for display");
    abort();
  }

  if (IOServiceAddInterestNotification(notificationPort,
                                        displayWrangler,
                                        kIOGeneralInterest,
                                        handleDisplayNotification,
                                        NULL,
                                        &notifier) != kIOReturnSuccess) {
    NSLog(@"Failed to register for display notifications");
    abort();
  }

  CFRunLoopAddSource(CFRunLoopGetCurrent(),
                     IONotificationPortGetRunLoopSource(notificationPort),
                     kCFRunLoopDefaultMode);
  IOObjectRelease(displayWrangler);
}

int main(int argc, char **argv) {
  @autoreleasepool {
    xpc_set_event_stream_handler("com.apple.iokit.matching", NULL, ^(xpc_object_t event) {
      const char *name = xpc_dictionary_get_string(event, XPC_EVENT_KEY_NAME);

      uint64_t id = xpc_dictionary_get_uint64(event, "IOMatchLaunchServiceID");

      NSLog(@"Received event: %s: %llu", name, id);

      closeSCDaemon();
      });
  }

  listenForDisplaySleepWake();
  CFRunLoopRun();

  return EXIT_SUCCESS;
}
