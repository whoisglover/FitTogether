//
//  AppDelegate.swift
//  FitTogetherOne
//
//  Created by Danny Glover on 11/6/14.
//  Copyright (c) 2014 Glover LLC. All rights reserved.
//

import UIKit
import CloudKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var userData = FTUser()
    
    func getUserData() -> FTUser {
        return userData
    }

    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
                
        
        // Override point for customization after application launch.
        let userID : (isLoggedIn: Bool, value: String) = CloudKitInterface.fetchUserID()!
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        
        if userID.isLoggedIn == false{ // no icloud account
            
            println("returned from cloudkitInterface, logged in is false")
            let splashScreen = storyBoard.instantiateViewControllerWithIdentifier("splashScreen") as SplashScreenViewController
            
            // set alert to show
            splashScreen.noiCloudAccount()
            
            // set root
            self.window?.rootViewController = splashScreen
            
        }else { // icloud account logged in
            
            // save user recordID
            userData.cloudKitID = userID.value

            // check if user has already made account
            let userRecord : CKRecord? = CloudKitInterface.checkExistingUser(userID.value)
            
            if (userRecord == nil) { // new user
                self.window?.rootViewController = storyBoard.instantiateViewControllerWithIdentifier("userLogin") as? logInViewController
            } else { // returning user, log them in
                
                if (userRecord != nil) {
                    self.userData = FTUser(record: userRecord!)
                }
                
                self.window?.rootViewController = storyBoard.instantiateViewControllerWithIdentifier("rootNav") as? RootNavigationViewController
            }
            
        }
        
        
        application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes: UIUserNotificationType.Sound | UIUserNotificationType.Alert | UIUserNotificationType.Badge, categories: nil))
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

