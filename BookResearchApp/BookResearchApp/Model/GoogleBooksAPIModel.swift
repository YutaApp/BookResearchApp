//
//  GoogleBooksAPIModel.swift
//  BookResearchApp
//
//  Created by 齋藤勇太 on 2021/06/02.
//

import Foundation
import Alamofire
import SwiftyJSON

class GoogleBooksAPIModel
{
    let params = [GoogleBooksAPIParams]()
    
    func getData(url:URL)
    {
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON
        { (response) in
            
            switch(response.result)
            {
            case .success:
                let json = JSON(response.data as Any)
                var itemCount = json["totalItems"].int!
                
                if(itemCount > 40)
                {
                    itemCount = 40
                }
                
                for i in 0 ..< itemCount
                {
                    let title = json["items"][i]["volumeInfo"]["title"]
                    print(title)
                }
                
                
            case .failure(let error):
                print(error)
                
            }
            
        }
    }
}
