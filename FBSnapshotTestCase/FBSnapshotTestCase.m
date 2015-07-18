/*
 *  Copyright (c) 2015, Facebook, Inc.
 *  All rights reserved.
 *
 *  This source code is licensed under the BSD-style license found in the
 *  LICENSE file in the root directory of this source tree. An additional grant
 *  of patent rights can be found in the PATENTS file in the same directory.
 *
 */

#import <FBSnapshotTestCase/FBSnapshotTestCase.h>
#import <FBSnapshotTestCase/FBSnapshotTestController.h>

@implementation FBSnapshotTestCase
{
  FBSnapshotTestController *_snapshotController;
}

#pragma mark - Overrides

- (void)setUp
{
  [super setUp];
  _snapshotController = [[FBSnapshotTestController alloc] initWithTestName:NSStringFromClass([self class])];
}

- (void)tearDown
{
  _snapshotController = nil;
  [super tearDown];
}

- (BOOL)recordMode
{
  return _snapshotController.recordMode;
}

- (void)setRecordMode:(BOOL)recordMode
{
  NSAssert1(_snapshotController, @"%s cannot be called before [super setUp]", __FUNCTION__);
  _snapshotController.recordMode = recordMode;
}

#pragma mark - Public API

- (BOOL)compareSnapshotOfLayer:(CALayer *)layer
      referenceImagesDirectory:(NSString *)referenceImagesDirectory
                    identifier:(NSString *)identifier
                     tolerance:(CGFloat)tolerance
                         error:(NSError **)errorPtr
{
  return [self _compareSnapshotOfViewOrLayer:layer
                    referenceImagesDirectory:referenceImagesDirectory
                                  identifier:identifier
                                   tolerance:tolerance
                                       error:errorPtr];
}

- (BOOL)compareSnapshotOfView:(UIView *)view
     referenceImagesDirectory:(NSString *)referenceImagesDirectory
                   identifier:(NSString *)identifier
                    tolerance:(CGFloat)tolerance
                        error:(NSError **)errorPtr
{
  return [self _compareSnapshotOfViewOrLayer:view
                    referenceImagesDirectory:referenceImagesDirectory
                                  identifier:identifier
                                   tolerance:tolerance
                                       error:errorPtr];
}

#pragma mark - Private API

- (BOOL)_compareSnapshotOfViewOrLayer:(id)viewOrLayer
             referenceImagesDirectory:(NSString *)referenceImagesDirectory
                           identifier:(NSString *)identifier
                            tolerance:(CGFloat)tolerance
                                error:(NSError **)errorPtr
{
  _snapshotController.referenceImagesDirectory = referenceImagesDirectory;
  return [_snapshotController compareSnapshotOfViewOrLayer:viewOrLayer
                                                  selector:self.invocation.selector
                                                identifier:identifier
                                                 tolerance:tolerance
                                                     error:errorPtr];
}

@end
