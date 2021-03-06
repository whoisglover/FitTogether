//
//  RootTabBarViewController.swift
//  FitTogetherOne
//
//  Created by Joshua O'Steen on 11/20/14.
//  Copyright (c) 2014 Glover LLC. All rights reserved.
//

import UIKit

class RootTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // show setting on tap
    @IBAction func presentSettings(sender: AnyObject) {
        let settingsViewController = storyboard?.instantiateViewControllerWithIdentifier("settings") as SettingsTableViewController
        
        //self.presentViewController(settingsViewController, animated: true, completion: nil)
        
        self.navigationController?.pushViewController(settingsViewController, animated: true)
    }
    
    @IBAction func presentPendingChallange(sender: AnyObject) {
        let pendingChallangeViewController = storyboard?.instantiateViewControllerWithIdentifier("pendingChallange") as PendingChallangeTableViewController
        
        self.navigationController?.pushViewController(pendingChallangeViewController, animated: true)
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
