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
    
    func showAlertViewInActionSheetStyle(ary:NSArray,confirmAction:((_ action:UIAlertAction,_ index:Int)->Void)?){
        self.showAlertView(title: nil, message: nil, ary: ary, customTitleStyle: nil, confirmAction: confirmAction)
    }
    
    func showAlertViewJustText(message:String,confirmAction:((_ action:UIAlertAction)->Void)?) {
        self.showAlertView(title: nil, message: message, confirmBtnTitle: "确定", confirmAction: confirmAction)
    }
    
    func showAlertView(title:String?,
                               message:String,
                               confirmBtnTitle:String,
                               confirmAction:((_ action:UIAlertAction)->Void)?){
        let alertVC = UIAlertController.init(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let actionYES = UIAlertAction.init(title: confirmBtnTitle, style: UIAlertAction.Style.default) { (action) in
            confirmAction?(action)
        }
        alertVC.addAction(actionYES)
        
        DispatchQueue.main.async {
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    func showAlertView(title:String?,
                       message:String,
                       cancelBtnTitle:String,
                       confirmBtnTitle:String,
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
    
    func showAlertView(title:String?,
                       message:String?,
                       ary:NSArray,
                       customTitleStyle:((_ alertVC:UIAlertController)->Void)?,
                       confirmAction:((_ action:UIAlertAction,_ index:Int)->Void)?) {
        let alertVC = UIAlertController.init(title: title, message: message, preferredStyle: UIAlertController.Style.actionSheet)
        
        customTitleStyle?(alertVC)
        
        for i in 0...ary.count{
            let actionYES = UIAlertAction.init(title: (ary.object(at: i) as! String), style: UIAlertAction.Style.default) { (action) in
                confirmAction?(action,i)
            }
            alertVC.addAction(actionYES)
        }
        
        alertVC.addAction(UIAlertAction.init(title: "取消", style: UIAlertAction.Style.default, handler: nil))
        
        DispatchQueue.main.async {
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    func callHandleInMainThread(_ handle: (()->Void)?) {
        if(Thread.isMainThread){
            handle?()
        }else{
            DispatchQueue.main.async {
                handle?()
            }
        }
    }
}
