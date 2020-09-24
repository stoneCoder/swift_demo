//
//  DetailVC.swift
//  SwiftDemo
//
//  Created by Consle on 2020/9/21.
//  Copyright © 2020 Consle. All rights reserved.
//

import UIKit

class DetailVC: NormalVC, UITableViewDelegate, UITableViewDataSource{
    var isPlainStyle = false
    
    lazy var tableView:UITableView = {
        var obj:UITableView = UITableView(frame: self.view.frame, style: .grouped)
        if(self.isPlainStyle){
            obj = UITableView(frame: .zero, style: .plain)
        }
        obj.delegate = self
        obj.showsVerticalScrollIndicator = false
        obj.showsHorizontalScrollIndicator = false
        obj.separatorStyle = .none
        obj.tableFooterView = UIView()
        self.view.addSubview(obj)
        return obj
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
        // Do any additional setup after loading the view.
    }
    
    override func layoutUI() {
        super.layoutUI()
        self.tableView.contentInsetAdjustmentBehavior = .never;
        self.tableView.dataSource = self
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

}
