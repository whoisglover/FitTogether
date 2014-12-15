//
//  FTUser.swift
//  FitTogetherOne
//
//  Created by Danny Glover on 12/7/14.
//  Copyright (c) 2014 Glover LLC. All rights reserved.
//

import UIKit
import CloudKit

class FTUser: NSObject {
    
    var username = String()
    var team : FTTeam?
    var recordID : CKRecordID!
    var userRecord : CKRecord!
    var cloudKitID = String()
    var dailyGoal = 0
    var totalSteps = 0
    var badges = []
    var dailyChallengeSteps = FTDaily()
    var dailies = [CKRecord]()

    
    
    override init() {
        super.init()
    }
    
    init(recordID: String) {
        self.recordID = CKRecordID(recordName: recordID)
    }
    
    init(record: CKRecord) {
        
        super.init()
        
        self.username = record.objectForKey("name") as String
        self.recordID = record.recordID
        self.badges = record.objectForKey("badges") as [Int]
        self.cloudKitID = record.objectForKey("cloudKitID") as String
        self.userRecord = record
        
        //get daily records
        self.dailies = CloudKitInterface.fetchDailies(self.username)
        
        // if team attribute is set, get team
        if (record.objectForKey("team") != nil) {
            // get the team name
            let teamName = record.objectForKey("team") as String
            
            // get the team record from cloudkit
            CloudKitInterface.fetchTeam(teamName)
        }
        
        
    }
    
}
