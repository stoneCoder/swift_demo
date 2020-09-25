//
//  MVVMViewModel.swift
//  SwiftDemo
//
//  Created by Consle on 2020/9/24.
//  Copyright © 2020 Consle. All rights reserved.
//

import UIKit
import Alamofire

class MVVMViewModel: NSObject {
    func getRequest<Parameters: Encodable>(url:String,
                                           parameters:Parameters?,
                                           success : @escaping (_ responseObject : Dictionary<String,AnyObject>) -> Void,
                                           fail :  ((_ responseObject : Dictionary<String,AnyObject>) -> Void)?,
                                           error :  ((_ error : NSError) -> Void)?) {
        self.request(url: url, method: .get, parameters: parameters, headers: nil, success: success, fail: fail, error: error)
    }
    
    func postRequest<Parameters: Encodable>(url:String,
                                            parameters:Parameters?,
                                            success : @escaping (_ responseObject : Dictionary<String,AnyObject>) -> Void,
                                            fail :  ((_ responseObject : Dictionary<String,AnyObject>) -> Void)?,
                                            error :  ((_ error : NSError) -> Void)?) {
        self.request(url: url, method: .post, parameters: parameters, headers: nil, success: success, fail: fail, error: error)
    }
    
    func request<Parameters: Encodable>(url:String,
                                        method:HTTPMethod ,
                                        parameters:Parameters?,
                                        headers:HTTPHeaders?,
                                        success : @escaping ((_ responseObject : Dictionary<String,AnyObject>) -> Void),
                                        fail :  ((_ responseObject : Dictionary<String,AnyObject>) -> Void)?,
                                        error : ((_ error : NSError) -> Void)?) {
        
        AF.request(url, method: method, parameters: parameters, encoder: JSONParameterEncoder.default ,headers: headers).responseJSON { response in
            switch response.result{
            case .success(let json):
                print("server return is ------- \(json)")
                let dic = json as! Dictionary<String,AnyObject>
                self.responseCallBack(dic: dic, success: success, fail: fail)
            case .failure(let netError):
                error?(netError as NSError)
            }
        }
    }
    
    func request(url:String,
                 method:HTTPMethod ,
                 headers:HTTPHeaders?,
                 success : @escaping ((_ responseObject : Dictionary<String,AnyObject>) -> Void),
                 fail :  ((_ responseObject : Dictionary<String,AnyObject>) -> Void)?,
                 error : ((_ error : NSError) -> Void)?){
        let requestUrl = BaseUrl + url
        AF.request(requestUrl, method: method,  headers: headers).responseJSON { (response) in
            switch response.result{
            case .success(let json):
                print("server return is ------- \(json)")
                let dic = json as! Dictionary<String,AnyObject>
                self.responseCallBack(dic: dic, success: success, fail: fail)
            case .failure(let netError):
                error?(netError as NSError)
            }
        }
    }
    
    func responseCallBack(dic:Dictionary<String,AnyObject>,
                          success : @escaping ((_ responseObject : Dictionary<String,AnyObject>) -> Void),
                          fail :  ((_ responseObject : Dictionary<String,AnyObject>) -> Void)?) {
        success(dic)
    }
}
