//
//  CreateTeamViewController.swift
//  FitTogetherOne
//
//  Created by Joshua O'Steen on 11/26/14.
//  Copyright (c) 2014 Glover LLC. All rights reserved.
//

import UIKit
import CloudKit

class CreateTeamViewController: UITableViewController, UITextViewDelegate {

// MARK: PROPERTIES & OUTLETS
    @IBOutlet weak var teamName: UITextField!
    @IBOutlet weak var descriptionInput: UITextView!
    @IBOutlet var createTeamTableView: UITableView!
    var teamShareCode : Int = 1234567890
    var teamCreateSuccess = false
    var savedTeam = String()

    
    
// MARK: BOILERPLATE
    override func viewDidLoad() {
        super.viewDidLoad()

        // set navigation bar items to white
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.title = "Create a Team"
        
        // text view is empty
        if (descriptionInput.text == "") {
            textViewDidEndEditing(descriptionInput)
        }
        var tapDismiss = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        self.view.addGestureRecognizer(tapDismiss)
        
    }
    
    @IBAction func createAndShare(sender: UIButton) {
        
        // clear keyboard
        self.dismissKeyboard()
        
        // save text for later display
        let savedTeamName = teamName.text
        let savedDescription = descriptionInput.text
        
        // get button's label text to determine functionality
        let buttonText = sender.titleLabel!.text
        
        // if button is "create team"
        if(buttonText == "Create Team"){
            
            // check if validateText() returns expected values
            if let validation = validateText() {
                if validation.result { // text successfully validated. display confirmation and change button text/function
                    savedTeam = savedTeamName
                    
                    // generate and save team share code
                    
                    let publicDatabase = CKContainer.defaultContainer().publicCloudDatabase
                    let teamNamePredicate = NSPredicate(format: "name = %@", savedTeam)
                    var taken = 0
                    let teamNameQuery = CKQuery(recordType: "Teams", predicate: teamNamePredicate)
                    var operation = CKQueryOperation(query: teamNameQuery)
                    var results1 = []
                    publicDatabase.performQuery(teamNameQuery, inZoneWithID: nil, completionHandler: { (results, error) -> Void in
                        results1 = results
                        if(results1.count == 0){
                            taken = 1
                        }else{
                            taken = 2
                        };
                        
                    })
                    
                    while(taken == 0){
                        //do nothing
                    }
                    
                    
                    
//
                    
                    //taken 1 means not taken, able to create a new team in cloudkit with given data
                    if(taken==1){
                        
                        //create share code
                        
                       let shareCode = randomString()
                        
                        
                        
                        
                        
                        //save team in cloudkit
                        
                        
                        
                        teamName.text = "Team Name: \(savedTeamName)"
                        teamName.userInteractionEnabled = false
                        descriptionInput.text = "Description: \(savedDescription)\n\nTeam Code: \(teamShareCode)"
                        descriptionInput.userInteractionEnabled = false
                        sender.setTitle(validation.replaceString, forState: UIControlState.Normal)
                        teamCreateSuccess = true
                        createTeamTableView.reloadData()

                    }else{
                        //taken 2 means it is taken need to return to same view with error
                        let placeholder = NSAttributedString(string: "Team Name Already in Use", attributes: [NSForegroundColorAttributeName : UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.5)])
                        teamName.text = ""
                        teamName.attributedPlaceholder = placeholder
                        
                    }
                    
                    
                    
                    
                    // check if team name already exists, if not then create the team
                    
                    // reload table view data in order to get section header to reload and 
                    // show success message

          
                    // make sure to set the nav bar's back button to popToViewController(TeamViewController):
                    // so that when the back button is pressed, the user does not have the option to create
                    // or join another team and is instead taken to the team list view
                    
                    
                    
                } else if ( !validation.result) {
                    switch validation.field {
                        case 0:
                            // replace team text field placeholder with red error message
                            let placeholder = NSAttributedString(string: validation.replaceString, attributes: [NSForegroundColorAttributeName : UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.5)])
                            teamName.text = ""
                            teamName.attributedPlaceholder = placeholder
                        case 1:
                            descriptionInput.textColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.5)
                            descriptionInput.text = validation.replaceString
                        case 2:
                            let placeholder = NSAttributedString(string: "Please Enter a Team Name Here", attributes: [NSForegroundColorAttributeName : UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.5)])
                            teamName.text = ""
                            teamName.attributedPlaceholder = placeholder
                        
                            descriptionInput.textColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.5)
                            descriptionInput.text = "Please Enter a Team Description Here"
                        
