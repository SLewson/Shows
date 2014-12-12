//
//  ShowViewController.swift
//  Shows
//
//  Created by Spencer Lewson on 11/6/14.
//  Copyright (c) 2014 Ian Mitchell. All rights reserved.
//

import UIKit

class ShowViewController: UIViewController {
    @IBOutlet weak var episodeTable: UITableView!
    public var show: Show?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        if let show = show {
            // get episode list
            // turn episodes into array
            // episodeTable.dataSource = array
        }

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
