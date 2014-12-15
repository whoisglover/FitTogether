//
//  CloudKitInterface.swift
//  FitTogetherOne
//
//  Created by Joshua O'Steen on 12/11/14.
//  Copyright (c) 2014 Glover LLC. All rights reserved.
//

import UIKit
import CloudKit

class CloudKitInterface: NSObject {
    

    let container : CKContainer?
    let publicDB : CKDatabase?
    var userID : String?
    
    
    override init() {
        super.init()
        
        container = CKContainer.defaultContainer()
        publicDB = container?.publicCloudDatabase

    
    }
    
    class func checkUniqueUsername(username: String) -> Bool {
        
        var isUnique = false
        var returned = false
        
        let publicDB = CKContainer.defaultContainer().publicCloudDatabase
        
        let usernamePredicate = NSPredicate(format: "name = %@", username)
        let uniqueNameQuery = CKQuery(recordType: "User", predicate: usernamePredicate)
        
        publicDB.performQuery(uniqueNameQuery, inZoneWithID: nil) { (records, error) -> Void in
            
            if (error != nil) {
                println("unique username check went wrong")
                println(error.localizedDescription)
            }
            
            if (records.count == 0) {
                isUnique = true
            }
            
            returned = true
            
        }
        
        while (!returned) {
            // do nothing
        }
        
        return isUnique
    }
    
    class func createUser(user: FTUser) -> CKRecord {
        
        // create db and record to save
        let publicDB = CKContainer.defaultContainer().publicCloudDatabase
        var userRecordToReturn = CKRecord(recordType: "User", recordID: user.recordID)
        var returned = false
        
        // set attributes
        userRecordToReturn.setObject(user.username as String, forKey: "name")
        userRecordToReturn.setObject(5000, forKey: "daily_goal")
        userRecordToReturn.setObject([0, 0, 0, 0, 0], forKey: "badges")
        userRecordToReturn.setObject(user.cloudKitID, forKey: "cloudKitID")
        
        // save record to cloudkit
        publicDB.saveRecord(userRecordToReturn, completionHandler: { (record, error) -> Void in
            
            if (error != nil) {
                println("error saving new user")
                println(error.localizedDescription)
            }
            
            if (record != nil) {
                println("saved new user")
                println(record.description)
                userRecordToReturn = record
            }
            
            returned = true
            
        })
        
        while (!returned) {
            // do nothing
        }
        
        return userRecordToReturn
    }
    
    class func fetchDailies(username: String) -> [CKRecord]{
        
        var dailiesToReturn = [CKRecord]()
        let publicDB = CKContainer.defaultContainer().publicCloudDatabase
        let userNamePredicate = NSPredicate(format: "user = %@", username)
        var returned = false
        
        let dailyQuery = CKQuery(recordType: "Dailys", predicate: userNamePredicate)
        
        publicDB.performQuery(dailyQuery, inZoneWithID: nil) { (returnedRecords, error) -> Void in
            
            if (error != nil) {
                println("error fetching dailies")
            }
            
            if (returnedRecords != nil) {
                dailiesToReturn = returnedRecords as [CKRecord]
                println("we got dem dailies")
            }

            returned = true

        }
        
        while (!returned) {
            // do nothing
        }

        
        return dailiesToReturn
    }
    
    class func checkExistingUser(recordID: String) -> CKRecord? {
        
        var recordToReturn : CKRecord?
        let publicDB = CKContainer.defaultContainer().publicCloudDatabase
        var returned = false

        
        let recordIDPredicate = NSPredicate(format: "cloudKitID = %@", recordID)
        let userQuery = CKQuery(recordType: "User", predicate: recordIDPredicate)
        
        publicDB.performQuery(userQuery, inZoneWithID: nil) { (record, error) -> Void in
            
            if (error != nil ) {
                println("something went wrong when fetching user record based off of ID")
                println(error.localizedDescription)
            }
    
            if (record.count != 0) {
                recordToReturn = record[0] as? CKRecord
            } else {
                recordToReturn = nil
            }
                
            returned = true
        }

        
        // wait for async call to return
        while (!returned) {
            // do nothing
        }
        

        return recordToReturn
    }
    
    class func fetchUserID() -> (isLoggedIn: Bool, value: String)? {
        var container : CKContainer?
        var publicDB : CKDatabase?
        var loggedIn : Bool?
        var userID : String?
        var errorMessage : String?
        container = CKContainer.defaultContainer()
        publicDB = container?.publicCloudDatabase
        
        container!.fetchUserRecordIDWithCompletionHandler { (recordID : CKRecordID!, error) -> Void in
            if(error == nil){
                println(userID)
                loggedIn = true
                userID = recordID.recordName
            } else {
                println("in else in fetchUserRecord completion")
                println(error.description)
                loggedIn = false
                errorMessage = error.description

            }
        }
        println("here")
        println(loggedIn)
        
        var count: Int = 0
        let time = NSDate(timeIntervalSinceNow: 0)
        while(loggedIn == nil){
            //do nothing
//            println("+")
        }
        println(errorMessage)
        if(loggedIn == true){
            while(userID==nil){
             //do nothing
             //println("-")
            }
        }
        
//        return (false, "test")
        return (loggedIn!, userID ?? errorMessage!)
    }

    
   
    
// MARK: Methods we need:
    
    //establish connection to container
    //establish connection to public database
    
    
    
    //check if username found in nsUserDefaults - appdidfinishloadingwithoptions (I think)
    //If not get a username - check to make sure unique in user records in public database
    //when app is loaded the step update function should run and update the users steps from healthkit to cloudkit
    
    //create user record with username
    
    //update user record with steps today !! need to grab steps from healthkit

    //update user record with new daily goal !! local only no cloudkit needed
    
    //update user record with team reference when team is joined
    
    //create a team record when team created
    
    //create a challenge record when you (admin) challenge a team
    
    //update a challenge record when a team accepts a challenge
    
    
    //when steps are updated in cloudkit, check if the user has gained a badge
    //if they have gained a badge update locally and to cloudkit
    
// MARK: Cycle for updating team steps today and challenge
    //1. run healthkit helper methods to update current users steps today and total steps (this needs to happen outside of cloudkit class i.e. wherever this is all kicked off)
    //2. is this user on a team? if so: (again this is not dependent on cloudkit, can happen outside cloudkit class)
    // if on a team, kick off the cloudkit methods below
    //3. grab the team object, get the user id's array
    //4. grab the all the user objects using the user id's array
    //5. grab all the 'steps_today' from each user object, total all steps today and set for team steps today, update/save in icloud
    //5.1 save all teammates and their steps to local data model to display on Team page
    
    //6. check if this user is involved in a challenge:
    //7. use team id to query all challenges check if team id is equal to team a or team b in any current challenge
    //8. if not, do nothing, wrap up skip to step 13
    //9. if you are in a challenge:
    //10. divide current user's team total steps by team user id's array.count
    //11. update your team's average in challenge
    //12. we need a single helper method to run at the end of the day, compare team a average vs team b and increment a score
    //13. save all records to public database
    
 
// MARK: Connect to public data base
    
// MARK: Query the team record associated with current user
    //grab current user from data model, use whatever is stored in team_id to query the team record
    //return team record
    
// MARK: Query all users records from the user id's array (input: team record)
    //create a team object for data model
    //save each teammate into team data model

// MARK: Query all challenges to see if any contain current user's team id
    //return record for challenge or nil
    
// MARK: End of day calculations
    
// MARK: Save all records to update cloudkit database

}
