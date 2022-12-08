#import "include/Day08.h"

@implementation Day08

- (void)run:(NSString *)path {
    NSString *input = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSArray *map = [self aerialMapFromString:input];
    NSArray *visibleTrees = [self visibleTreesInAerialMap:map];
    NSNumber *maxScore = [self maxScenicScoreOfAerialMap:map];
    NSLog(@"Visible tree count (part 1): %ld", [visibleTrees count]);
    NSLog(@"Max scenic score (part 2): %ld", [maxScore integerValue]);
}

- (NSArray *)aerialMapFromString:(NSString *)input {
    NSCharacterSet *newLineSet = [NSCharacterSet newlineCharacterSet];
    NSArray *lines = [input componentsSeparatedByCharactersInSet:newLineSet];
    NSMutableArray *result = [[NSMutableArray alloc] init];

    for (NSString *line in lines) {
        NSMutableArray *row = [[NSMutableArray alloc] init];
        NSUInteger len = [line length];
        unichar buffer[len+1];
        [line getCharacters:buffer range:NSMakeRange(0, len)];

        for (int i = 0; i < len; i++) {
            NSString *str = [NSString stringWithFormat:@"%C", buffer[i]];
            NSNumber *num = [NSNumber numberWithInteger:[str integerValue]];
            [row addObject:num];
        }
        if ([row count] > 0) {
            [result addObject:row];
        }
    }
    return  [result copy];
}

- (nonnull NSNumber *)maxScenicScoreOfAerialMap:(nonnull NSArray<NSArray<NSNumber *> *> *)map {
    NSInteger maxScore = 0;

    for (NSInteger i = 0; i < [map count]; i++) {
        for (NSInteger j = 0; j < [[map objectAtIndex:i] count]; j++) {
            NSInteger scenicScore = [self scenicScoreOfItemAtRow:j andSection:i inAerialMap:map];
            if (scenicScore > maxScore) {
                maxScore = scenicScore;
            }
        }
    }
    return [NSNumber numberWithInteger:maxScore];
}

- (NSArray *)visibleTreesInAerialMap:(NSArray *)map {
    NSMutableArray *result = [[NSMutableArray alloc] init];

    for (NSInteger i = 0; i < [map count]; i++) {
        for (NSInteger j = 0; j < [[map objectAtIndex:i] count]; j++) {
            if ([self isItemAtRow:j andSection:i visibleInAerialMap:map]) {
                NSNumber *item = [[map objectAtIndex:i] objectAtIndex:j];
                [result addObject:item];
            }
        }
    }
    return result;
}

- (BOOL)isItemAtRow:(NSInteger)row andSection:(NSInteger)section visibleInAerialMap:(NSArray *)map {
    NSNumber *tree = [[map objectAtIndex:section] objectAtIndex:row];

    // Check to the left
    BOOL visibleLeft = YES;
    for (NSInteger r = 0; r < row; r++) {
        NSNumber *item = [[map objectAtIndex:section] objectAtIndex:r];
        if (item.integerValue >= tree.integerValue) {
            visibleLeft = NO;
            break;
        }
    }
    if (visibleLeft) return YES;

    // Check to the right
    BOOL visibleRight = YES;
    if (row < [[map objectAtIndex:section] count] - 1) {
        for (NSInteger r = row + 1; r < [[map objectAtIndex:section] count]; r++) {
            NSNumber *item = [[map objectAtIndex:section] objectAtIndex:r];
            if (item.integerValue >= tree.integerValue) {
                visibleRight = NO;
                break;
            }
        }
    }
    if (visibleRight) return YES;

    // Check above
    BOOL visibleAbove = YES;
    for (NSInteger s = 0; s < section; s++) {
        NSNumber *item = [[map objectAtIndex:s] objectAtIndex:row];
        if (item.integerValue >= tree.integerValue) {
            visibleAbove = NO;
            break;
        }
    }
    if (visibleAbove) return YES;

    // Check below
    BOOL visibleBelow = YES;
    if (section < [map count] - 1) {
        for (NSInteger s = section + 1; s < [map count]; s++) {
            NSNumber *item = [[map objectAtIndex:s] objectAtIndex:row];
            if (item.integerValue >= tree.integerValue) {
                return NO;
            }
        }
    }
    return YES;
}

- (NSInteger)scenicScoreOfItemAtRow:(NSInteger)row andSection:(NSInteger)section inAerialMap:(NSArray *)map {
    NSNumber *tree = [[map objectAtIndex:section] objectAtIndex:row];
    return 0; // TODO
}

@end
