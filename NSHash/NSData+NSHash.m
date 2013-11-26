//
//  Copyright 2012 Christoph Jerolimov
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License
//

#import "NSData+NSHash.h"

#import <CommonCrypto/CommonDigest.h>

@implementation NSData (NSHash_AdditionalHashingAlgorithms)

- (NSData*) MD5 {
	NSUInteger outputLength = CC_MD5_DIGEST_LENGTH;
	unsigned char output[outputLength];
	
	CC_MD5(self.bytes, (CC_LONG) self.length, output);
	return [NSData dataWithBytes:output length:outputLength];
}

- (NSString*) MD5String {
    NSData *MD5Data = [self MD5];
    NSString *MD5String = [self toHexString:[MD5Data bytes] length:[MD5Data length]];
    
    return MD5String;
}

- (NSData*) SHA1 {
	NSUInteger outputLength = CC_SHA1_DIGEST_LENGTH;
	unsigned char output[outputLength];
	
	CC_SHA1(self.bytes, (CC_LONG) self.length, output);
	return [NSData dataWithBytes:output length:outputLength];
}

- (NSString*) SHA1String {
    NSData *SHA1Data = [self SHA1];
    NSString *SHA1String = [self toHexString:[SHA1Data bytes] length:[SHA1Data  length]];
    
    return SHA1String;
}

- (NSData*) SHA256 {
	NSUInteger outputLength = CC_SHA256_DIGEST_LENGTH;
	unsigned char output[outputLength];
	
	CC_SHA256(self.bytes, (CC_LONG) self.length, output);
	return [NSData dataWithBytes:output length:outputLength];
}

- (NSString*) SHA256String {
    NSData *SHA256Data = [self SHA256];
    NSString *SHA256String = [self toHexString:[SHA256Data bytes] length:[SHA256Data  length]];
    
    return SHA256String;
}

- (NSString*) toHexString:(void const*) data length: (NSUInteger) length {
	NSMutableString* hash = [NSMutableString stringWithCapacity:length * 2];
	for (NSUInteger i = 0; i < length; i++) {
		[hash appendFormat:@"%02x", ((uint8_t *)data)[i]];
		((uint8_t *)data)[i] = 0;
	}
	return hash;
}

@end
