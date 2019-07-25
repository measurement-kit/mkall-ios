// Part of Measurement Kit <https://measurement-kit.github.io/>.
// Measurement Kit is free software under the BSD license. See AUTHORS
// and LICENSE for more information on the copying conditions.
#ifndef MKGeoIPLookup_h
#define MKGeoIPLookup_h

#import <Foundation/Foundation.h>

/// MKGeoIPLookupResults contains the results of a GeoIP lookup.
///
/// We define GeoIP lookup the process with which we find
/// the probe's IP address, and the related country code (CC),
/// autonomous system number (ASN), and commercial name
/// bound to the ASN (Org).
@interface MKGeoIPLookupResults : NSObject

/// good indicates whether the lookup was successful.
///
/// If the lookup was not successful, check the logs for
/// more information on what have failed.
-(BOOL)good;

/// probeIP returns the probe IP.
///
/// This will be either an IPv4 or IPv6 address. When we
/// don't know the probe IP, we return 127.0.0.1. Note
/// that the return value may also be nil.
-(NSString *)probeIP;

/// probeASN returns the probe ASN.
///
/// This is a string like `AS{number}` where `{number`}
/// is the ASN. When we don't know the ASN we return
/// `AS0`. Note that the return value may also be nil.
-(NSString *)probeASN;

/// probeCC returns the probe CC.
///
/// This the two letter country name code, e.g. `IT`. When
/// we don't know the country code, we return `ZZ`. Note
/// that the return value may also be nil.
-(NSString *)probeCC;

/// probeOrg returns the commercial name bound to the ASN.
///
/// When we don't know it, we return an empty string. Note
/// that the return value may also be nil.
-(NSString *)probeOrg;

/// logs returns the GeoIP lookup logs.
///
/// The logs consist of zero or more UTF-8 lines providing
/// information useful to debug why we failed. Note that the
/// return value may also be nil.
-(NSString *)logs;

@end  // interface MKGeoIPLookupResults

/// MKGeoIPLookupTask is a sync task performing a GeoIP lookup.
@interface MKGeoIPLookupTask : NSObject

/// setTimeout sets the number of seconds after which a pending
/// GeoIP lookup attempt is aborted by MK.
-(void)setTimeout:(int64_t)timeout;

/// perform performs a GeoIP lookup with current settings.
///
/// Returns an object describing the lookup results. Note that
/// the return value may also be nil.
-(MKGeoIPLookupResults *)perform;

@end  // interface MKGeoIPLookupTask

#endif /* MKGeoIPLookup_h */
