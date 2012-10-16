/*
 * Copyright (C) 2012  Brian A. Mattern <rephorm@rephorm.com>.
 * All Rights Reserved.
 * This file is licensed under the GPLv2+.
 * Please see COPYING for more information
 */
#import "PassDataController.h"
#import "PassEntry.h"
#import <dirent.h>

@interface PassDataController ()

@property (nonatomic, copy, readwrite) NSMutableArray *entries;

- (void) readEntries:(NSString *)path;

@end

@implementation PassDataController

@synthesize entries;

- (id)initWithPath:(NSString *)path {
  if ( (self = [super init]) ) {
    [self readEntries:path];
  }

  return self;
}

- (void)readEntries:(NSString *)path {
  DIR *d;
  struct dirent *dent;
  PassEntry *entry;

  NSMutableArray *list = [[NSMutableArray alloc] init];

  d = opendir([path cStringUsingEncoding:NSUTF8StringEncoding]);
  if (!d) {
    // XXX handle error!
    return;
  }

  while ( (dent = readdir(d)) ) {
    if (dent->d_name[0] == '.') continue; // skip hidden files

    entry = [[PassEntry alloc] init];
    entry.name = [NSString stringWithCString:dent->d_name];
    entry.path = [NSString stringWithFormat:@"%@/%s", path, dent->d_name];
    entry.is_dir = (dent->d_type == DT_DIR ? YES : NO);

    [list addObject:entry];
  }

  self.entries = list;
}

- (unsigned) numEntries {
  return [self.entries count];
}

- (PassEntry *)entryAtIndex:(unsigned)index {
  return [self.entries objectAtIndex:index];
}

@end
