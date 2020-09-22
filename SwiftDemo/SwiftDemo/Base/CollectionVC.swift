//
//  CollectionVC.swift
//  SwiftDemo
//
//  Created by sinosun on 2020/9/21.
//  Copyright © 2020 sinosun. All rights reserved.
//

import UIKit

class CollectionVC: NormalVC, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let reuseIdentifier = "Cell"
    
    lazy var colletionView:UICollectionView = {
        var layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let obj = UICollectionView.init(frame: self.view.frame, collectionViewLayout: layout)
        obj.delegate = self
        obj.dataSource = self
        obj.showsHorizontalScrollIndicator = false
        obj.showsVerticalScrollIndicator = false
        obj.register(NSClassFromString("UICollectionViewCell"), forCellWithReuseIdentifier: reuseIdentifier)
        self.view.addSubview(obj)
        return obj
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        layoutUI()
    }
    
    override func layoutUI() {
        super.layoutUI()
        self.colletionView.contentInsetAdjustmentBehavior = .never;
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }

}
