//
//  DashboardViewController.swift
//  FitTogetherOne
//
//  Created by Joshua O'Steen on 11/20/14.
//  Copyright (c) 2014 Glover LLC. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
//  MARK: PRESENT SETTINGS
    @IBAction func presentSettings(sender: AnyObject) {
        
        let settingsViewController = storyboard?.instantiateViewControllerWithIdentifier("settings") as SettingsTableViewController
        
        self.presentViewController(settingsViewController, animated: true, completion: nil)
        
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
