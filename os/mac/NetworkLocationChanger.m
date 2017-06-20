#import "Reachability.h"
#import <CoreWLAN/CoreWLAN.h>
#import <SystemConfiguration/SystemConfiguration.h>

bool keepRunning = true;

void terminate(int signum) {
  NSLog(@"Shutting down NetworkLocationChanger");
  keepRunning = false;
  CFRunLoopStop(CFRunLoopGetCurrent());
}

Boolean setCurrentLocation(NSString *name) {
  SCPreferencesRef prefs = SCPreferencesCreate(NULL, (CFStringRef)@"SystemConfiguration", NULL);
  SCNetworkSetRef set = SCNetworkSetCopyCurrent(prefs);
  NSString *curLocation = (NSString *)SCNetworkSetGetName(set);

  // Short circuit if the current location is the one we want to switch to
  if (![name isEqual:curLocation]) {
    // Get all locations
    NSArray *locations = (NSArray *)CFBridgingRelease(SCNetworkSetCopyAll(prefs));

    // Find the location that is the one we want to switch to and make it
    // current
    Boolean save = NO;
    for (id item in locations) {
      NSString * locName = (NSString *)SCNetworkSetGetName((SCNetworkSetRef)item);
      if ([name isEqual:locName]) {
        NSLog(@"Setting Network Location to %@", locName);
        save = SCNetworkSetSetCurrent((SCNetworkSetRef)item);
        break;
      }
    }

    // Make the changes apply to the running system
    if (save) {
      save = SCPreferencesCommitChanges(prefs);
      if (save) {
        save = SCPreferencesApplyChanges(prefs);
      }
    }
  } else {
    NSLog(@"Not changing location from %@ to %@", curLocation, name);
  }

  CFRelease(set);
  CFRelease(prefs);

  return YES;
}

int main(int argc, char **argv) {
  signal(SIGTERM, terminate);
  signal(SIGINT, terminate);

  @autoreleasepool {
    Reachability *reach = [Reachability reachabilityForLocalWiFi];

    reach.reachableBlock = ^(Reachability *reach) {
      CWInterface *wif = [[CWWiFiClient sharedWiFiClient] interface];
      NSLog(@"Connected on SSID: %@", wif.ssid);

      if ([wif.ssid isEqual:@"Chris's Access"]) {
        if (!setCurrentLocation(@"Work")) {
          NSLog(@"Failed changing network location");
        }
      } else if ([wif.ssid isEqual:@"Chris Hoffman's Network"]) {
        if (!setCurrentLocation(@"Home")) {
          NSLog(@"Failed changing network location");
        }
      } else if (!setCurrentLocation(@"Automatic")) {
        NSLog(@"Failed changing network location");
      };
    };

    reach.unreachableBlock = ^(Reachability *reach) {
      NSLog(@"Disconnected");
    };

    [reach startNotifier];

    setCurrentLocation(@"Automatic");

    NSRunLoop *rl = [NSRunLoop currentRunLoop];
    while (keepRunning && [rl runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);

    [reach stopNotifier];
  }

  return EXIT_FAILURE;
}
