#import "PasswordsViewController.h"
#import "PassDataController.h"
#import "PDKeychainBindings.h"

#define PASS_DIR @"/var/mobile/.password-store"

@interface passwordstoreApplication: UIApplication <UIApplicationDelegate> {
	UIWindow *_window;
	PasswordsViewController *_viewController;
  PassDataController *_entries;
}
@property (nonatomic, retain) UIWindow *window;
@end

@implementation passwordstoreApplication
@synthesize window = _window;
- (void)applicationDidFinishLaunching:(UIApplication *)application {
	_window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  _entries = [[PassDataController alloc] initWithPath:PASS_DIR];


	_viewController = [[PasswordsViewController alloc] init];
  _viewController.entries = _entries;

  UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:_viewController];

	//[_window addSubview:_viewController.view];
	[_window addSubview:navigationController.view];
	[_window makeKeyAndVisible];
}

- (void)applicationWillTerminate:(UIApplication *)application {
  // remove passphrase on app exit for now
  NSLog(@"App will terminate");
  [[PDKeychainBindings sharedKeychainBindings] removeObjectForKey:@"passphrase"];
}

- (void)dealloc {
	[_viewController release];
	[_window release];
	[super dealloc];
}
@end

// vim:ft=objc
