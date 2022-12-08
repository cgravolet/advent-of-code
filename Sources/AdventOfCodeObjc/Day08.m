#import "include/Day08.h"

@interface Day08 ()

@property (nonatomic, retain) NSString *input;

@end

@implementation Day08

@synthesize input = _input;

#pragma mark - Initialization

- (instancetype)initWithInput:(NSString *)input {
    self = [super init];
    if (self) {
        _input = input;
    }
    return self;
}

- (instancetype)initWithPath:(NSString *)path {
    NSString *contents = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    return [self initWithInput:contents];
}

#pragma mark - Lifecycle

- (void)run {
    NSArray *map = [self aerialMapFromString:self.input];
    NSArray *visibleTrees = [self visibleTreesInAerialMap:map];
    NSNumber *maxScore = [self maxScenicScoreInAerialMap:map];
    NSLog(@"Visible tree count (part 1): %ld", [visibleTrees count]);
    NSLog(@"Max scenic score (part 2): %ld", [maxScore integerValue]);
}

#pragma mark - Public methods

- (NSArray *)aerialMapFromString:(NSString *)input {
    NSCharacterSet *newLineSet = [NSCharacterSet newlineCharacterSet];
    NSArray *lines = [input componentsSeparatedByCharactersInSet:newLineSet];
    NSMutableArray *result = [[NSMutableArray alloc] init];

    for (NSString *line in lines) {
        NSMutableArray *row = [[NSMutableArray alloc] init];
        NSUInteger len = [line length];
        unichar buffer[len+1];
        [line getCharacters:buffer range:NSMakeRange(0, len)];

        for (int i = 0; i < len; ++i) {
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

- (NSNumber *)maxScenicScoreInAerialMap:(NSArray *)map {
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

#pragma mark - Private methods

- (BOOL)isItemAtRow:(NSInteger)row andSection:(NSInteger)section visibleInAerialMap:(NSArray *)map {
    NSNumber *tree = [[map objectAtIndex:section] objectAtIndex:row];

    // Check to the left
    BOOL visibleLeft = YES;
    for (NSInteger r = row - 1; r < row && r > -1; r--) {
        NSNumber *item = [[map objectAtIndex:section] objectAtIndex:r];
        if (item.integerValue >= tree.integerValue) {
            visibleLeft = NO;
            break;
        }
    }
    if (visibleLeft) return YES;

    // Check to the right
    BOOL visibleRight = YES;
    for (NSInteger r = row + 1; r < [[map objectAtIndex:section] count]; r++) {
        NSNumber *item = [[map objectAtIndex:section] objectAtIndex:r];
        if (item.integerValue >= tree.integerValue) {
            visibleRight = NO;
            break;
        }
    }
    if (visibleRight) return YES;

    // Check above
    BOOL visibleAbove = YES;
    for (NSInteger s = section - 1; s < section && s > -1; s--) {
        NSNumber *item = [[map objectAtIndex:s] objectAtIndex:row];
        if (item.integerValue >= tree.integerValue) {
            visibleAbove = NO;
            break;
        }
    }
    if (visibleAbove) return YES;

    // Check below
    BOOL visibleBelow = YES;
    for (NSInteger s = section + 1; s < [map count]; s++) {
        NSNumber *item = [[map objectAtIndex:s] objectAtIndex:row];
        if (item.integerValue >= tree.integerValue) {
            visibleBelow = NO;
            break;
        }
    }
    return visibleBelow;
}

- (NSInteger)scenicScoreOfItemAtRow:(NSInteger)row andSection:(NSInteger)section inAerialMap:(NSArray *)map {
    NSNumber *tree = [[map objectAtIndex:section] objectAtIndex:row];
    NSInteger left = 0;
    NSInteger right = 0;
    NSInteger above = 0;
    NSInteger below = 0;

    // Count visible trees to the left
    for (NSInteger r = row - 1; r < row && r > -1; r--) {
        NSNumber *item = [[map objectAtIndex:section] objectAtIndex:r];
        left++;
        if (item.integerValue >= tree.integerValue) {
            break;
        }
    }

    // Count visible trees to the right
    for (NSInteger r = row + 1; r < [[map objectAtIndex:section] count]; r++) {
        NSNumber *item = [[map objectAtIndex:section] objectAtIndex:r];
        right++;
        if (item.integerValue >= tree.integerValue) {
            break;
        }
    }

    // Count visible trees above
    for (NSInteger s = section - 1; s < section && s > -1; s--) {
        NSNumber *item = [[map objectAtIndex:s] objectAtIndex:row];
        above++;
        if (item.integerValue >= tree.integerValue) {
            break;
        }
    }

    // Count visible trees below
    for (NSInteger s = section + 1; s < [map count]; s++) {
        NSNumber *item = [[map objectAtIndex:s] objectAtIndex:row];
        below++;
        if (item.integerValue >= tree.integerValue) {
            break;
        }
    }
    return left * right * above * below;
}

@end
