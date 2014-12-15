//
//  FTUser.swift
//  FitTogetherOne
//
//  Created by Danny Glover on 12/7/14.
//  Copyright (c) 2014 Glover LLC. All rights reserved.
//

import UIKit

class FTUser: NSObject {
    
    var username = String()
    var team : FTTeam?
    var recordID = String()
    var dailyGoal = 0
    var totalSteps = 0
    var blurb = String()
    var badges = []
    var dailyChallengeSteps = FTDaily()

    
    
    override init() {
        super.init()
    }
    
}
