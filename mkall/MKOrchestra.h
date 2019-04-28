// Part of Measurement Kit <https://measurement-kit.github.io/>.
// Measurement Kit is free software under the BSD license. See AUTHORS
// and LICENSE for more information on the copying conditions.
#ifndef MKOrchestra_h
#define MKOrchestra_h

#import <Foundation/Foundation.h>

/// MKOrchestraResults is the result of running a orchestra operation.
@interface MKOrchestraResults : NSObject

/// good indicates whether the operation succeded.
-(BOOL)good;

/// logs returns logs useful to understand why the operation failed.
///
/// Logs consist of zero or more UTF-8 lines of text. In some cases
/// this method may also return nil.
-(NSString *)logs;

-(void)deinit;

@end  // interface MKOrchestraResults

/// MKOrchestraTask is a sync task for performing OONI orchestra operations.
@interface MKOrchestraTask : NSObject

-(id)init;

/// setAvailableBandwidth sets the available bandwidth.
///
/// This is the amount of bandwidth that a probe is willing
/// to consume for nettests.
-(void)setAvailableBandwidth:(NSString *)value;

/// setDeviceToken sets the device token.
///
/// This is a unique, per-device identifier that is required
/// to later send push notifications to a device.
-(void)setDeviceToken:(NSString *)value;

/// setLanguage sets the language used on the device.
-(void)setLanguage:(NSString *)value;

/// setNetworkType sets the type of network in which the device is.
-(void)setNetworkType:(NSString *)value;

/// setPlatform sets the platform of the device.
-(void)setPlatform:(NSString *)value;

/// setProbeASN sets the probe autonomous system number.
-(void)setProbeASN:(NSString *)value;

/// setProbeCC sets the probe country code.
-(void)setProbeCC:(NSString *)value;

/// setProbeFamily sets the probe family.
///
/// This is a string identifying related devices.
-(void)setProbeFamily:(NSString *)value;

/// setProbeTimezone sets the probe timezone.
-(void)setProbeTimezone:(NSString *)value;

/// setRegistryURL sets the URL of the OONI registry.
-(void)setRegistryURL:(NSString *)value;

/// setSecretsFile sets the path of the file where to store secrets.
///
/// This file is required to remember whether this probe has
/// already logged in with the registry or not.
-(void)setSecretsFile:(NSString *)value;

/// setSoftwareName sets the name of the application.
-(void)setSoftwareName:(NSString *)value;

/// setSoftwareVersion sets the version of the application.
-(void)setSoftwareVersion:(NSString *)value;

/// addSupportedTest adds a test to the set of supported tests.
-(void)addSupportedTest:(NSString *)value;

/// setTimeout sets the number of seconds after which an orchestra
/// operation by this client will be aborted.
-(void)setTimeout:(int64_t)timeout;

/// updateOrRegister will either register this probe with the OONI
/// registry or update its state tracked by the registry, using the
/// current value of the settings as tracked by this class.
///
/// Whether the operation is register or update depends on the
/// state stored inside the secret file: if we know we've registered
/// in the past, we update, otherwise we register.
-(MKOrchestraResults *)updateOrRegister;

-(void)deinit;

@end  // interface MKOrchestraTask

#endif /* MKOrchestra_h */
