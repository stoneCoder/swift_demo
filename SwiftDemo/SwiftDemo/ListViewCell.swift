//
//  ListViewCell.swift
//  SwiftDemo
//
//  Created by Consle on 2020/9/26.
//  Copyright © 2020 Consle. All rights reserved.
//

import UIKit
import Kingfisher

class ListViewCell: UITableViewCell {
    
    var imageArray = [
        "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1601114954347&di=1279416b1422678b552def5d3df32ca6&imgtype=0&src=http%3A%2F%2Fn.sinaimg.cn%2Fsinacn19%2F0%2Fw400h400%2F20180910%2F3391-hiycyfw5413589.jpg",
        "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=2156833431,1671740038&fm=26&gp=0.jpg",
        "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2319772070,3114389419&fm=26&gp=0.jpg",
        "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2871119264,233376496&fm=26&gp=0.jpg",
        "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=2034740944,4251903193&fm=26&gp=0.jpg",
        "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2898349460,268201268&fm=26&gp=0.jpg"
    ]
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var picImageView:UIImageView = {
        let obj = UIImageView()
        self.contentView.addSubview(obj)
        obj.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(10)
            make.top.equalTo(self.contentView).offset(10)
            make.bottom.equalTo(self.contentView).offset(-10)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        return obj
    }()
    
    lazy var titleLabel:UILabel = {
        var obj = UILabel()
        
        obj.numberOfLines = 2
        self.contentView.addSubview(obj)
        obj.snp.makeConstraints { (make) in
            make.left.equalTo(self.picImageView.snp.right).offset(10)
            make.right.equalTo(self.contentView).offset(-10)
            make.top.equalTo(self.picImageView)
        }
        return obj
    }()
    
    lazy var infoLabel:UILabel = {
        var obj = UILabel()
        self.contentView.addSubview(obj)
        obj.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleLabel.snp.bottom)
            make.left.equalTo(self.titleLabel)
            make.right.equalTo(self.titleLabel)
        }
        return obj
    }()
    
    lazy var timeLabel:UILabel = {
        var obj = UILabel()
        self.contentView.addSubview(obj)
        obj.snp.makeConstraints { (make) in
            make.right.equalTo(self.contentView)
            make.bottom.equalTo(self.contentView)
        }
        return obj
    }()
    
    func layoutUI() {
        self.titleLabel.textColor = colorFromHex(h: 0x333333)
        self.infoLabel.textColor = colorFromHex(h: 0x666666)
        self.timeLabel.textColor = colorFromHex(h: 0x999999)
    }
    
    func refreshViewWithModel(people:People) {
        self.titleLabel.text = people.username
        self.infoLabel.text = people.title
        self.picImageView.kf.setImage(with: URL(string: imageArray[Int(arc4random()) % imageArray.count]))
        self.timeLabel.text = ModelUtils.timeIntervalChangeToTimeStr(timeInterval: (people.dateline! as NSString).doubleValue*1000, dateFormat: nil)
    }
}
