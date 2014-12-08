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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        println("searchbuttonclicked: \(searchBar.text)")
        let showsAPI = ShowsAPI()
 
        
        showsAPI.getSearchResults(searchBar.text) {(shows: [Show]?, error: NSError?) in
            if let shows = shows {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.statusLabel.text = shows[0].name
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
