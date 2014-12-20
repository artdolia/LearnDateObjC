//
//  ADStudent.m
//  Lesson16_HW
//
//  Created by A D on 12/29/13.
//  Copyright (c) 2013 AD. All rights reserved.
//

#import "ADStudent.h"

@implementation ADStudent

@synthesize dateOfBirth = _dateOfBirth;
@synthesize name = _name;


-(NSString*) description{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE, MMMM dd yyyy"];
    
    return [NSString stringWithFormat:@"%@ - %@", self.name, [dateFormatter stringFromDate:self.dateOfBirth]];
    
}

@end
