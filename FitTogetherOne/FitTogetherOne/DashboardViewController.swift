//
//  DashboardViewController.swift
//  FitTogetherOne
//
//  Created by Joshua O'Steen on 12/5/14.
//  Copyright (c) 2014 Glover LLC. All rights reserved.
//

import UIKit
import HealthKit

class DashboardViewController: UITableViewController {
    
    // MARK: PROPERTIES & OUTLETS
    @IBOutlet weak var dashboardTable: UITableView!
    @IBOutlet weak var walkedTodayMeterView: WalkedTodayMeterView!
    @IBOutlet weak var stepsWalkedToday: UILabel!
    @IBOutlet weak var walkedTodayLabel: UILabel!
    @IBOutlet weak var competitionProgress: UIProgressView!
    @IBOutlet weak var daysCompletedLabel: UILabel!
    @IBOutlet weak var totalDaysLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var setGoalButton: UIButton!
    @IBOutlet weak var goalPicker: UIPickerView!
    @IBOutlet weak var confirmGoal: UIButton!
    
    let goalPickerData = ["5000", "6000", "7000", "8000", "9000", "10000", "11000", "12000", "13000", "14000", "15000", "16000", "17000", "18000", "19000", "20000", "21000", "22000", "23000", "24000", "25000", "26000", "27000", "28000", "29000", "30000"]
    
    var todaySteps : Float = 9108.0
    var goalSteps : Float = 12000.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // move section below navigation bar
        self.dashboardTable.contentInset = UIEdgeInsetsMake(30.0, 0.0, 0.0, 0.0)
        
        // set the walked today meter subview's height based on the screen width
        // so that the view is always square
        let screenSize : CGRect = UIScreen.mainScreen().bounds
        walkedTodayMeterView.frame = CGRectMake(0.0, 0.0, screenSize.width, screenSize.width)
        
        walkedTodayMeterUpdate(Int(todaySteps), dailyGoal: Int(goalSteps), screenSize: walkedTodayMeterView.frame)
        
        let healthKit = HKHealthStore()
        let stepQuantityType = HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierStepCount)
        healthKit.requestAuthorizationToShareTypes(NSSet(array: [stepQuantityType]), readTypes: NSSet(array: [stepQuantityType])) { (success, error) -> Void in
            println("Requested access to users step count")
        }
        
        //set up the competition progress bar
        let competitionLength = 25 as NSNumber
        var daysCompleted = 22 as NSNumber
        
        totalDaysLabel.text = competitionLength.stringValue
        daysCompletedLabel.text = daysCompleted.stringValue
        
        progressBar.progress = daysCompleted.floatValue / competitionLength.floatValue
        
        progressBar.layer.cornerRadius = 12.5
    }
    
    override func viewWillAppear(animated: Bool) {
        // set the nav bar title for this view
        self.navigationController?.navigationBar.topItem?.title = "Dashboard"
    }
    
    @IBAction func updateGoal(sender: AnyObject) {
        goalPicker.hidden = false
        confirmGoal.hidden = false
        stepsWalkedToday.hidden = true
        setGoalButton.hidden = true
        walkedTodayLabel.hidden = true        
        
    }
    
    @IBAction func confirmGoalButton(sender: AnyObject) {
        goalPicker.hidden = true
        confirmGoal.hidden = true
        stepsWalkedToday.hidden = false
        setGoalButton.hidden = false
        walkedTodayLabel.hidden = false
        
    }
    
    
    
    func walkedTodayMeterUpdate(stepsToday: Int, dailyGoal: Int, screenSize: CGRect){
        
        let meter = CAShapeLayer()
        let progress = CAShapeLayer()
        //let meterOutline = CAShapeLayer()
        //let shadow = CAShapeLayer()
        
        // Customize the appearance of the shape layer
        meter.fillColor = UIColor.clearColor().CGColor
        meter.strokeColor = UIColor.lightGrayColor().CGColor
        meter.lineWidth = 40.0
        
//        meterOutline.fillColor = UIColor.clearColor().CGColor
//        meterOutline.strokeColor = UIColor.blackColor().CGColor
//        meterOutline.lineWidth = 46.0
        
        
//        shadow.fillColor = UIColor.clearColor().CGColor
//        shadow.strokeColor = UIColor.darkGrayColor().CGColor
//        shadow.lineWidth = 40.0
        
        // Make a rect to draw our shape in
        let meterRect = CGRectMake(((screenSize.width)-(screenSize.width * 0.85)), ((screenSize.width)-(screenSize.width * 0.95)), (screenSize.width * 0.7), (screenSize.height * 0.7))
//        let outlineRect = CGRectMake(((screenSize.width)-(screenSize.width * 0.85) - 1.0), ((screenSize.width)-(screenSize.width * 0.85) - 1.0), (screenSize.width * 0.7) + 2.0, (screenSize.height * 0.7) + 2.0)
//        let shadowRect = CGRectMake(((screenSize.width)-(screenSize.width * 0.85)) + 6, ((screenSize.width)-(screenSize.width * 0.85)) + 3, (screenSize.width * 0.7), (screenSize.width * 0.7))
        
        
        // Set the path for the shape layer
        meter.path = UIBezierPath(ovalInRect: meterRect).CGPath
//        meterOutline.path = UIBezierPath(ovalInRect: outlineRect).CGPath
//        shadow.path = UIBezierPath(ovalInRect: shadowRect).CGPath

        
        // Add the shape layer as a sub layer of our view
//        walkedTodayMeterView.layer.addSublayer(shadow)
//        walkedTodayMeterView.layer.addSublayer(meterOutline)
        walkedTodayMeterView.layer.addSublayer(meter)
        
        // Inner arc
        let arcCenterPoint : CGPoint = CGPoint(x: (screenSize.width / 2.0), y: (screenSize.width / 2.5))
        let arcRadius : CGFloat = (meterRect.width / 2.0)
        let startAngle : CGFloat = CGFloat((3 * M_PI) / 2.0)
        
        var percentage : Float = Float(todaySteps / goalSteps) * 360.0
        var percentageAsRadian : CGFloat = CGFloat(DegreesToRadians(percentage))
        var endAngle : CGFloat = percentageAsRadian + startAngle
        //let endAngle : CGFloat = CGFloat(M_PI)
        
        progress.fillColor = UIColor.clearColor().CGColor
        progress.strokeColor = UIColor(red: 0.890, green: 0.357, blue: 0.306, alpha: 1.00).CGColor
        progress.lineWidth = meter.lineWidth
        progress.path = UIBezierPath(arcCenter: arcCenterPoint, radius: arcRadius, startAngle: startAngle, endAngle: endAngle, clockwise: true).CGPath
        walkedTodayMeterView.layer.addSublayer(progress)
        
        // Animate the shape change
        var newAnimation = CABasicAnimation(keyPath: "strokeEnd")
        newAnimation.fromValue = NSNumber(float: 0.0)
        newAnimation.toValue = NSNumber(float: 1.0)
        newAnimation.duration = 3.7
        newAnimation.delegate = self
        newAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        progress.addAnimation(newAnimation, forKey: "strokeEnd Animation")
        
        
        
    }
    
    func DegreesToRadians (value:Float) -> Float {
        return value * Float(M_PI) / 180.0
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
        
        return 3
    }
    
    // MARK: Duration Picker Delegate Methods
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return goalPickerData.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return goalPickerData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var newSteps = goalPickerData[row]
        setGoalButton.setTitle("Daily Goal: " + newSteps, forState: .Normal)

        
    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 38.0
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