Purpose
--------------

NSOperationQueue is a powerful tool for creating FIFO (First In, First Out) queues of background tasks. But sometimes it is preferable to have tasks executed in a LIFO (Last In, First Out) order instead.

For example, if your user is scrolling down a list of Facebook contacts in a UITableView, you might want to download the avatar icons for each contact as they scroll to avoid having to make them wait in advance whilst these are downloaded.

If you download these in FIFO order as the user scrolls (by adding them to an ordinary NSOperationQueue) they will still be waiting for the images at the top of the list to download when they reach the bottom. Consequently, the further the user scrolls, the worse the download performance will get because you are wasting cycles downloading images that have already scrolled off-screen instead of prioritising the ones that the user is looking at right now.

A LIFO queue (aka "stack") solves this problem. Each image would be added at the front of the queue, so at any given time, the avatar icon that has most recently scrolled into view will be the next to be downloaded.

NSOperationStack adds LIFO behaviour to NSOperationQueue. It provides two simple implementations:

1) A category that extends NSOperationQueue with methods to add tasks at the front of the queue instead of the back
2) An NSOperationQueue subclass that makes LIFO queuing the default behaviour


Supported iOS & SDK Versions
-----------------------------

* Supported build target - iOS 5.1 / Mac OS 10.7 (Xcode 4.3, Apple LLVM compiler 3.1)
* Earliest supported deployment target - iOS 4.3 / Mac OS 10.7
* Earliest compatible deployment target - iOS 4.0 / Mac OS 10.6

NOTE: 'Supported' means that the library has been tested with this version. 'Compatible' means that the library should work on this iOS version (i.e. it doesn't rely on any unavailable SDK features) but is no longer being tested for compatibility and may require tweaking or bug fixes to run correctly.


ARC Compatibility
------------------

NSOperationStack works with both ARC and non-ARC projects. There is no need to exclude NSOperationStack files from the ARC validation process, or to convert NSOperationStack using the ARC conversion tool.


Installation
---------------

To use NSOperationStack, just drag the class files into your project. If you include the NSOperationStack.h header in your class files or your prefix.pch file then every NSOperationQueue will automatically gain access to the LIFO queuing methods.


NSOperationQueue extension methods
-----------------------------------

These methods are made available on all NSOperationQueue instances via a category:

    - (void)addOperationAtFrontOfQueue:(NSOperation *)op;
    
Adds the specified operation to the front of the queue.
    
    - (void)addOperationsAtFrontOfQueue:(NSArray *)ops waitUntilFinished:(BOOL)wait;
    
Adds the specified operations to the front of the queue.
    
    - (void)addOperationAtFrontOfQueueWithBlock:(void (^)(void))block;
    
Creates a new NSOperation using the specified block and adds it to the front of the queue.


NSOperationStack class
-------------------------------

The NSOperationStack inherits all the methods from NSOperationQueue and does not add any new ones, however the following inherited methods are overridden to work in a LIFO fashion:

    - (void)addOperation:(NSOperation *)op;    
    - (void)addOperations:(NSArray *)ops waitUntilFinished:(BOOL)wait;    
    - (void)addOperationWithBlock:(void (^)(void))block;
    

Notes
----------------

NSOperationStack's execution order is not always strictly last-in, first-out due to concurrency. Any operations in the queue that are already executing will not be affected when you add a new operation, so in most cases the first operation added will still be executed first, and the LIFO queueing will only apply to subsequently added operations.

LIFO queuing becomes less significant for NSOperationQueues with a maxConcurrentOperationCount > 1. In the extreme case, for queues where the maxConcurrentOperationCount >= the number of operations in the queue, LIFO queuing will have no effect at all because every operation added to the queue will be executed immediately in parallel with all other operations.

Try varying the maxConcurrentOperationCount in the test application to see the effect it has on execution order. Note that since the operations in the example are completed almost immediately, you may get a more accurate picture of how queuing would work in a  real-life scenario by adding sleep(1) inside the test execution block.