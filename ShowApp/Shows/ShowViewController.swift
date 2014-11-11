//
//  ShowViewController.swift
//  Shows
//
//  Created by Spencer Lewson on 11/6/14.
//  Copyright (c) 2014 Ian Mitchell. All rights reserved.
//

import UIKit

class ShowViewController: UIViewController {

    public var test: NSString?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        if let test = test {
            print(test)
        }
        else {
            print("ruh-roh")
        }
        
        let showsApi = ShowsAPI()
        
        showsApi.getMessage() {(message: String, error: NSError?) in
            print("message = " + message)
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
