//
//  FTNotifications.swift
//  FitTogetherOne
//
//  Created by Joshua O'Steen on 12/7/14.
//  Copyright (c) 2014 Glover LLC. All rights reserved.
//

import UIKit

class FTNotifications: NSObject {
   
    class func attainedDailyGoal(dailyGoal: Int) {
        
        var dailyGoalAttainedNotification = UILocalNotification()
        
        dailyGoalAttainedNotification.alertBody = "Yay! You reached your daily goal of \(dailyGoal). Way to step up!"
        dailyGoalAttainedNotification.alertAction = "up the ante"
        dailyGoalAttainedNotification.fireDate = NSDate(timeIntervalSinceNow: 10)
        UIApplication.sharedApplication().scheduleLocalNotification(dailyGoalAttainedNotification)
    }
    
    
    
    
}
