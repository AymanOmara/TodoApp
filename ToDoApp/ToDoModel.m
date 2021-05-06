//
//  ToDoModel.m
//  ToDoApp
//
//  Created by Ayman Omara on 05/04/2021.
//

#import "ToDoModel.h"

@interface ToDoModel ()

@end

@implementation ToDoModel
//@synthesize name, descriptionModel, priority, reminderDate, craetDate, state;

-(id)initWithCoder:(NSCoder *)coder{
    
    if(self=[super init]){
        self.name=[coder decodeObjectForKey:@"name"];
        self.descriptionModel=[coder decodeObjectForKey:@"descriptionModel"];
        self.priority=[coder decodeObjectForKey:@"priority"];
        self.reminderDate=[coder decodeObjectForKey:@"reminderDate"];
        self.craetDate=[coder decodeObjectForKey:@"craetDate"];
        self.state=[coder decodeObjectForKey:@"state"];
    }
    
    
    return self;
}
- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.name forKey:@"name"];
    [coder encodeObject:self.descriptionModel forKey:@"descriptionModel"];
    [coder encodeObject:self.priority forKey:@"priority"];
    [coder encodeObject:self.craetDate forKey:@"craetDate"];
    [coder encodeObject:self.reminderDate forKey:@"reminderDate"];
    [coder encodeObject:self.state forKey:@"state"];
}

@end
