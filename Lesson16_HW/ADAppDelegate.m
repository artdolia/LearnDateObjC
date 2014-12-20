//
//  ADAppDelegate.m
//  Lesson16_HW
//
//  Created by A D on 12/29/13.
//  Copyright (c) 2013 AD. All rights reserved.
//

#import "ADAppDelegate.h"
#import "ADStudent.h"

@interface ADAppDelegate ()

//@property (strong, nonatomic) NSMutableArray *sortedStudents;
@property (strong, nonatomic) NSDate *floatingDate;
@property (strong, nonatomic) NSArray *sortedStudents;
@property (strong, nonatomic) NSCalendar *calendar;

@end

@implementation ADAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    /*************************** LEARNER LEVEL *******************************/
    
    NSMutableArray *students = [NSMutableArray array];
    
    for(int i = 0; i < 30; i++){
        
        //operate by the days to get enough differentiation in birgh dates
        NSInteger studentAge = ((arc4random()%12410 + 5840) * 86400);
        
        ADStudent *student = [[ADStudent alloc] init];
        student.name = [NSString stringWithFormat:@"Student%d",i+1];
        student.dateOfBirth = [NSDate dateWithTimeIntervalSinceNow:-studentAge];
        [students addObject:student];
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE, MMMM dd yyyy"];
    
    for(ADStudent *student in students){
        
        //NSLog(@"Student %@ was born on %@", student.name, [dateFormatter stringFromDate:student.dateOfBirth]);

    }
    
    /*************************** STUDENT LEVEL *******************************/
    
    
    NSArray *sortedStudents = [NSArray array];
    
    sortedStudents  = [students sortedArrayUsingComparator:^NSComparisonResult(ADStudent *obj1, ADStudent *obj2) {
        
        return [obj1.dateOfBirth compare:obj2.dateOfBirth];
        
        /*
        if([obj1.dateOfBirth earlierDate:obj2.dateOfBirth] == obj1.dateOfBirth){
            return NSOrderedAscending;
        }else if([obj1.dateOfBirth laterDate:obj2.dateOfBirth] == obj1.dateOfBirth){
            return NSOrderedDescending;
        }else {
            return NSOrderedSame;
        }
         */
        
    }];

    
    //NSLog(@"\n\nStudents sorted by the  date of birth: %@", sortedStudents);
    
    
    /*************************** MASTER LEVEL *******************************/
    /*
    
    //set properties for starting date (the age of the possible oldest student + day), calendar and students
    self.sortedStudents = sortedStudents;
    self.floatingDate = [NSDate dateWithTimeInterval:-86400 sinceDate:[[self.sortedStudents lastObject] dateOfBirth]];
    self.calendar = [NSCalendar currentCalendar];
    
    
    //find the age difference between the oldest and the yongest students
    NSDateComponents *differenceComponents = [self.calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay
                                                fromDate:[[self.sortedStudents firstObject] dateOfBirth]
                                                toDate:[[self.sortedStudents lastObject] dateOfBirth]
                                                options:0];

    NSLog(@"\nAge difference: %@", differenceComponents);
    
    //create and call the timer
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(studentBirthdayWithTimer:) userInfo:nil repeats:YES];
    
    [timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:2]];
    
     */
    
    /*************************** SUPERMAN LEVEL *******************************/

    self.calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year = 2013;
    components.month = 01;
    components.day = 01;
    NSDate *floatingDate = [self.calendar dateFromComponents:components];
    
    NSDateFormatter *dateFormatterWeekDay = [[NSDateFormatter alloc] init];
    [dateFormatterWeekDay setDateFormat:@"EEEE"];
    
    NSDateFormatter *dateFormatterMonth = [[NSDateFormatter alloc] init];
    [dateFormatterMonth setDateFormat:@"MMMM"];
    
    NSDateFormatter *dateFormatterDayMonth = [[NSDateFormatter alloc] init];
    [dateFormatterDayMonth setDateFormat:@"dd MMMM"];
    
    NSInteger workingDaysCounter = 0;
    NSInteger currentMonth = 1; //January
    NSDate *prevMonthDate = [[NSDate alloc] init];

    for(int i = 0; i < 365; i++){
        
        NSDateComponents *currentComponents = [self.calendar components:NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday
                                                               fromDate:floatingDate];
        if(currentComponents.month != currentMonth){
            
            prevMonthDate = [NSDate dateWithTimeInterval:-86400 sinceDate:floatingDate];
            
            NSLog(@"There are %ld working days in %@", (long)workingDaysCounter, [dateFormatterMonth stringFromDate:prevMonthDate]);
            
            currentMonth = currentComponents.month;
            workingDaysCounter = 0;
        }

        if(currentComponents.weekday != 1 && currentComponents.weekday !=7){
            workingDaysCounter ++;
        }
        
        if(currentComponents.day == 1){
            
            NSLog(@"The first day of %@ is %@", [dateFormatterMonth stringFromDate:floatingDate],
                  [dateFormatterWeekDay stringFromDate:floatingDate]);
        }

        if(currentComponents.weekday == 1){
            
            NSLog(@"%@ - %@", [dateFormatterWeekDay stringFromDate:floatingDate],
                  [dateFormatterDayMonth stringFromDate:floatingDate]);
        }

        floatingDate = [NSDate dateWithTimeInterval:86400 sinceDate:floatingDate];
    }

    prevMonthDate = [NSDate dateWithTimeInterval:-86400 sinceDate:floatingDate];
    NSLog(@"There are %ld working days in %@", (long)workingDaysCounter, [dateFormatterMonth stringFromDate:prevMonthDate]);
    
    return YES;
}

/*
- (void) studentBirthdayWithTimer:(NSTimer *) timer{
    
    //take the month and day components from floating date and from a student's birthday and compare
    NSDateComponents *floatingComponents = [self.calendar components: NSCalendarUnitMonth | NSCalendarUnitDay
                                            fromDate:self.floatingDate];

    for(ADStudent *student in self.sortedStudents){
        
        NSDateComponents *studentComponents = [self.calendar components: NSCalendarUnitMonth | NSCalendarUnitDay
                                               fromDate:student.dateOfBirth];
        
        if ([floatingComponents isEqual:studentComponents]) {
            
            NSLog(@"Happy Birthday %@", student.description);
        }
    }
    
    //invalidate the timer when rich current date or increment the date by one day
    if([self.floatingDate isEqualToDate:[NSDate date]]){
        
        [timer invalidate];
    
    }else{
        
        self.floatingDate = [NSDate dateWithTimeInterval:86400 sinceDate:self.floatingDate];
    }
}
*/

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
