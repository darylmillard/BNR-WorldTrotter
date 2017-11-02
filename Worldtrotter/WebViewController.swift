//
//  WebViewController.swift
//  Worldtrotter
//
//  Created by Daryl Millard on 10/19/17.
//  Copyright © 2017 Daryl Millard. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController{
    
    var webView : WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView = WKWebView()
        let myURL = URL(string:"https://www.bignerdranch.com")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        view = webView
    }
}
