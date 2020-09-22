//
//  UIViewController+ShowAlertView.swift
//  SwiftDemo
//
//  Created by sinosun on 2020/9/22.
//  Copyright © 2020 sinosun. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    func showNormalAlertView(message:String,cancelAction:((_ action:UIAlertAction)->Void)?,confirmAction:((_ action:UIAlertAction)->Void)?) {
        
    }
    
    func showAlertView(title:String,message:String,cancelBtnTitle:String,confirmBtnTitle:String,
                       customTitleStyle:((_ alertVC:UIAlertController)->Void)?,
                       cancelAction:((_ action:UIAlertAction)->Void)?,
                       confirmAction:((_ action:UIAlertAction)->Void)?){
        let alertVC = UIAlertController.init(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        customTitleStyle?(alertVC)
    }
}
