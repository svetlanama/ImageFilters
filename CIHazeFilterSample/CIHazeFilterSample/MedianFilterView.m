

#import "MedianFilterView.h"
#import "MedianFilter.h"

@interface MedianFilterView ()

@property (nonatomic, strong) CIFilter *filter;

@end

@implementation MedianFilterView


- (CIFilter *)filter
{
    if (_filter == nil) {
        
        // Make sure initialize is called. This should only be done once
        [MedianFilter registerFilter];
        
        NSURL *imageURL = [[NSBundle mainBundle] URLForResource:@"CraterLake" withExtension:@"jpg"];
        CIImage *image = [CIImage imageWithContentsOfURL:imageURL];

        _filter =  [CIFilter filterWithName: @"MedianFilter" keysAndValues:@"inputImage", image , nil];

    }
    return _filter;
}

- (void)drawRect:(NSRect)rect
{
  CIContext* context = [[NSGraphicsContext currentContext] CIContext];
 
 	if (context != nil) {
        
        CIFilter *filter = self.filter;
        CGRect drawRect = CGRectMake(NSMinX(rect), NSMinY(rect), NSWidth(rect), NSHeight(rect));

        CIImage *image = [filter valueForKey:@"outputImage"];
		[context drawImage:image atPoint:drawRect.origin fromRect:drawRect];
    }
}

@end


