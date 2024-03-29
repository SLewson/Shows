//
//  EpisodesTableViewController.swift
//  Shows
//
//  Created by Spencer Lewson on 12/12/14.
//  Copyright (c) 2014 Ian Mitchell. All rights reserved.
//

import UIKit

class EpisodesTableViewController: UITableViewController {

    public var show: Show?
    public var episodes: [Episode] = []

    
//    override func viewDidAppear(_animated: Bool) {
//        let showsAPI = ShowsAPI()
//        
//        showsAPI.getFavorites() {(shows: [Show]?, error: NSError?) in
//            if let shows = shows {
//                dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                    self.shows = shows
//                    self.tableView.reloadData()
//                    println("Got some \(shows.count) shows mang")
//                })
//            }
//            else {
//                dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                    println("Failed to get favorites")
//                })
//            }
//        }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        self.title = "Loading..."
        super.viewDidAppear(animated)
        
        if let safe_show = show {
            println("got show \(safe_show.name)")
            self.title = safe_show.name
            
            let showsAPI = ShowsAPI()
            showsAPI.getEpisodes(safe_show.id) {(episodes: [Episode]?, error: NSError?) in
                if let episodes = episodes {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.episodes = episodes
                        self.tableView.reloadData()
                        println("Got some \(episodes.count) episodes")
                    })
                }
                else {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        println("Failed to get episodes")
                    })
                }
            }
        }
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
        
        
        return episodes.count
    }
    
    ////////
    ///  SET ME ^^^^^^^^^^
    ////

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("episodecell", forIndexPath: indexPath) as UITableViewCell
        
        if let episodeCell = cell as? EpisodeTableViewCell {
            episodeCell.episodeName.text = episodes[indexPath.row].name
            episodeCell.episode = episodes[indexPath.row]
            
            if (episodes[indexPath.row].watched == true) {
                episodeCell.watchedSwitch.on = true;
            }
            else {
                episodeCell.watchedSwitch.on = false;
            }
        }

        // Configure the cell...

        return cell
    }
    

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
