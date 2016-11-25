
#import "MedianFilter.h"

@implementation MedianFilter
{
    CIImage  *inputImage;
}

static CIKernel *testKernel = nil;

+ (void)registerFilter
{
    NSArray *filterCategories = @[kCICategoryColorAdjustment, kCICategoryVideo, kCICategoryStillImage,
                                  kCICategoryInterlaced, kCICategoryNonSquarePixels];
    
    NSDictionary *attributes = @{
                                 kCIAttributeFilterDisplayName : @"MedianFilter",
                                 kCIAttributeFilterCategories : filterCategories };
    
    [CIFilter registerFilterName:@"MedianFilter" constructor:(id <CIFilterConstructor>)self classAttributes:attributes];
}


+ (CIFilter *)filterWithName:(NSString *)name
{
    return [[self alloc] init];
}


- (id)init
{
    self = [super init];
    
    if (self) {
        
        if (testKernel == nil)
        {
            // Load the haze removal kernel.
            NSBundle *bundle = [NSBundle bundleForClass: [self class]];
            NSURL *kernelURL = [bundle URLForResource:@"MedianFilter" withExtension:@"cikernel"];
            
            NSError *error;
            NSString *kernelCode = [NSString stringWithContentsOfURL:kernelURL encoding:NSUTF8StringEncoding error:&error];
            if (kernelCode == nil) {
                NSLog(@"Error loading kernel code string in %@\n%@", NSStringFromSelector(_cmd), [error localizedDescription]);
                abort();
            }
            
            NSArray *kernels = [CIKernel kernelsWithString:kernelCode];
            testKernel = [kernels objectAtIndex:0];
        }
    }
    
    return self;
}


- (CIImage *)outputImage
{
    CISampler *src = [CISampler samplerWithImage: inputImage];
    return [self apply: testKernel, src, kCIApplyOptionDefinition, [src definition], nil];
}


- (NSDictionary *)customAttributes
{
    return @{
             kCIAttributeFilterName : @"MedianFilter"
             };
}

@end

