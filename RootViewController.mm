/*
 * Copyright (C) 2012  Brian A. Mattern <rephorm@rephorm.com>.
 * All Rights Reserved.
 * This file is licensed under the GPLv2+.
 * Please see COPYING for more information
 */
#import "RootViewController.h"

@implementation RootViewController
- (void)loadView {
	self.view = [[[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]] autorelease];
	self.view.backgroundColor = [UIColor redColor];
}
@end
