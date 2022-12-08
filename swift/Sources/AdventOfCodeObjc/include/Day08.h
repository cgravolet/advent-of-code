#import <Foundation/Foundation.h>

@interface Day08: NSObject

- (nonnull instancetype)initWithInput:(nonnull NSString *)input;
- (nonnull instancetype)initWithPath:(nonnull NSString *)path;
- (void)run;
- (nonnull NSArray<NSArray<NSNumber *> *> *)aerialMapFromString:(nonnull NSString *)input;
- (nonnull NSNumber *)maxScenicScoreInAerialMap:(nonnull NSArray<NSArray<NSNumber *> *> *)map;
- (nonnull NSArray<NSNumber *> *)visibleTreesInAerialMap:(nonnull NSArray<NSArray<NSNumber *> *> *)map;

@end