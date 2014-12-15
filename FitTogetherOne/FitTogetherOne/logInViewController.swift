//
//  logInViewController.swift
//  FitTogetherOne
//
//  Created by Alex Berger on 12/7/14.
//  Copyright (c) 2014 Glover LLC. All rights reserved.
//

import UIKit

class logInViewController: UIViewController {
    
    let delegate = UIApplication.sharedApplication().delegate as AppDelegate
    @IBOutlet weak var userName: UITextField!
    var userRecordID:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //try to accesss data from app delegate here to get the user record ID
        println("inside of loginViewController and the userData model has this record id:   ")
        var tapDismiss = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        self.view.addGestureRecognizer(tapDismiss)
    }
    
    func dismissKeyboard(){
        
        userName.resignFirstResponder()
    }
        
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchForExistingUsername() {
        
        // get recordID
        let userID = delegate.getUserData().recordID
        
        // get record from CloudKit if any
        
        
        
        
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
