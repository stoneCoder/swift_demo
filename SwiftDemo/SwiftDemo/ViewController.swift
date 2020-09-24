//
//  ViewController.swift
//  SwiftDemo
//
//  Created by Consle on 2020/9/21.
//  Copyright © 2020 Consle. All rights reserved.
//

import UIKit
import SnapKit
import WebKit

class ViewController: UIViewController {
    
    lazy var btn:UIButton = {
        let obj = UIButton();
        
        //添加按钮响应事件
//        obj.addTarget(self, action: #selector(btnClickAction), for: .touchUpInside)
        obj.addTarget(self, action: #selector(btnClickActionWithPara(sender:)), for: UIControl.Event.touchUpInside)
        self.view.addSubview(obj);
        obj.snp.makeConstraints { (make:ConstraintMaker) in
            make.left.equalTo(self.view).offset(10)
            make.top.equalTo(self.view).offset(60)
            make.width.equalTo(80)
            make.height.equalTo(80)
        }
        return obj
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        layoutUI()
        
    }
    
    func layoutUI() {
        self.btn.titleLabel?.lineBreakMode = .byTruncatingMiddle
//        self.btn.backgroundColor = UIColor.red;
        self.btn.setBackgroundImage(UIImage.imageWithColor(color: UIColor.green), for: UIControl.State.normal)
        self.btn.setTitle("测试Swift娃哈哈", for: UIControl.State.normal);
        
        let detailVC = DetailVC()
        detailVC.isPlainStyle = true
        detailVC.tableView.frame = CGRect.init(x: 0, y: 0, width: 100, height: 100)
        detailVC.tableView.tableFooterView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 20))
        
        
//        let webView:WKDetailWebView = WKDetailWebView.init()
//        self.view.addSubview(webView)
//        webView.snp.makeConstraints { (make) in
//            make.top.equalTo(self.btn.snp.bottom).offset(10)
//            make.left.equalTo(self.view)
//            make.right.equalTo(self.view)
//            make.bottom.equalTo(self.view)
//        }
//        print(webView.bridge ?? "娃哈哈") //有值就打印bridge 无值的话打印娃哈哈
//        webView.loadWebViewWith(url: "https://www.baidu.com", customCallBack: nil)
        
       
        
    }
    
    //注意关键字@objc 无参数
    @objc func btnClickAction() {
        print("测试按钮事件 - 无参数")
    }
    
    //注意关键字@objc 有参数
    @objc func btnClickActionWithPara(sender:UIButton) {
        print("测试按钮事件 - 有参数\(sender)")
        
        self.showHaveNoTitleAlertView(message: "呵呵哒", cancelAction: { (action) in
            print("点击取消按钮")
        }) { (action) in
            print("点击确认按钮")
        }
        return
        
        let webVC:WebVC = WebVC()
        self.present(webVC, animated: true, completion: nil)
        webVC.loadWebViewWith(url: "https://www.baidu.com")
    }
    


}

