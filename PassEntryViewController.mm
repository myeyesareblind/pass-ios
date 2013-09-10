/*
 * Copyright (C) 2012  Brian A. Mattern <rephorm@rephorm.com>.
 * All Rights Reserved.
 * This file is licensed under the GPLv2+.
 * Please see COPYING for more information
 */
#import "PassEntryViewController.h"
#import "PassEntry.h"
#import "PDKeychainBindings.h"

@interface PassEntryViewController()

@property (nonatomic,retain) NSString *passphrase;
//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
- (void)requestPassphrase;
- (void)copyName;
- (BOOL)copyPass;
- (PDKeychainBindings *)keychain;

@end
  

@implementation PassEntryViewController
@synthesize entry;
@synthesize passphrase;

- (PDKeychainBindings *)keychain {
  return [PDKeychainBindings sharedKeychainBindings];
}

- (void)viewDidLoad {
  [super viewDidLoad];
//  self.title = NSLocalizedString(@"Passwords", @"Password title");
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 2;
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
      self.passphrase = [[self keychain] stringForKey:@"passphrase"];
      if (self.passphrase == nil) {
        [self requestPassphrase];
      } else {
        [self copyPass];
      }
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
    [[self keychain] removeObjectForKey:@"passphrase"];

    return NO;
  } else {
    [UIPasteboard generalPasteboard].string = pass;
    return YES;
  }
}

- (void)requestPassphrase {
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Passphrase" message:@"Enter passphrase for gpg key" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
  alert.alertViewStyle = UIAlertViewStyleSecureTextInput;
  [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
  if (buttonIndex == 1) {
    self.passphrase = [alertView textFieldAtIndex:0].text;
    [[self keychain] setObject:self.passphrase forKey:@"passphrase"];
    if (![self copyPass]) {
      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Passphrase" message:@"Passphrase invalid" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
      [alert show];
    }
  }
}

@end
