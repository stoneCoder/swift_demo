//
//  WKDetailWebView.swift
//  SwiftDemo
//
//  Created by Consle on 2020/9/21.
//  Copyright © 2020 Consle. All rights reserved.
//

import UIKit
import WebKit
import WKWebViewJavascriptBridge

class WKDetailWebView: WKWebView,WKNavigationDelegate {
    
    var bridge:WKWebViewJavascriptBridge? = nil
    var startProvisionalNavigation:((_ webView:WKWebView,_ navigation:WKNavigation) -> Void)? = nil
    var didFinishNavigation:((_ webView:WKWebView,_ navigation:WKNavigation) -> Void)? = nil
    var didFailProvisionalNavigationWithError:((_ webView:WKWebView,_ navigation:WKNavigation,_ error:Error) -> Void)? = nil
    
    override init(frame: CGRect, configuration: WKWebViewConfiguration) {
        super.init(frame: frame, configuration: configuration)
        
        self.bridge = WKWebViewJavascriptBridge.init(webView: self)
        self.navigationDelegate = self
        self.scrollView.contentInsetAdjustmentBehavior = .never
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadWebViewWith(url:String) {
        self.loadWebViewWith(url: url, customCallBack: nil)
    }
    
    func loadWebViewWith(url:String,customCallBack:((_ request: NSMutableURLRequest) -> Void)?) {
        let request:NSMutableURLRequest = NSMutableURLRequest.init(url: URL.init(string: url)!,
                                                                   cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringCacheData,
                                                                   timeoutInterval: 30.0)
        customCallBack?(request)
        self.load(request as URLRequest)//类型转换
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void){
        if(navigationResponse.response.isKind(of: HTTPURLResponse.self)){
            if((navigationResponse.response as! HTTPURLResponse).statusCode == 200){
                decisionHandler(.allow)
            }else{
                decisionHandler(.cancel)
            }
        }else if(navigationResponse.response.isKind(of: URLResponse.self)){
            decisionHandler(.allow)
        }else{
            decisionHandler(.cancel)
        }
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!){
        print("开始加载网页")
        startProvisionalNavigation?(webView, navigation)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!){
        print("完成加载网页")
        didFinishNavigation?(webView, navigation)
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error){
        print("失败加载网页")
        didFailProvisionalNavigationWithError?(webView, navigation, error)
    }
    
}
