//
//  ProfileViewController.swift
//  FitTogetherOne
//
//  Created by Joshua O'Steen on 11/25/14.
//  Copyright (c) 2014 Glover LLC. All rights reserved.
//

import UIKit

class ProfileViewController: UITableViewController {
    
//    this view controller will need to implement a Collection View under the badges section
//    in order to display the badges images and/or names. this view will replicate the
//    default photos gallery. 
    
//    to view badges section in IB, change the window base values in IB to w: Any & h: Regular
    

// MARK: DEBUG CODE
    // replace with actual user data from AppDelegate data model
    var testProfileData: Dictionary<String, AnyObject> = ["username" : "Spiderman", "profileImage" : "spiderman.png", "team-name" : "Marvel", "total-steps" : 103849,"badges" : ["badge1.png", "badge2.png", "badge6.png", "badge11.png"]]
    
    
    
// MARK: PROPERTIES & OUTLETS
    @IBOutlet var profileTableView: UITableView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var teamAffiliation: UILabel!
    @IBOutlet weak var totalSteps: UILabel!
    
    
// MARK: BOILERPLATE
    override func viewDidLoad() {
        super.viewDidLoad()


        // for testing purposes, inset the tableview so that headers and full
        // cell height are show. discuss headers with design team.
        self.profileTableView.contentInset = UIEdgeInsetsMake(30.0, 0.0, 0.0, 0.0)
        
        // set name and profile picture
        // make profile pic a circle
        usernameLabel.text = testProfileData["username"] as? String
        profileImage.image = UIImage(named: testProfileData["profileImage"] as String!)
        profileImage.layer.cornerRadius = 125.0
        profileImage.layer.borderWidth = 3.0
        profileImage.layer.borderColor = UIColor(red: 0.882, green: 0.365, blue: 0.286, alpha: 1.00).CGColor
        profileImage.clipsToBounds = true
        
        // set team and total steps
        teamAffiliation.text = testProfileData["team-name"] as? String
        totalSteps.text = (testProfileData["total-steps"] as NSNumber).stringValue
        
    }
    
    override func viewWillAppear(animated: Bool) {
        // set the nav bar title for this view
        self.navigationController?.navigationBar.topItem?.title = "Profile"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 4
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
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
