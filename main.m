/*
 * Copyright (C) 2012  Brian A. Mattern <rephorm@rephorm.com>.
 * All Rights Reserved.
 * This file is licensed under the GPLv2+.
 * Please see COPYING for more information
 */
int main(int argc, char **argv) {
	NSAutoreleasePool *p = [[NSAutoreleasePool alloc] init];
	int ret = UIApplicationMain(argc, argv, @"passwordstoreApplication", @"passwordstoreApplication");
	[p drain];
	return ret;
}

// vim:ft=objc
