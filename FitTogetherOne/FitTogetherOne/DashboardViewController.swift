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
        
        walkedTodayMeterUpadate(6000, dailyGoal: 10000, screenSize: walkedTodayMeterView.frame)
        
        let healthKit = HKHealthStore()
        let stepQuantityType = HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierStepCount)
        healthKit.requestAuthorizationToShareTypes(NSSet(array: [stepQuantityType]), readTypes: NSSet(array: [stepQuantityType])) { (success, error) -> Void in
            println("Requested access to users step count")
        }
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        // set the nav bar title for this view
      
    }
    
    func walkedTodayMeterUpadate(stepsToday: Int, dailyGoal: Int, screenSize: CGRect){
        
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
        let meterRect = CGRectMake(((screenSize.width)-(screenSize.width * 0.85)), ((screenSize.width)-(screenSize.width * 0.85)), (screenSize.width * 0.7), (screenSize.height * 0.7))
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
        let arcCenterPoint : CGPoint = CGPoint(x: (screenSize.width / 2.0), y: (screenSize.width / 2.0))
        let arcRadius : CGFloat = (meterRect.width / 2.0)
        let startAngle : CGFloat = CGFloat((3 * M_PI) / 2.0)
        let endAngle : CGFloat = CGFloat(M_PI)
        
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