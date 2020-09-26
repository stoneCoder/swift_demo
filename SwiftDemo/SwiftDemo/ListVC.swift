//
//  ListVC.swift
//  SwiftDemo
//
//  Created by Consle on 2020/9/26.
//  Copyright © 2020 Consle. All rights reserved.
//

import UIKit

class ListVC: DetailVC {
    
    let reuseIdentifier = "ListCell"
    
    lazy var model:Person = {
        let obj = Person()
        
        return obj
    }()
    var data:Array<People>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.layoutUI()
        self.updateAll()
    }
    
    override func layoutUI() {
        super.layoutUI()
        self.tableView.register(ListViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
    
    func updateAll(){
        self.requestData()
    }
    
    func requestData() {
        model.request(url: test_list_data, method: .get, headers: nil, success: {[weak self] (dic) in
            //处理服务器返回数据
            let jsonStr = ModelUtils.jsonDicToString(jsonDic: dic)
            let response = try? JSONDecoder().decode(SSResponse.self, from:(jsonStr?.data(using: .utf8))!)
            self?.data = response!.result
            
            self?.callHandleInMainThread {
                self?.tableView.reloadData()
            }
            print("2-----------\(response!)")
        }, fail: { (dic) in

        }, error: nil)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! ListViewCell
        cell.refreshViewWithModel(people: self.data![index])
        return cell
    }

}
