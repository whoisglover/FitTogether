//
//  TeamViewController.swift
//  FitTogetherOne
//
//  Created by Alex Berger on 11/23/14.
//  Copyright (c) 2014 Glover LLC. All rights reserved.
//

import UIKit

class TeamViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

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
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("titleCell", forIndexPath:indexPath) as UITableViewCell
        cell.textLabel.text = "HI BITCH"
        
        return cell
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("teammate", forIndexPath:indexPath) as UITableViewCell
        cell.textLabel.text = "Name"
        
        return cell
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }


}
