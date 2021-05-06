//
//  MyProtocol.h
//  ToDoApp
//
//  Created by Ayman Omara on 09/04/2021.
//

#import <Foundation/Foundation.h>
#import "ToDoModel.h"
NS_ASSUME_NONNULL_BEGIN

@protocol MyProtocol <NSObject>
-(void)reciveData:(ToDoModel*)todo andnewtodo: (ToDoModel*)newTodo;


@end

NS_ASSUME_NONNULL_END
