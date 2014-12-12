//
//  AddShowViewController.swift
//  Shows
//
//  Created by Spencer Lewson on 12/7/14.
//  Copyright (c) 2014 Ian Mitchell. All rights reserved.
//

import UIKit

class AddShowViewController: UIViewController, UISearchBarDelegate {
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var add: UIButton!
    
    var trackedShow: Show!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.hidden = true
        statusLabel.hidden = true
        add.hidden = true
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchNotFound() {
        activityIndicator.stopAnimating()
        activityIndicator.hidden = true
        statusLabel.text = "Show not found!"
    }
    
    func searchFound(#query: String) {
        activityIndicator.stopAnimating()
        activityIndicator.hidden = true
        add.hidden = false
        statusLabel.text = "Found \(query)!"
    }
    
    func addedShow(#query: String) {
        activityIndicator.stopAnimating()
        activityIndicator.hidden = true
        statusLabel.text = "Added \(query)"
        add.hidden = true
    }
    
    func didNotAddShow() {
        activityIndicator.stopAnimating()
        activityIndicator.hidden = true
        statusLabel.text = "Sorry, error!"
    }
    
    @IBAction func didClickAddFavoriteButton(sender: AnyObject) {
        activityIndicator.startAnimating()
        activityIndicator.hidden = false
        
        println("clicked add to favorites")
        
        let showsAPI = ShowsAPI()
        
        showsAPI.addFavorite(trackedShow) {(show: Show?, error: NSError?) in
            if let show = show {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.addedShow(query: show.name)
                    println("added to favorites")
                })
            }
            else {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.didNotAddShow()
                    println("did not add show to favorites")
                })
            }
        }
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        activityIndicator.startAnimating()
        activityIndicator.hidden = false
        statusLabel.hidden = false
        
        println("searchbuttonclicked: \(searchBar.text)")
        let showsAPI = ShowsAPI()
        
        showsAPI.getSearchResults(searchBar.text) {(show: Show?, error: NSError?) in
            if let show = show {
                self.trackedShow = show
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.searchFound(query: show.name)
                })
            }
            else {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.searchNotFound()
                })
            }
        }
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
