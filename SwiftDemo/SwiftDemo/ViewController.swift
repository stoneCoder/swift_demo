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
    
    lazy var imageBtn:UIButton = {
        let obj = UIButton()
        obj.addTarget(self, action: #selector(btnClickAction), for: UIControl.Event.touchUpInside)
        self.view.addSubview(obj)
        obj.snp.makeConstraints {[weak self] (make) in
            make.left.equalTo(self!.btn)
            make.top.equalTo(self!.btn.snp.bottom).offset(20)
            make.width.equalTo(self!.btn)
            make.height.equalTo(self!.btn)
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
        self.btn.setBackgroundImage(UIImage.imageWithColor(color: UIColor.gray), for: UIControl.State.normal)
        self.btn.setTitle("测试Swift娃哈哈", for: UIControl.State.normal);
        
        self.imageBtn.backgroundColor = UIColor.red
        self.imageBtn.setImage(UIImage.init(named: "QQ"), for: UIControl.State.normal)
        self.imageBtn.setTitleColor(UIColor.black, for: UIControl.State.normal)
        self.imageBtn.setTitle("QQ", for: UIControl.State.normal)
        self.imageBtn.changeTitleAndImagePositionToVerticalWithBetweenSpace(space: 5.0)
        
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
        let student = Student()
        student.name = "呵呵哒1"
        student.title = "测试"
        student.pic = "asasfdsfsfgsfg"
        student.id = "10"
        print(student.convertToDict()!)
        
        
        
        let person = Person()
        person.name = "呵呵哒2"
        person.title = "测试"
        person.pic = "asasfdsfsfgsfg"
        print(person.convertToDict()!)
        
        let people = People()
        people.aid = "499"
        people.catid = "20"
        people.dateline = "1476364740"
        people.pic = "portal/201610/13/211832yvlbybpl3rologrr.jpg"
        people.title = "【国内首家】微信小程序视频教程免费下载"
        people.username = "admin"
        let response = SSResponse()
        response.result = [people]
        let jsonData = try? JSONEncoder().encode(response)
        let json = String(data: jsonData!, encoding: .utf8)
        print("3-----------\(json!)")
        let haha = try? JSONDecoder().decode(SSResponse.self, from: jsonData!)
        print("1-----------\(haha!)")
        
        //JSON字符串转Obj
        let jsonStr = "{\"id\":\"127182781278\",\"name\":\"小明\",\"grade\":1}".data(using: .utf8)
        let st = try? JSONDecoder().decode(Car.self,from: jsonStr!)
        print("1-----------\(st!)")
        
        person.request(url: test_list_data, method: .get, headers: nil, success: { (dic) in
            //处理服务器返回数据
            let jsonStr = ModelUtils.jsonDicToString(jsonDic: dic)
            print("2-----------\(jsonStr!)")
            let response = try? JSONDecoder().decode(SSResponse.self, from:(jsonStr?.data(using: .utf8))!)
            print("2-----------\(response!)")
        }, fail: { (dic) in

        }, error: nil)
    }
    
    //注意关键字@objc 有参数
    @objc func btnClickActionWithPara(sender:UIButton) {
        print("测试按钮事件 - 有参数\(sender)")
        
//        self.showHaveNoTitleAlertView(message: "呵呵哒", cancelAction: { (action) in
//            print("点击取消按钮")
//        }) { (action) in
//            print("点击确认按钮")
//        }
        
        let webVC:WebVC = WebVC()
        self.present(webVC, animated: true, completion: nil)
        webVC.loadWebViewWith(url: "https://www.baidu.com")
    }
    


}

