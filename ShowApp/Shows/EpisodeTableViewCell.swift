//
//  EpisodeTableViewCell.swift
//  Shows
//
//  Created by Ian Mitchell on 12/12/14.
//  Copyright (c) 2014 Ian Mitchell. All rights reserved.
//

import UIKit

class EpisodeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var watchedSwitch: UISwitch!
    @IBOutlet weak var episodeName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func didToggleEpisodeWatched(sender: AnyObject) {
        println("toggled")
    }
}