                        default:
                            return
                    }
                    
                }
            } else {
                // validation returned nil
                println("UH OH, our validation function isn't working right")
            }
        } else if (buttonText == "Share Code") { // team has been created, allow user to share team code
            
            // create activity view controller for the share sheet
            // activityItems: an array of the data to be shared (team code)
            // applicationActivities: the supported share methods (messages, mail, facebook, twitter, etc)
            let shareSheet = UIActivityViewController(activityItems: ["Join my FitTogether team named \"\(savedTeam)\" by using the code \(teamShareCode) in the app!"], applicationActivities: nil)
            
            // present to user by adding to nav stack
            self.navigationController?.presentViewController(shareSheet, animated: true, completion: { () -> Void in
                println("share sheet presented to user")
            })
            
            // make sure to set the nav bar's back button to popToViewController(TeamViewController):
            // so that when the back button is pressed, the user does not have the option to create
            // or join another team and is instead taken to the team list view
            
        }
    }
    
    // validates the input text before processessing
    func validateText() -> (result: Bool, replaceString: String, field: Int)? {
        
        let team = teamName.text
        let description = descriptionInput.text
        var matches = 0
        let characterCount = team.utf16Count
        let descriptionCount = description.utf16Count
        
        // regex to force alphanumeric team name input
        let regex = NSRegularExpression(pattern: "^[a-zA-Z0-9]*$", options: nil, error: nil)
        
        if (characterCount > 0){ // get number of matches for later comparison
            matches = regex!.numberOfMatchesInString(team, options: nil, range: NSMakeRange(0, characterCount))
        }
        
        // verify and return tuple containing error and the field
        // containing the error
        if(team == "" && (description == "" || description == "Description" || description == "description")) {
            println("team name is empty")
            return (false, "", 2)
            
        } else if (description == "" || description == "Description" || description == "description") {
            println("description is empty")
            return(false, "Please Enter a Team Description Here", 1)
        } else if (characterCount < 6 || characterCount > 20) {
            println("team name is too short/long")
            return (false, "Must be between 6 & 20 Characters Long", 0)
        } else if (team == "") {
            return (false, "Please Enter a Team Name Here", 0)
        } else if (descriptionCount > 100) {
            return (false, "Must be 100 character or less", 1)
        }
//            else if (matches != characterCount) {
//            println("team name doesn't match regex")
//            return (false, "Letters and Number Only", 0)
//        } // check cloudkit for existing team name
        
        // passes all verification
        return (true, "Share Code", 3)
    }

     override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
// MARK: TEXT VIEW METHODS
    func dismissKeyboard(){
        descriptionInput.resignFirstResponder()
        teamName.resignFirstResponder()
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if (textView.text == "") {
            textView.text = "Description"
            textView.textColor = UIColor(red: 0.667, green: 0.667, blue: 0.667, alpha: 0.3)
        }
        textView.resignFirstResponder()
    }
    
    func textViewDidBeginEditing(textView: UITextView){
        if (textView.text == "Description" || textView.textColor == UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.5)){
            textView.text = ""
            textView.textColor = UIColor.blackColor()
        }
        textView.becomeFirstResponder()
    }
    

// MARK: TABLE VIEW METHODS
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(section == 0){
            return 2
        } else if(section == 1){
            return 1
        }
        
        return 2
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        // check if user is on team after creation
        // and replace false with the result in order to 
        // add the section header
        if(teamCreateSuccess && section == 0){
            return "Team Created"
        }
        
        return ""
    }
    
    func randomString() -> NSString {
            let alphanumeric : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
            var shareCode = NSMutableString(capacity: 10)
            for i in 1...10{
                shareCode.appendFormat("%C", alphanumeric.characterAtIndex(Int(arc4random_uniform(UInt32(alphanumeric.length)))))
            }
            return shareCode
    }
    
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
