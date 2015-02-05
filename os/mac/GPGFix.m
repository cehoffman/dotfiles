#import <xpc/xpc.h>
#import <AppKit/AppKit.h>
#import <Carbon/Carbon.h>

int main(int argc, char **argv) {
  @autoreleasepool {
    xpc_set_event_stream_handler("com.apple.iokit.matching", NULL, ^(xpc_object_t event) {
      const char *name = xpc_dictionary_get_string(event, XPC_EVENT_KEY_NAME);

      uint64_t id = xpc_dictionary_get_uint64(event, "IOMatchLaunchServiceID");

      NSLog(@"Received event: %s: %llu", name, id);

      system("/usr/bin/killall -quit scdaemon");
      });
  }

  [NSApplication sharedApplication];
  [NSApp disableRelaunchOnLogin];
  [NSApp run];

  return EXIT_SUCCESS;
}
