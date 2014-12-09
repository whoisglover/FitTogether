//
//  TeammateTableViewCell.swift
//  FitTogetherOne
//
//  Created by Alex Berger on 12/1/14.
//  Copyright (c) 2014 Glover LLC. All rights reserved.
//

import UIKit

class TeammateTableViewCell: UITableViewCell {
    
    @IBOutlet weak var stepsToday: UILabel!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
