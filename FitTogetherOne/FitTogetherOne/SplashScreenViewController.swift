//
//  SplashScreenViewController.swift
//  FitTogetherOne
//
//  Created by Danny Glover on 12/7/14.
//  Copyright (c) 2014 Glover LLC. All rights reserved.
//

import UIKit

class SplashScreenViewController: UIViewController {

    var alertToShow : UIAlertController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        // Do any additional setup after loading the view.
    }
   
    override func viewDidAppear(animated: Bool) {
        let takeMeToSettings = UIAlertController(title: "No iCloud Account", message: "Please go to Settings -> iCloud to create or sign in to your iCloud account. You must be logged in to iCloud to use Fit Together.", preferredStyle: UIAlertControllerStyle.Alert)
        takeMeToSettings.addAction(UIAlertAction(title: "Settings", style: UIAlertActionStyle.Default, handler: { (alert: UIAlertAction!) -> Void in
            let icloudURL = NSURL(string: UIApplicationOpenSettingsURLString)
            UIApplication.sharedApplication().openURL(icloudURL!)
        }))
        
        self.presentViewController(takeMeToSettings, animated: true, completion: { () -> Void in
            println("just went to settings")
        })
    }
    
    func noiCloudAccount() {
        
        let takeMeToSettings = UIAlertController(title: "No Active iCloud Account", message: "Please go to Settings -> iCloud to create or sign in to your iCloud account. You must be logged in to iCloud to use FitTogether.", preferredStyle: UIAlertControllerStyle.Alert)
        takeMeToSettings.addAction(UIAlertAction(title: "Settings", style: UIAlertActionStyle.Default, handler: { (alert: UIAlertAction!) -> Void in
            let icloudURL = NSURL(string: UIApplicationOpenSettingsURLString)
            UIApplication.sharedApplication().openURL(icloudURL!)
        }))
        
        alertToShow = takeMeToSettings
        
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

}
