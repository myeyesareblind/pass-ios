/*
 * Copyright (C) 2012  Brian A. Mattern <rephorm@rephorm.com>.
 * All Rights Reserved.
 * This file is licensed under the GPLv2+.
 * Please see COPYING for more information
 */
@class PassEntry;

@interface PassDataController : NSObject
- (id)initWithPath:(NSString *)path;
- (unsigned)numEntries;
- (PassEntry *)entryAtIndex:(unsigned)index;
@end
