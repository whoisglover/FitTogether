//
//  CloudKitTestViewController.swift
//  FitTogetherOne
//
//  Created by Joshua O'Steen on 12/2/14.
//  Copyright (c) 2014 Glover LLC. All rights reserved.
//

import UIKit
import CloudKit

class CloudKitTestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    
    
    @IBAction func sendToCloud(sender: AnyObject) {
        
        let container = CKContainer.defaultContainer()
        println(container.description)
        let publicDB = container.publicCloudDatabase
        
        let userID = CKRecordID(recordName: "testTest37")
        let userRecord = CKRecord(recordType: "User", recordID: userID)
        userRecord.setObject("oriyentel", forKey: "name")
        userRecord.setObject("random team name", forKey: "team")
        userRecord.setObject(37000, forKey: "daily_goal")
        
        
        publicDB.saveRecord(userRecord, completionHandler: { (savedUser: CKRecord!, error) -> Void in
            if(error == nil){
                println("SUCCESS")
            } else {
                println(error)
            }
        })
        
        
    }
    
    
}
