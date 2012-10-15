#import "PassEntryViewController.h"
#import "PassEntry.h"

@interface UIAlertView()
- (UITextField *)textFieldAtIndex:(NSInteger)textFieldIndex;
@property (nonatomic,assign) unsigned alertViewStyle;
@end

@interface PassEntryViewController()

@property (nonatomic,retain) NSString *passphrase;
//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
- (void)requestPassphrase;
- (void)copyName;
- (BOOL)copyPass;

@end
  

@implementation PassEntryViewController
@synthesize entry;
@synthesize passphrase;

- (void)viewDidLoad {
  [super viewDidLoad];
//  self.title = NSLocalizedString(@"Passwords", @"Password title");
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"EntryDetailCell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier] autorelease];
  }

  switch(indexPath.row) {
    case 0:
      cell.textLabel.text = @"Name";
      cell.detailTextLabel.text = self.entry.name;
      break;
    case 1:
      cell.textLabel.text = @"Password";
      cell.detailTextLabel.text = @"********";
      break;
    default:
      break;
  }

  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];

  switch(indexPath.row) {
    case 0:
      [self copyName];
      break;
    case 1:
      [self requestPassphrase];
      break;
    default:
      break;
  }
}

- (void)copyName {
  [UIPasteboard generalPasteboard].string = self.entry.name;
}

- (BOOL)copyPass {
  NSString *pass = [self.entry passWithPassphrase:self.passphrase];
  if (pass == nil) {
    return NO;
  } else {
    [UIPasteboard generalPasteboard].string = pass;
    return YES;
  }
}

- (void)requestPassphrase {
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Passphrase" message:@"Enter passphrase for gpg key" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
  alert.alertViewStyle = 1;
  [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
  if (buttonIndex == 1) {
    self.passphrase = [alertView textFieldAtIndex:0].text;
    NSLog(@"Passphrase: %@", self.passphrase);
    if (![self copyPass]) {
      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Passphrase" message:@"Passphrase invalid" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
      [alert show];
    }
  }
}

@end
