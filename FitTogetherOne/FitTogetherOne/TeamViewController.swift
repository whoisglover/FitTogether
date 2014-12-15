//
//  TeamViewController.swift
//  FitTogetherOne
//

//  Copyright (c) 2014 Glover LLC. All rights reserved.
//

import UIKit


class TeamViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPopoverControllerDelegate{
    
// MARK: TABLE VIEW TEST DATA
    var team : NSArray = [["image" : "default-profile.png", "name" : "Alex", "steps" : 9385], ["image" : "default-profile.png", "name" : "Josh", "steps" : 2844], ["image" : "default-profile.png", "name" : "Danny", "steps" : 7612], ["image" : "default-profile.png", "name" : "Dale", "steps" : 9385], ["image" : "default-profile.png", "name" : "Tyten", "steps" : 9385], ["image" : "default-profile.png", "name" : "Amanda", "steps" : 8201], ["image" : "default-profile.png", "name" : "George", "steps" : 6745], ["image" : "default-profile.png", "name" : "Brittany", "steps" : 7331], ["image" : "default-profile.png", "name" : "CJ", "steps" : 3038], ["image" : "default-profile.png", "name" : "Ty", "steps" : 2009], ["image" : "default-profile.png", "name" : "Cate", "steps" : 3011] ]
    
    
    
    
    
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var teamTableView: UITableView!


    override func viewDidLoad() {
        super.viewDidLoad()

        //segmentedControl.addTarget(self, action: "segmentChanged:", forControlEvents: .ValueChanged)
        
        
        
        // adjust table view contents to appropiately space the table head
        // and section under the team name and segemented control
        self.teamTableView.contentInset = UIEdgeInsetsMake(-25.0, 0.0, 0.0, 0.0)
        
        // sort the team array alphabetically on first load to correspond to the initial state
        // of the segmented control
        let alphabeticalDescriptors = NSSortDescriptor(key: "name", ascending: true)
        team = team.sortedArrayUsingDescriptors([alphabeticalDescriptors])


    }
    
    override func viewWillAppear(animated: Bool) {
        // set the nav bar title for this view
        self.navigationController?.navigationBar.topItem?.title = "Team"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sortTeamTableBy(sender: UISegmentedControl) {
        
        let alphabeticalDescriptors = NSSortDescriptor(key: "name", ascending: true)
                
        if(sender.selectedSegmentIndex == 0){
            
            team = team.sortedArrayUsingDescriptors([alphabeticalDescriptors])
            
        } else if(sender.selectedSegmentIndex == 1) {
            
            let mostSteps = NSSortDescriptor(key: "steps", ascending: false)
            
            team = team.sortedArrayUsingDescriptors([mostSteps, alphabeticalDescriptors])
            
        } else if(sender.selectedSegmentIndex == 2) {
            
            let mostSteps = NSSortDescriptor(key: "steps", ascending: true)
            
            team = team.sortedArrayUsingDescriptors([mostSteps, alphabeticalDescriptors])
            
        }
        
        teamTableView.reloadData()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

//    func segmentChanged(sender: UISegmentedControl){
//        var color = UIColor(red: 240.0/255.0, green: 99.0/255.0, blue: 74.0/255.0, alpha: 1.0)
//        var selectedIndex = segmentedControl.selectedSegmentIndex
//       // var selectedSegmet = segmentedControl.
//        var colorOfSegment: () = segmentedControl.backgroundColor = color
//        
//    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("teammate", forIndexPath:indexPath) as TeammateTableViewCell
        let cellData : AnyObject = team[indexPath.row]
        
        cell.name.text = cellData["name"] as? String
        cell.stepsToday.text = (cellData["steps"] as NSNumber!).stringValue
        cell.profilePicture.image = UIImage(named: cellData["image"] as String!)
        
        // make profile image round
        cell.profilePicture.layer.cornerRadius = 20.0
        cell.profilePicture.layer.borderWidth = 1.0
        cell.profilePicture.layer.borderColor = UIColor(red: 0.882, green: 0.365, blue: 0.286, alpha: 1.0).CGColor
        cell.profilePicture.clipsToBounds = true
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return team.count
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Steps Today"
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let teamMember = team[indexPath.row] as [String : AnyObject]
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let teamMemberProfile = storyboard.instantiateViewControllerWithIdentifier("profile") as ProfileViewController
        
        let teamMemberData : [String : AnyObject] = ["username" : teamMember["name"] as String, "profileImage" : teamMember["image"] as String, "team-name" : teamName.text as String!, "total-steps" : 103849 as Int, "badges" : ["badge1.png", "badge2.png", "badge6.png", "badge11.png"]]
        
        teamMemberProfile.testProfileData = teamMemberData
        
        self.teamTableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        self.navigationController?.pushViewController(teamMemberProfile, animated: true)
        
        
    
    }
    
//    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        tableView.headerViewForSection(section)
//    }

}




































