//
//  WebViewController.swift
//  CollegeProfileBuilder
//
//  Created by nhealy on 2/12/15.
//  Copyright (c) 2015 Barrington High School. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    @IBOutlet weak var myWebView: UIWebView!
    var collegeURL = ""
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let linkToDisplay = NSURL(string: collegeURL)
        let myRequest = NSURLRequest(URL: linkToDisplay!)
        myWebView.loadRequest(myRequest)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
