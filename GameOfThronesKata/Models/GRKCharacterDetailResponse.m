//
//  GRKCharacterDetailResponse.m
//
//  Created by   on 2017/07/25
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "GRKCharacterDetailResponse.h"
#import "GRKSiblings.h"


NSString *const kGRKCharacterDetailResponseStatus = @"status";
NSString *const kGRKCharacterDetailResponseTitle = @"title";
NSString *const kGRKCharacterDetailResponseName = @"name";
NSString *const kGRKCharacterDetailResponseSiblings = @"siblings";


@interface GRKCharacterDetailResponse ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation GRKCharacterDetailResponse

@synthesize status = _status;
@synthesize title = _title;
@synthesize name = _name;
@synthesize siblings = _siblings;


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
            self.status = [self objectOrNilForKey:kGRKCharacterDetailResponseStatus fromDictionary:dict];
            self.title = [self objectOrNilForKey:kGRKCharacterDetailResponseTitle fromDictionary:dict];
            self.name = [self objectOrNilForKey:kGRKCharacterDetailResponseName fromDictionary:dict];
    NSObject *receivedGRKSiblings = [dict objectForKey:kGRKCharacterDetailResponseSiblings];
    NSMutableArray *parsedGRKSiblings = [NSMutableArray array];
    if ([receivedGRKSiblings isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedGRKSiblings) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedGRKSiblings addObject:[GRKSiblings modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedGRKSiblings isKindOfClass:[NSDictionary class]]) {
       [parsedGRKSiblings addObject:[GRKSiblings modelObjectWithDictionary:(NSDictionary *)receivedGRKSiblings]];
    }

    self.siblings = [NSArray arrayWithArray:parsedGRKSiblings];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.status forKey:kGRKCharacterDetailResponseStatus];
    [mutableDict setValue:self.title forKey:kGRKCharacterDetailResponseTitle];
    [mutableDict setValue:self.name forKey:kGRKCharacterDetailResponseName];
    NSMutableArray *tempArrayForSiblings = [NSMutableArray array];
    for (NSObject *subArrayObject in self.siblings) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForSiblings addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForSiblings addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForSiblings] forKey:kGRKCharacterDetailResponseSiblings];

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

    self.status = [aDecoder decodeObjectForKey:kGRKCharacterDetailResponseStatus];
    self.title = [aDecoder decodeObjectForKey:kGRKCharacterDetailResponseTitle];
    self.name = [aDecoder decodeObjectForKey:kGRKCharacterDetailResponseName];
    self.siblings = [aDecoder decodeObjectForKey:kGRKCharacterDetailResponseSiblings];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_status forKey:kGRKCharacterDetailResponseStatus];
    [aCoder encodeObject:_title forKey:kGRKCharacterDetailResponseTitle];
    [aCoder encodeObject:_name forKey:kGRKCharacterDetailResponseName];
    [aCoder encodeObject:_siblings forKey:kGRKCharacterDetailResponseSiblings];
}

- (id)copyWithZone:(NSZone *)zone
{
    GRKCharacterDetailResponse *copy = [[GRKCharacterDetailResponse alloc] init];
    
    if (copy) {

        copy.status = [self.status copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.siblings = [self.siblings copyWithZone:zone];
    }
    
    return copy;
}


@end
