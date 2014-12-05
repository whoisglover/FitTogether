//
//  TeamViewController.swift
//  FitTogetherOne
//

//  Copyright (c) 2014 Glover LLC. All rights reserved.
//

import UIKit


class TeamViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
// MARK: TABLE VIEW TEST DATA
    let team : [Dictionary<String, AnyObject>] = [["image" : "default-profile.png", "name" : "Alex", "steps" : 12345], ["image" : "default-profile.png", "name" : "Josh", "steps" : 43566], ["image" : "default-profile.png", "name" : "Danny", "steps" : 25432], ["image" : "default-profile.png", "name" : "Jake", "steps" : 8345], ["image" : "default-profile.png", "name" : "Zack", "steps" : 8965], ["image" : "default-profile.png", "name" : "Jake", "steps" : 9865], ["image" : "default-profile.png", "name" : "Randy", "steps" : 6745], ["image" : "default-profile.png", "name" : "Alex", "steps" : 12345], ["image" : "default-profile.png", "name" : "Josh", "steps" : 43566], ["image" : "default-profile.png", "name" : "Danny", "steps" : 25432], ["image" : "default-profile.png", "name" : "Jake", "steps" : 8345], ["image" : "default-profile.png", "name" : "Zack", "steps" : 8965], ["image" : "default-profile.png", "name" : "Jake", "steps" : 9865], ["image" : "default-profile.png", "name" : "Randy", "steps" : 6745], ["image" : "default-profile.png", "name" : "Alex", "steps" : 12345], ["image" : "default-profile.png", "name" : "Josh", "steps" : 43566], ["image" : "default-profile.png", "name" : "Danny", "steps" : 25432], ["image" : "default-profile.png", "name" : "Jake", "steps" : 8345], ["image" : "default-profile.png", "name" : "Zack", "steps" : 8965], ["image" : "default-profile.png", "name" : "Jake", "steps" : 9865], ["image" : "default-profile.png", "name" : "Randy", "steps" : 6745]]
    
    
    
    
    
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var teamTableView: UITableView!


    override func viewDidLoad() {
        super.viewDidLoad()

        //segmentedControl.addTarget(self, action: "segmentChanged:", forControlEvents: .ValueChanged)
        
        // set the nav bar title for this view
        self.navigationController?.navigationBar.topItem?.title = "Team"
        
        // adjust table view contents to appropiately space the table head
        // and section under the team name and segemented control
        self.teamTableView.contentInset = UIEdgeInsetsMake(-25.0, 0.0, 0.0, 0.0)

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

//    func segmentChanged(sender: UISegmentedControl){
//        var color = UIColor(red: 240.0/255.0, green: 99.0/255.0, blue: 74.0/255.0, alpha: 1.0)
//        var selectedIndex = segmentedControl.selectedSegmentIndex
//       // var selectedSegmet = segmentedControl.
//        var colorOfSegment: () = segmentedControl.backgroundColor = color
//        
//    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("teammate", forIndexPath:indexPath) as TeammateTableViewCell
        let cellData = team[indexPath.row]
        
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
    
//    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        tableView.headerViewForSection(section)
//    }

}
