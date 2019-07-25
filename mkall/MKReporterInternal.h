// Part of Measurement Kit <https://measurement-kit.github.io/>.
// Measurement Kit is free software under the BSD license. See AUTHORS
// and LICENSE for more information on the copying conditions.
#ifndef MKReporterInternal_h
#define MKReporterInternal_h

// Internal file containing interfaces used for testing.

#import "MKReporter.h"
#import "vendor/mkcollector.hpp"

using MKReporterStats = mk::collector::Reporter::Stats;

@interface MKReporterTask ()

-(MKReporterResults *)submitWithMeasurement:(NSString *)measurement
                              uploadTimeout:(int64_t)timeout
                                      stats:(MKReporterStats *)pstats;

@end // @interface MKReporterTask

#endif /* MKReporterInternal_h */
