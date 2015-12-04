//
//  StatisticViewController.swift
//  trader
//
//  Created by Xi Zhang on 12/4/15.
//  Copyright © 2015 minor. All rights reserved.
//

import UIKit

class StatisticViewController: UIViewController {
    var itemId: Int?
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        if itemId != nil, let url = NSURL(string: Config.wowuctionBase + "/" + String(itemId!)){
            let request = NSURLRequest(URL: url);
            webView.loadRequest(request);
        }
    }
}
