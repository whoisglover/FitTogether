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

    
    
}
