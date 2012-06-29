//
//  main.m
//  NSOperationStackTests
//
//  Created by Nick Lockwood on 29/06/2012.
//  Copyright (c) 2012 Charcoal Design. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSOperationStack.h"

int main(int argc, const char * argv[])
{
    @autoreleasepool
    {
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        [queue setMaxConcurrentOperationCount:1];
        
        NSLog(@"Testing NSOperationQueue...");
        for (int i = 0; i < 10; i++)
        {
            [queue addOperationWithBlock:^{
                
                NSLog(@"Operation number %i", i);
            }];
        }
        
        
        //pause between runs
        sleep(1);
        
        
        NSLog(@"Testing NSOperationQueue+LIFO...");
        for (int i = 0; i < 10; i++)
        {
            [queue addOperationAtFrontOfQueueWithBlock:^{
                
                NSLog(@"Operation number %i", i);
            }];
        }
        
        
        //pause between runs
        sleep(1);
        
        
        NSOperationQueue *stack = [[NSOperationStack alloc] init];
        [stack setMaxConcurrentOperationCount:1];
        
        NSLog(@"Testing NSOperationStack...");
        for (int i = 0; i < 10; i++)
        {
            [stack addOperationWithBlock:^{
                
                NSLog(@"Operation number %i", i);
            }];
        }
        
        //prevent app from finishing early
        sleep(1);
    }
    return 0;
}

