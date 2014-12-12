//
//  EpisodeTableViewCell.swift
//  Shows
//
//  Created by Ian Mitchell on 12/12/14.
//  Copyright (c) 2014 Ian Mitchell. All rights reserved.
//

import UIKit

class EpisodeTableViewCell: UITableViewCell {
    public var episode: Episode?
    
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
        let showsAPI = ShowsAPI()
        
        if (watchedSwitch.on) {
            showsAPI.addEpisode(episode!) {(episode: Episode?, error: NSError?) in
                if let episode = episode {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        println("added episode")
                    })
                }
                else {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        println("did not add episode")
                    })
                }
            }
        }
        else {
            showsAPI.removeEpisode(episode!) {(episode: Episode?, error: NSError?) in
                if let episode = episode {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        println("removed episode")
                    })
                }
                else {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        println("did not remove episode")
                    })
                }
            }
        }
    }
}
