//
//  GRKSiblings.m
//
//  Created by   on 2017/07/25
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "GRKSiblings.h"


NSString *const kGRKSiblingsName = @"name";
NSString *const kGRKSiblingsDateOfBirth = @"dateOfBirth";


@interface GRKSiblings ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation GRKSiblings

@synthesize name = _name;
@synthesize dateOfBirth = _dateOfBirth;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.name = [self objectOrNilForKey:kGRKSiblingsName fromDictionary:dict];
            self.dateOfBirth = [self objectOrNilForKey:kGRKSiblingsDateOfBirth fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.name forKey:kGRKSiblingsName];
    [mutableDict setValue:self.dateOfBirth forKey:kGRKSiblingsDateOfBirth];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.name = [aDecoder decodeObjectForKey:kGRKSiblingsName];
    self.dateOfBirth = [aDecoder decodeObjectForKey:kGRKSiblingsDateOfBirth];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_name forKey:kGRKSiblingsName];
    [aCoder encodeObject:_dateOfBirth forKey:kGRKSiblingsDateOfBirth];
}

- (id)copyWithZone:(NSZone *)zone
{
    GRKSiblings *copy = [[GRKSiblings alloc] init];
    
    if (copy) {

        copy.name = [self.name copyWithZone:zone];
        copy.dateOfBirth = [self.dateOfBirth copyWithZone:zone];
    }
    
    return copy;
}


@end
