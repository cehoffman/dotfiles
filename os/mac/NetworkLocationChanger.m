#import "Reachability.h"
#import <AppKit/AppKit.h>
#import <CoreWLAN/CoreWLAN.h>
#import <SystemConfiguration/SystemConfiguration.h>

@interface AppListener : NSObject
+(instancetype)sharedListener;
+(Boolean)setCurrentLocation:(NSString *)name;
@property(strong) Reachability *reach;
@end

@implementation AppListener

+(instancetype)sharedListener {
  static __strong AppListener *shared = nil;
  if (!shared) shared = [[self alloc] init];
  return shared;
}

-(instancetype)init {
  self.reach = [Reachability reachabilityForLocalWiFi];

  self.reach.reachableBlock = ^(Reachability *reach) {
    NSLog(@"Reachable");
    CWInterface *wif = [[CWWiFiClient sharedWiFiClient] interface];
    NSLog(@"SSID: %@", wif.ssid);

    if ([wif.ssid isEqual:@"Chris's Access"]) {
      if (![AppListener setCurrentLocation:@"Work"]) {
        NSLog(@"Failed changing network location");
      }
    } else if ([wif.ssid isEqual:@"Chris Hoffman's Network"]) {
      if (![AppListener setCurrentLocation:@"Home"]) {
        NSLog(@"Failed changing network location");
      }
    } else if (![AppListener setCurrentLocation:@"Automatic"]) {
      NSLog(@"Failed changing network location");
    };
  };

  self.reach.unreachableBlock = ^(Reachability *reach) {
    NSLog(@"Unreachable");
  };

  [self.reach startNotifier];

  return self;
}

+(Boolean)setCurrentLocation:(NSString *)name {
  SCPreferencesRef prefs = SCPreferencesCreate(NULL, (CFStringRef)@"SystemConfiguration", NULL);
  Boolean ret = YES;

  SCNetworkSetRef set = SCNetworkSetCopyCurrent(prefs);
  NSString *curLocation = (NSString *)SCNetworkSetGetName(set);

  // Short circuit if the current location is the one we want to switch to
  if (![name isEqual:curLocation]) {
    // Get all locations
    NSArray *locations = (NSArray *)CFBridgingRelease(SCNetworkSetCopyAll(prefs));

    // Find the location that is the one we want to switch to and make it
    // current
    for (id item in locations) {
      NSString * locName = (NSString *)SCNetworkSetGetName((SCNetworkSetRef)item);
      if ([name isEqual:locName]) {
        NSLog(@"Setting Network Location to %@", locName);
        ret = SCNetworkSetSetCurrent((SCNetworkSetRef)item);
        break;
      }
    }
  } else {
    NSLog(@"Not changing location from %@ to %@", curLocation, name);
  }

  // Make the changes apply to the running system
  if (ret) {
    ret = SCPreferencesCommitChanges(prefs);
    if (ret) {
      ret = SCPreferencesApplyChanges(prefs);
    }
  }

  CFRelease(set);
  CFRelease(prefs);

  return ret;
}

-(void)shutdown {
  [self.reach stopNotifier];
}
@end

void terminate(int signum) {
  NSLog(@"Shutting down NetworkLocationChanger");
  [[AppListener sharedListener] shutdown];
  [[NSApplication sharedApplication] terminate:nil];
}

int main(int argc, char **argv) {
  signal(SIGTERM, terminate);
  signal(SIGINT, terminate);

  // Needed to use notification on application loading so the selector
  // version of listening for application deactivations doesn't complain
  // about release autopools that I can't setup when using ARC
  __block __weak id observer = [[NSNotificationCenter defaultCenter]
    addObserverForName:NSApplicationDidFinishLaunchingNotification
                object:nil
                  queue:nil
            usingBlock: ^(NSNotification *aNotification) {
              [[NSNotificationCenter defaultCenter] removeObserver:observer];

              [AppListener sharedListener];
            }];

  // Really wish I could figure out the run loop magic to make the hotkey
  // presses deliverable, but so far this is the only way I've found
  [NSApplication sharedApplication];
  [NSApp disableRelaunchOnLogin];
  [NSApp run];

  return EXIT_FAILURE;
}
