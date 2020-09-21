//
//  WebVC.swift
//  SwiftDemo
//
//  Created by sinosun on 2020/9/21.
//  Copyright © 2020 sinosun. All rights reserved.
//

import UIKit
import WebKit

class WebVC: NormalVC {
    
    lazy var webView:WKDetailWebView = {
        let userContentController = WKUserContentController()
        let webViewConfig = WKWebViewConfiguration()
        webViewConfig.userContentController = userContentController
        let obj = WKDetailWebView.init(frame: CGRect.zero, configuration: webViewConfig)
        self.view.addSubview(obj)
        obj.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        obj.startProvisionalNavigation = {(webView:WKWebView,navigation:WKNavigation) -> Void in
            print("呵呵哒1")
        }
        
        obj.didFinishNavigation = {(webView:WKWebView,navigation:WKNavigation) ->Void in
            print("呵呵哒2")
        }
        obj.didFailProvisionalNavigationWithError = {(webView:WKWebView,navigation:WKNavigation,error:Error) ->Void in
            print("呵呵哒3")
        }
        return obj
    }()
    
    lazy var progressView:UIProgressView = {
        let obj = UIProgressView()
        
        return obj
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    func layoutUI() {
    }

}
