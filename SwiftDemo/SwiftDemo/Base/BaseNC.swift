//
//  BaseNav.swift
//  SwiftDemo
//
//  Created by sinosun on 2020/9/21.
//  Copyright © 2020 sinosun. All rights reserved.
//

import UIKit

class BaseNC: UINavigationController,UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.delegate = self
    }
    
    func refreshNavBgColor(isWhiteBg:Bool) {
        if(isWhiteBg){
            self.navigationBar.barTintColor = colorFromHex(h: 0xf9f9f9)
            self.navigationBar.isTranslucent = false
            
            let bgImage = UIImage.init(named: "mine_home_nav_bg")?.resizableImage(withCapInsets: UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0), resizingMode: UIImage.ResizingMode.stretch)
            self.navigationBar.setBackgroundImage(bgImage, for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
            self.navigationBar.shadowImage = UIImage.imageWithColor(color: UIColor.clear,size: CGSize.init(width: SCREEN_WIDTH, height: LINE_HEIGHT))
        }else{
            self.navigationBar.barTintColor = colorFromHex(h: 0xf9f9f9)
            self.navigationBar.isTranslucent = false
            
            let bgImage = UIImage.imageWithColor(color: UIColor.white)?.resizableImage(withCapInsets: UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0), resizingMode: UIImage.ResizingMode.stretch)
            self.navigationBar.setBackgroundImage(bgImage, for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
            self.navigationBar.shadowImage = UIImage.imageWithColor(color: UIColor.clear,size: CGSize.init(width: SCREEN_WIDTH, height: LINE_HEIGHT))
        }
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if(self.responds(to: #selector(getter: interactivePopGestureRecognizer)) && animated){
            self.interactivePopGestureRecognizer?.isEnabled = false
        }
        
        super.pushViewController(viewController, animated: animated)
    }
    
    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        if(self.responds(to: #selector(getter: interactivePopGestureRecognizer)) && animated){
            self.interactivePopGestureRecognizer?.isEnabled = false
        }
        
        return super.popToRootViewController(animated: animated)
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        if(self.responds(to: #selector(getter: interactivePopGestureRecognizer)) && animated){
            self.interactivePopGestureRecognizer?.isEnabled = false
        }
        
        return super.popViewController(animated: animated)
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
    }
    
    func gestureRecognizerShouldBegin(gestureRecognizer:UIGestureRecognizer) -> Bool {
        if(gestureRecognizer === self.interactivePopGestureRecognizer){
            if(self.viewControllers.count < 2 || self.visibleViewController == self.viewControllers.first){
                return false
            }
        }
        return true
    }

}
