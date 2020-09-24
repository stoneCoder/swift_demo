//
//  UIViewController+ShowAlertView.swift
//  SwiftDemo
//
//  Created by Consle on 2020/9/22.
//  Copyright © 2020 Consle. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    func showHaveNoTitleAlertView(message:String,cancelAction:((_ action:UIAlertAction)->Void)?,confirmAction:((_ action:UIAlertAction)->Void)?) {
        self.showAlertView(title: nil, message: message, cancelBtnTitle: "取消", confirmBtnTitle: "确定", customTitleStyle: nil, cancelAction: cancelAction, confirmAction: confirmAction)
    }
    
    func showAlertView(title:String?,message:String,cancelBtnTitle:String,confirmBtnTitle:String,
                       customTitleStyle:((_ alertVC:UIAlertController)->Void)?,
                       cancelAction:((_ action:UIAlertAction)->Void)?,
                       confirmAction:((_ action:UIAlertAction)->Void)?){
        let alertVC = UIAlertController.init(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        customTitleStyle?(alertVC)
        
        let actionCancel = UIAlertAction.init(title: cancelBtnTitle, style: UIAlertAction.Style.default) { (action) in
            cancelAction?(action)
        }
        
        let actionYES = UIAlertAction.init(title: confirmBtnTitle, style: UIAlertAction.Style.default) { (action) in
            confirmAction?(action)
        }
        
        alertVC.addAction(actionCancel)
        alertVC.addAction(actionYES)
        
        DispatchQueue.main.async {
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    func showAlertView(title:String?,message:String,ary:NSArray,
                       customTitleStyle:((_ alertVC:UIAlertController)->Void)?,
                       cancelAction:((_ action:UIAlertAction)->Void)?,
                       confirmAction:((_ action:UIAlertAction)->Void)?) {
        
    }
}
