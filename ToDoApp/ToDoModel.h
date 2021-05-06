//
//  ToDoModel.h
//  ToDoApp
//
//  Created by Ayman Omara on 05/04/2021.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ToDoModel : UIViewController <NSCoding>

@property NSString *name;
@property NSString *descriptionModel;
@property NSString *priority;
@property NSString *reminderDate;
@property NSString *craetDate;
@property NSString *state;
@property NSMutableArray *filteredList;

@end

NS_ASSUME_NONNULL_END
