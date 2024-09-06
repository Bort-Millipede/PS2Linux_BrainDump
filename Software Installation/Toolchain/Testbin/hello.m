#include <objc/objc.h>
#include <objc/Object.h>
#include <objc/objc-api.h>

@interface HelloTest : Object
{
}
- (void)sayhello;
@end

@implementation HelloTest

- (void)sayhello
{
printf("Hello, world! From Objective-C!\n");
}
@end

main()
{
id myTestObj;

myTestObj = [[HelloTest alloc] init];

[myTestObj sayhello];
}
