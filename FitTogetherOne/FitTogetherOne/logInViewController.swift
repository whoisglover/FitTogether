//
//  logInViewController.swift
//  FitTogetherOne
//
//  Created by Alex Berger on 12/7/14.
//  Copyright (c) 2014 Glover LLC. All rights reserved.
//

import UIKit
import CloudKit

class logInViewController: UIViewController {
    
    
    let delegate = UIApplication.sharedApplication().delegate as AppDelegate
    @IBOutlet weak var userName: UITextField!
    var user = FTUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //try to accesss data from app delegate here to get the user record ID
        println("inside of loginViewController and the userData model has this record id:   ")
        var tapDismiss = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        self.view.addGestureRecognizer(tapDismiss)
        
        // set user
        self.user = delegate.getUserData()
    }
    
    @IBAction func createUser(sender: AnyObject) {
        
        let errorPlaceholder = NSAttributedString(string: "Username already in use.", attributes: [NSForegroundColorAttributeName : UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.5)])
        let name = userName.text
        
        var isUnique : Bool = CloudKitInterface.checkUniqueUsername(name)
        
        // check for username uniqueness
        if (isUnique) {
            // save user record to cloudkit
            user.username = name
            user.recordID = CKRecordID(recordName: name)
            let returnedRecord = CloudKitInterface.createUser(self.user)
            user.userRecord = returnedRecord
            
            self.performSegueWithIdentifier("loggedIn", sender: self)
            
        } else if (!isUnique){
            userName.attributedPlaceholder = errorPlaceholder
            userName.text = ""
        }
        
        // set user record in data model
        
        
    }
    
    func dismissKeyboard(){
        
        userName.resignFirstResponder()
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

}
