//
//  FTTeam.swift
//  FitTogetherOne
//
//  Created by Joshua O'Steen on 12/14/14.
//  Copyright (c) 2014 Glover LLC. All rights reserved.
//

import UIKit
import CloudKit


class FTTeam: NSObject {
// MARK: Properties
    var teamName = String()
    var members = [CKRecord]()
    var admin = String()
    var shareCode = String()
    var challenge : FTChallenge?
    var blurb = String()

    override init() {
        super.init()
    }
    
    init(teamRecord: CKRecord) {
        super.init()
        
        self.teamName = teamRecord.objectForKey("name") as String
        self.admin = teamRecord.objectForKey("admin") as String
        self.shareCode = teamRecord.objectForKey("shareCode") as String
        self.blurb = teamRecord.objectForKey("description") as String
        

        if (teamRecord.objectForKey("isChallenged") as Int == 1) { // if team is challenged
             //get challenge
        }
        
        
        let teamMembers = teamRecord.objectForKey("members") as [String]
        
        if (teamMembers.count > 1) { // if team has members other than current user
            // get other users
            self.members = CloudKitInterface.fetchTeamMembers(teamMembers)
        }
        
        
    }
    
}
