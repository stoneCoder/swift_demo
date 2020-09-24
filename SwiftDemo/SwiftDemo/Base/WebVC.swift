//
//  WebVC.swift
//  SwiftDemo
//
//  Created by Consle on 2020/9/21.
//  Copyright © 2020 Consle. All rights reserved.
//

import UIKit
import WebKit

class WebVC: NormalVC {
    var loadUrl:String? = nil
    var localLoadUrl:String? = nil
    var isAlreadyAddObserver:Bool = false
    
    lazy var detailWebView:WKDetailWebView = {
        let userContentController = WKUserContentController()
        let webViewConfig = WKWebViewConfiguration()
        webViewConfig.userContentController = userContentController
        let obj = WKDetailWebView.init(frame: self.view.frame, configuration: webViewConfig)
        self.view.addSubview(obj)
        obj.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        obj.startProvisionalNavigation = {[weak self](webView:WKWebView,navigation:WKNavigation) -> Void in
            self?.progressView.isHidden = true
//            self?.progressView.transform = CGAffineTransform().scaledBy(x: 1.0, y: 1.2)
            self?.view.bringSubviewToFront(self!.progressView)
        }
        
        obj.didFinishNavigation = {[weak self](webView:WKWebView,navigation:WKNavigation) ->Void in
            self?.progressView.isHidden = true
        }
        obj.didFailProvisionalNavigationWithError = {[weak self](webView:WKWebView,navigation:WKNavigation,error:Error) ->Void in
            self?.progressView.isHidden = true
            
        }
        return obj
    }()
    
    lazy var progressView:UIProgressView = {
        let obj = UIProgressView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: LINE_HEIGHT))
        obj.trackTintColor = UIColor.red
        obj.progressTintColor = UIColor.red
//        obj.transform = CGAffineTransform().scaledBy(x: 1.0, y: 1.2)
        self.view.insertSubview(obj, aboveSubview: self.detailWebView)
        return obj
    }()
    
    func addObserver() {
        if(!self.isAlreadyAddObserver){
            self.detailWebView.addObserver(self, forKeyPath: "title", options: NSKeyValueObservingOptions.new, context: nil)
            self.detailWebView.addObserver(self, forKeyPath: "estimatedProgress", options: NSKeyValueObservingOptions.new, context: nil)
            self.isAlreadyAddObserver = true
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if(keyPath == "title"){
            if(object as AnyObject? === self.detailWebView){
                
            }else{
                super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            }
        }else if(keyPath == "estimatedProgress"){
            self.progressView.progress = Float(self.detailWebView.estimatedProgress)
            if(Int(self.progressView.progress) == 1){
                UIView.animate(withDuration: 0.25, delay: 0.3,
                               options: UIView.AnimationOptions.curveEaseOut,
                               animations: {[weak self]() in
                    self?.progressView.transform = CGAffineTransform().scaledBy(x: 1.0, y: 1.2)
                }) {[weak self] (finished) in
                    self?.progressView.isHidden = true
                }
            }
        }else{
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    func loadWebViewWith(url:String) {
        self.detailWebView.loadWebViewWith(url: url) { (request) in
            
        }
    }
    
    func loadLocalLoadUrlInViewWith(url:String){
        self.detailWebView.load(URLRequest.init(url: URL.init(fileURLWithPath: url)))
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    deinit {
        self.detailWebView.removeObserver(self, forKeyPath: "title")
        self.detailWebView.removeObserver(self, forKeyPath: "estimatedProgress")
    }
    

    override func layoutUI() {
        super.layoutUI()
        self.progressView.isHidden = true
        addObserver()
    }

}
