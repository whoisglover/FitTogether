//
//  JoinTeamViewController.swift
//  FitTogetherOne
//
//  Created by Joshua O'Steen on 12/6/14.
//  Copyright (c) 2014 Glover LLC. All rights reserved.
//

import UIKit
import CloudKit

class JoinTeamViewController: UITableViewController, UITextViewDelegate {

// MARK: PROPERTIES & OUTLETS
    @IBOutlet weak var teamCode: UITextField!
    @IBOutlet weak var checkTeamCode: UIButton!
    @IBOutlet weak var confirmedTeamCodeDescription: UITextView!
    @IBOutlet weak var joinTeamButton: UIButton!
    var codeCheckSuccess = false
    var teamToJoinRecord : CKRecord!
    let teamCodeError = "Incorrect team code. Try again."
    

// MARK: BOILERPLATE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add gesture to dismiss keyboard
        var tapDismiss = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        self.view.addGestureRecognizer(tapDismiss)
        
        // add observer to notify this class that the text in the teamCode textfield changed
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "textViewDidChange:", name: UITextFieldTextDidChangeNotification, object: teamCode)
        
    }
    
    // Team code label text changed
    func textViewDidChange(notification: NSNotification) {
        
        let shareCode = teamCode.text
        
        // length is 10, auto check cloudkit team codes
        if(shareCode.utf16Count == 10){
            if(checkTeamCodeInCloudKit(shareCode)){ // team with code found
                
                // reload table view data to show the second cell
                // containing the team info
                self.tableView.reloadData()
                
                // disable teamCode editing
                // teamCode.userInteractionEnabled = false
                
                // extract team info from team record
                let name : String = teamToJoinRecord.objectForKey("name") as String
                let description : String = teamToJoinRecord.objectForKey("description") as String
                
                // set team info
                confirmedTeamCodeDescription.text = "Team Name: \(name)\n\nDescription: \(description)"
                
                // change buttons
                joinTeamButton.backgroundColor = UIColor(red: 0.839, green: 0.345, blue: 0.310, alpha: 1.00) // tomato
                joinTeamButton.enabled = true
                checkTeamCode.backgroundColor = UIColor(red: 0.376, green: 0.745, blue: 0.408, alpha: 1.00) // green
                checkTeamCode.titleLabel?.textAlignment = NSTextAlignment.Center
                checkTeamCode.setTitle("Go!", forState: UIControlState.Normal)
            } else { // incorrect team code, try again
                // create placeholder text and color
                let placeholder = NSAttributedString(string: teamCodeError, attributes: [NSForegroundColorAttributeName : UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.5)])
                
                // clear team code text
                teamCode.text = ""
                
                // set place holder
                teamCode.attributedPlaceholder = placeholder
            }
        }
        
    }
    
    // check the input team code against cloudkit team codes
    func checkTeamCodeInCloudKit(shareCode: String) -> Bool{

        var returned = false
        var queryResults = [CKRecord]()
        
        // Public database
        let publicDB = CKContainer.defaultContainer().publicCloudDatabase
        
        // team code predicate
        let shareCodePredicate = NSPredicate(format: "shareCode = %@", shareCode)
        
        // team code query
        let teamCodeQuery = CKQuery(recordType: "Teams", predicate: shareCodePredicate)
        
        // query team record containing share code
        publicDB.performQuery(teamCodeQuery, inZoneWithID: nil) { (returnRecords , error) -> Void in
            
            if(error == nil) { // query was successful
                // save any records that were returned
                queryResults = returnRecords as Array
                returned = true
                
            } else {
                println(error.description)
            }
            
        }
        
        // wait for results to return
        while(!returned) {
            // do nothing
        }
        
        if(queryResults.count == 1) {
            codeCheckSuccess = true
            teamToJoinRecord = queryResults[0] as CKRecord
        } else {
            codeCheckSuccess = false
        }
        
        return codeCheckSuccess
    }
    
    // Join a team
    @IBAction func joinTeam(sender: AnyObject) {
        
        // if team to join is set
        if(teamToJoinRecord != nil) {
            
            // add the current user to the team members string array
            var members : Array = teamToJoinRecord.objectForKey("members") as [NSString]
            members.append("RamRod") // test user, change this to current user
            teamToJoinRecord.setObject(members, forKey: "members")
            
            // save modified record to CloudKit
            let publicDB = CKContainer.defaultContainer().publicCloudDatabase
            let modifyRecord = CKModifyRecordsOperation(recordsToSave: [teamToJoinRecord], recordIDsToDelete: nil)
            // you can set a completion handler here for the modify operation 
            // using the 'modifyRecordsCompletionBlock:' variable of CKModifyRecordsOperation
            
            // add operation to public database
            publicDB.addOperation(modifyRecord)
            
        }
        
        // add code to build the team object for the data model
        
        // display success message to user and pop to root view controller
        let teamName : String = teamToJoinRecord.objectForKey("name") as String
        let joinTeamSuccess = UIAlertController(title: "Success!", message: "You've joined \(teamName)! Time to pound the pavement.", preferredStyle: UIAlertControllerStyle.Alert)
        joinTeamSuccess.addAction(UIAlertAction(title: "Let's Go!", style: UIAlertActionStyle.Default, handler: { (alert: UIAlertAction!) -> Void in
            self.goToRoot()
        }))
        
        self.presentViewController(joinTeamSuccess, animated: true) { () -> Void in
            println("SUCCESSFULLY JOINED TEAM")
        }
        
    }
    
    // Pop to root view controller and show the the team view
    func goToRoot() {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    
    // Dismiss Keyboard
    func dismissKeyboard(){
        teamCode.resignFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

// MARK: TABLE VIEW METHODS

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(codeCheckSuccess && section == 0){
            return 2
        }
        
        return 1
    }


}
