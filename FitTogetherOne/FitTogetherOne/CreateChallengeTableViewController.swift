//
//  CreateChallengeTableViewController.swift
//  FitTogetherOne
//
//  Created by Alex Berger on 12/8/14.
//  Copyright (c) 2014 Glover LLC. All rights reserved.
//

import UIKit

class CreateChallengeTableViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var durationPicker: UIPickerView!
    @IBOutlet weak var datePicker: UIDatePicker!
    var datePickerIsShowing = false
    var durationPickerIsShowing = false
    let datePickerIndex = 2
    let durationPickerIndex = 4
    
    let durationPickerData = ["1 Day", "2 Days", "3 Days", "4 Days", "5 Days", "6 Days", "1 Week", "8 Days", "9 Days", "10 Days", "11 Days", "12 Days", "13 Days", "2 Weeks", "15 Days", "16 Days", "17 Days", "18 Days", "19 Days", "20 Days", "3 Weeks", "22 Days", "23 Days", "24 Days", "25 Days", "26 Days", "27 Days", "4 Weeks", "29 Days", "30 Days"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 5
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        var height = self.tableView.rowHeight
        
        if (indexPath.row == datePickerIndex) {
            height = datePickerIsShowing ? 188.0 : 0.0
        } else if (indexPath.row == durationPickerIndex) {
            height = durationPickerIsShowing ? 188.0 : 0.0
        }
        
        return height
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        if (indexPath.row == 1){
            if ( datePickerIsShowing ){
                self.hideDatePicker()
            } else {
                self.showDatePicker()
            }
        }
        
        if (indexPath.row == 3){
            if ( durationPickerIsShowing ){
                self.hideDurationPicker()
            } else {
                self.showDurationPicker()
            }
        }

        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    func hideDatePicker() {
        
        datePickerIsShowing = false
        
        tableView.beginUpdates()
        tableView.endUpdates()
        
        datePicker.hidden = true
        
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.datePicker.alpha = 0.0
        })
        
    }
    
    func showDatePicker() {
    
        datePickerIsShowing = true
        
        tableView.beginUpdates()
        tableView.endUpdates()
        
        datePicker.hidden = false
        
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.datePicker.alpha = 1.0
        }) { (finished) -> Void in
            self.datePicker.hidden = false
        }
    
    }

    
    func showDurationPicker() {
        
        durationPickerIsShowing = true
        
        tableView.beginUpdates()
        tableView.endUpdates()
        
        durationPicker.hidden = false
        
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.durationPicker.alpha = 1.0
        }) { (finished) -> Void in
            self.durationPicker.hidden = false
        }
        
    }
    
    func hideDurationPicker() {
        
        durationPickerIsShowing = false
        
        tableView.beginUpdates()
        tableView.endUpdates()
        
        durationPicker.hidden = true
        
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.durationPicker.alpha = 0.0
        })
        
    }
    
// MARK: Duration Picker Delegate Methods
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 30
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return durationPickerData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //
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
