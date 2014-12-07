//
//  JoinTeamViewController.swift
//  FitTogetherOne
//
//  Created by Joshua O'Steen on 12/6/14.
//  Copyright (c) 2014 Glover LLC. All rights reserved.
//

import UIKit

class JoinTeamViewController: UITableViewController, UITextViewDelegate {

    
    @IBOutlet weak var teamCode: UITextField!
    @IBOutlet weak var checkTeamCode: UIButton!
    @IBOutlet weak var confirmedTeamCodeDescription: UITextView!
    @IBOutlet weak var joinTeamButton: UIButton!
    var codeCheckSuccess = false
    let dummyTeamName = "Test Team Alpha"
    let dummyTeamDescription = "The best team on FitTogether!"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        var tapDismiss = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        self.view.addGestureRecognizer(tapDismiss)
        
        // add observer to notify this class that the text in the teamCode textfield changed
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "textViewDidChange:", name: UITextFieldTextDidChangeNotification, object: teamCode)
        
    }
    
    // text in the teamCode textfield changed, check length to auto check
    // the input team code against team codes stored in cloudkit
    func textViewDidChange(notification: NSNotification) {
        
        // length is 10, auto check cloudkit team codes
        if(teamCode.text.utf16Count == 10){
            if(checkTeamCodeInCloudKit()){
                
                // reload table view data to show the second cell
                // containing the team info
                self.tableView.reloadData()
                
                // disable teamCode editing
                teamCode.userInteractionEnabled = false
                
                // set team info
                confirmedTeamCodeDescription.text = "Team Name: \(dummyTeamName)\n\nDescription: \(dummyTeamDescription)"
                
                // change buttons
                joinTeamButton.backgroundColor = UIColor(red: 0.839, green: 0.345, blue: 0.310, alpha: 1.00) // tomato
                joinTeamButton.enabled = true
                checkTeamCode.backgroundColor = UIColor(red: 0.376, green: 0.745, blue: 0.408, alpha: 1.00) // green
                checkTeamCode.titleLabel?.textAlignment = NSTextAlignment.Center
                checkTeamCode.setTitle("Go!", forState: UIControlState.Normal)
            }
        }
        
    }
    
    // check the input team code against cloudkit team codes
    func checkTeamCodeInCloudKit() -> Bool{
        
        codeCheckSuccess = true
        
        return true
    }
    
    @IBAction func joinTeam(sender: AnyObject) {
        
    }
    
    func dismissKeyboard(){
        teamCode.resignFirstResponder()
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

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
