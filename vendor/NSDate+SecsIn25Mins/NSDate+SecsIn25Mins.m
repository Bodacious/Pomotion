#import "NSDate+SecsIn25Mins.h"
 
@implementation NSDate (SecsIn25Mins)
+ (int) secsIn25Mins 
{ 
  return TARGET_IPHONE_SIMULATOR ? 10 : 1500;
}
@end