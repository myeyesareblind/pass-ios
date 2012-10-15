@interface PassEntry : NSObject {
  NSString *name;
}

@property (nonatomic,retain) NSString *name;
@property (nonatomic,retain) NSString *path;
@property (nonatomic,assign) BOOL is_dir;
@property (nonatomic,readonly) NSString *pass;

- (NSString *)passWithPassphrase:(NSString *)passphrase;

@end
