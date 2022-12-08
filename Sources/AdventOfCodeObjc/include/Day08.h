#import <Foundation/Foundation.h>

@interface Day08: NSObject

- (void)run:(nonnull NSString *)path;
- (nonnull NSArray<NSArray<NSNumber *> *> *)aerialMapFromString:(nonnull NSString *)input;
- (nonnull NSNumber *)maxScenicScoreOfAerialMap:(nonnull NSArray<NSArray<NSNumber *> *> *)map;
- (nonnull NSArray<NSNumber *> *)visibleTreesInAerialMap:(nonnull NSArray<NSArray<NSNumber *> *> *)map;

@end