//
//  LibraryInfoGetModel.swift
//  BookResearchApp
//
//  Created by 齋藤勇太 on 2021/06/12.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol CityNameGetDataCompleteDelegate
{
    func cityNameAppendOK(flag:Int)
}

class LibraryInfoGetModel
{
    var strCityName = String()
    var strCityNameArray = [String]()
    var cityNameGetDataComplete:CityNameGetDataCompleteDelegate?
    
    func getCityName(url:String)
    {
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON
        { [self](response) in
            
            switch(response.result)
            {
            case .success:
                let json = JSON(response.data as Any)
                
                strCityNameArray.removeAll()
                
                for i in 0..<json.count
                {
                    if let cityName = json[i]["city"].string
                    {
                        strCityName = cityName
                        
                        if !strCityNameArray.contains(strCityName)
                        {
                            strCityNameArray.append(strCityName)
                        }
                    }
                }
                cityNameGetDataComplete?.cityNameAppendOK(flag: 1)
                
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
