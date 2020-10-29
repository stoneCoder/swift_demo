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
import Kingfisher

class ViewController: UIViewController {
    
    var networkBtnLeftConstraint: Constraint?
    
    lazy var btn:UIButton = {
        let obj = UIButton();
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
    
    lazy var networkImageView:UIImageView = {
       var obj = UIImageView()
        obj.contentMode = .scaleAspectFit
        self.view.addSubview(obj)
        obj.snp.makeConstraints { (make) in
            make.left.equalTo(self.btn.snp.right).offset(10)
            make.top.equalTo(self.btn)
            make.bottom.equalTo(self.btn)
            make.width.equalTo(self.btn)
        }
        return obj
    }()
    
    lazy var networkBtn:UIButton = {
        let obj = UIButton()
        obj.addTarget(self, action: #selector(btnClickActionWithPara(sender:)), for: .touchUpInside)
        self.view.addSubview(obj)
        obj.snp.makeConstraints { (make) in
            self.networkBtnLeftConstraint = make.left.equalTo(self.imageBtn.snp.right).offset(10).constraint
            make.top.equalTo(self.imageBtn)
            make.bottom.equalTo(self.imageBtn)
            make.width.equalTo(self.imageBtn)
        }
        return obj
    }()
    
    lazy var musicPlayBtn:UIButton = {
        let obj = UIButton()
        obj.addTarget(self, action: #selector(musicPlayClick(sender:)), for: .touchUpInside)
        self.view.addSubview(obj)
        obj.snp.makeConstraints { (make) in
            make.left.equalTo(self.imageBtn)
            make.top.equalTo(self.imageBtn.snp.bottom).offset(10)
            make.width.equalTo(self.imageBtn)
            make.height.equalTo(self.imageBtn)
        }
        return obj
    }()
    
    lazy var musicResumeBtn:UIButton = {
        let obj = UIButton()
        obj.addTarget(self, action: #selector(musicPlayClick(sender:)), for: .touchUpInside)
        self.view.addSubview(obj)
        obj.snp.makeConstraints { (make) in
            make.left.equalTo(self.musicPlayBtn.snp.right).offset(10)
            make.top.equalTo(self.musicPlayBtn)
            make.width.equalTo(self.musicPlayBtn)
            make.bottom.equalTo(self.musicPlayBtn)
        }
        return obj
    }()
    
    lazy var musicStopBtn:UIButton = {
        let obj = UIButton()
        obj.addTarget(self, action: #selector(musicPlayClick(sender:)), for: .touchUpInside)
        self.view.addSubview(obj)
        obj.snp.makeConstraints { (make) in
            make.left.equalTo(self.musicResumeBtn.snp.right).offset(10)
            make.top.equalTo(self.musicResumeBtn)
            make.width.equalTo(self.musicResumeBtn)
            make.bottom.equalTo(self.musicResumeBtn)
        }
        return obj
    }()
    
    lazy var tableView:UITableView = {
        let obj = UITableView()
        
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
        
        self.networkBtn.backgroundColor = UIColor.orange
        self.networkBtn.setTitle("网络请求", for: .normal)
        self.networkBtn.setTitleColor(UIColor.black, for: UIControl.State.normal)
        
        self.networkImageView.backgroundColor = UIColor.blue
        self.networkImageView.kf.setImage(with: URL(string: "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=1473836766,4030812874&fm=26&gp=0.jpg"))
        
        self.musicPlayBtn.backgroundColor = UIColor.gray
        self.musicPlayBtn.setTitle("Play", for: .normal)
        self.musicPlayBtn.setTitle("Stop", for: .selected)
        
        self.musicResumeBtn.backgroundColor = UIColor.gray
        self.musicResumeBtn.setTitle("Play Resume", for: .normal)
        
        self.musicStopBtn.backgroundColor = UIColor.gray
        self.musicStopBtn.setTitle("Play Stop", for: .normal)
        
        self.view.layoutIfNeeded()
        let listVC = ListVC()
        listVC.isPlainStyle = true
        self.addChild(listVC)
        self.view.addSubview(listVC.view)
        let visiableY:CGFloat = self.musicPlayBtn.frame.size.height + self.musicPlayBtn.frame.origin.y + 10
        listVC.view.frame = CGRect.init(x: 10, y: visiableY, width: SCREEN_WIDTH - 20, height: SCREEN_HEIGHT - visiableY - 29)
        listVC.tableView.frame = listVC.view.bounds
//        listVC.tableView.frame = CGRect.init(x: 0, y: 0, width: 100, height: 100)
//        listVC.tableView.tableFooterView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 20))
        
        
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
        //子类属性转换字典
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
        let responseFormat = try? JSONDecoder().decode(SSResponse.self, from: jsonData!)
        print("3-----------\(responseFormat!)")
        
        //JSON字符串转Obj
        let jsonStr = "{\"id\":\"127182781278\",\"name\":\"小明\",\"grade\":1}".data(using: .utf8)
        let st = try? JSONDecoder().decode(Car.self,from: jsonStr!)
        print("1-----------\(st!)")
        
//        self.networkBtnLeftConstraint?.deactivate() //注销约束
        self.networkBtnLeftConstraint?.update(offset: 100) //动态修改约束
        UIView.animate(withDuration: 0.5, animations: {
            self.networkBtn.layoutIfNeeded()
        })
    }
    
    //注意关键字@objc 有参数
    @objc func btnClickActionWithPara(sender:UIButton) {
        print("测试按钮事件 - 有参数\(sender)")
        if(sender === self.btn){
            self.loadWebVCInView()
        }else if(sender === self.networkBtn){
            self.requestDataFromNetWork()
        }
        
//        self.showHaveNoTitleAlertView(message: "呵呵哒", cancelAction: { (action) in
//            print("点击取消按钮")
//        }) { (action) in
//            print("点击确认按钮")
//        }
        
        
    }
    
    @objc func musicPlayClick(sender:UIButton){
        let audioPlayer = JKAudioPlayer.shared
        if(sender == self.musicPlayBtn){
            if sender.isSelected {
                audioPlayer.pause()
                sender.isSelected = false
            }else{
                var url = Bundle.main.url(forResource: "test.m4a", withExtension: nil)
//                url = URL.init(string: "https://music.163.com/song?id=1399054231&userid=2506586")
                audioPlayer.play(url:url!)
                sender.isSelected = true
            }
        }else if(sender == self.musicResumeBtn){
            audioPlayer.resume()
        }else if(sender == self.musicStopBtn){
            audioPlayer.stop()
        }
    }
    
    func loadWebVCInView() {
        let webVC:WebVC = WebVC()
        self.present(webVC, animated: true, completion: nil)
        webVC.loadWebViewWith(url: "https://www.baidu.com")
    }
    
    func requestDataFromNetWork() {
        let person = Person()
        person.request(url: test_list_data, method: .get, headers: nil, success: { (dic) in
            //处理服务器返回数据
            let jsonStr = ModelUtils.jsonDicToString(jsonDic: dic)
            let response = try? JSONDecoder().decode(SSResponse.self, from:(jsonStr?.data(using: .utf8))!)
            print("2-----------\(response!)")
        }, fail: { (dic) in

        }, error: nil)
    }


}

