//
//  CalilBookJyoutaiGetModel.swift
//  BookResearchApp
//
//  Created by 齋藤勇太 on 2021/06/14.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol TableViewReloadOKDelegate
{
    func reloadOK(flg:Int)
}

class CalilBookJyoutaiGetModel
{
    var libkey = [String:Any]()
    var libkeyKArray = [String]()
    var libkeyVArray = [String]()
    var tableViewReloadOKDelegate:TableViewReloadOKDelegate?
    
    func kashidashiCheck(url:String,isbn:String,systemid:String)
    {
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON
        { [self] (response) in
            
            switch(response.result)
            {
            case .success:
                let json = JSON(response.data as Any)
                
                if let libkey2:[String:Any] = json["books"]["\(isbn)"]["\(systemid)"]["libkey"].dictionary
                {
                    libkey = libkey2
                    
                    libkeyKArray.removeAll()
                    libkeyVArray.removeAll()
                    
                    for (k,v) in libkey
                    {
                        libkeyKArray.append(k)
                        libkeyVArray.append("\(v)")
                    }
                    
                    tableViewReloadOKDelegate?.reloadOK(flg: 1)
                }
                else
                {
                    kashidashiCheck(url: url, isbn: isbn, systemid: systemid)
                }
               
            case .failure(let error):
                print(error)
            }
        }
    }
}
