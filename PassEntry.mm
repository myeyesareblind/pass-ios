/*
 * Copyright (C) 2012  Brian A. Mattern <rephorm@rephorm.com>.
 * All Rights Reserved.
 * This file is licensed under the GPLv2+.
 * Please see COPYING for more information
 */
#import "PassEntry.h"
#import <Foundation/NSTask.h>

@implementation PassEntry

@synthesize name, path, is_dir, pass;

- (NSString *)name
{
  if ([name hasSuffix:@".gpg"])
    return [name substringToIndex:[name length] - 4];
  else
    return name;
}

- (NSString *)passWithPassphrase:(NSString *)passphrase
{
  NSTask *task = [[NSTask alloc] init];
  [task setLaunchPath:@"/usr/bin/gpg"];
  [task setArguments:[NSArray arrayWithObjects:
                        @"--passphrase",passphrase,@"-d",@"--batch",
                        @"--quiet",@"--no-tty",self.path,nil]];

  NSPipe *opipe = [NSPipe pipe];
  [task setStandardOutput:opipe];

  [task launch];
  [task waitUntilExit];

  int status = [task terminationStatus];

  [task release];

  if (status == 0) {
    NSFileHandle *ofile = [opipe fileHandleForReading];
    NSData *data = [ofile readDataToEndOfFile];
    NSString *str= [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    // return first line of file 
    return [[str componentsSeparatedByString:@"\n"] objectAtIndex:0];
  } else {
    // XXX handle error
    return nil;
  }
}

@end

