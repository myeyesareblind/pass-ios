@class PassEntry;

@interface PassDataController : NSObject
- (id)initWithPath:(NSString *)path;
- (unsigned)numEntries;
- (PassEntry *)entryAtIndex:(unsigned)index;
@end
