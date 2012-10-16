/*
 * Copyright (C) 2012  Brian A. Mattern <rephorm@rephorm.com>.
 * All Rights Reserved.
 * This file is licensed under the GPLv2+.
 * Please see COPYING for more information
 */
#import <UIKit/UIKit.h>
#import "PasswordsViewController.h"
#import "PassDataController.h"
#import "PassEntry.h"
#import "PassEntryViewController.h"
#import <dirent.h>

@implementation PasswordsViewController

@synthesize entries;

- (void)viewDidLoad {
  [super viewDidLoad];
  if (self.title == nil)
    self.title = NSLocalizedString(@"Passwords", @"Password title");
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

  return [self.entries numEntries];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"EntryCell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
  }

  PassEntry *entry = [self.entries entryAtIndex:indexPath.row];

  cell.textLabel.text = entry.name;
  if (entry.is_dir)
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
  else
    cell.accessoryType = UITableViewCellAccessoryNone;

  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:NO];

  PassEntry *entry = [self.entries entryAtIndex:indexPath.row];

  if (entry.is_dir) {
    // push subdir view onto stack
    PasswordsViewController *subviewController = [[PasswordsViewController alloc] init];
    subviewController.entries = [[PassDataController alloc] initWithPath:entry.path];
    subviewController.title = entry.name;
    [[self navigationController] pushViewController:subviewController animated:YES];
    [subviewController release];
  } else {

    PassEntryViewController *detailController = [[PassEntryViewController alloc] init];
    detailController.entry = entry;
    [[self navigationController] pushViewController:detailController animated:YES];
    [detailController release];
  }
}

@end

