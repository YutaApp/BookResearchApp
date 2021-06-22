//
//  LibraryInfoGetModel.swift
//  BookResearchApp
//
//  Created by 齋藤勇太 on 2021/06/12.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol CalilGetDataCompleteDelegate
{
    func calilGetDataAppendOK(flag:Int)
}

class LibraryInfoGetModel
{
    var strCityName = String()
    var strGeocode  = String()
    var strSystemid = String()
    var strAddress  = String()
    var strTel = String()
    var strLibkey = String()
    var strFormal = String()
    var strShort = String()
    var strCategory = String()
    
    var libraryInfoGetParamsArray = [LibraryInfoGetParams]()
    var strCityNameArray = [String]()
    var strSystemidArray = [String]()
    var cityNameGetDataComplete:CalilGetDataCompleteDelegate?
    
    func getCityName(url:String)
    {
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON
        { [self](response) in
            
            switch(response.result)
            {
            case .success:
                let json = JSON(response.data as Any)
                
                libraryInfoGetParamsArray.removeAll()
                strCityNameArray.removeAll()
                
                for i in 0..<json.count
                {
                    if let cityName = json[i]["city"].string,let geocode = json[i]["geocode"].string,let systemid = json[i]["systemid"].string,let address = json[i]["address"].string,let tel = json[i]["tel"].string, let libkey = json[i]["libkey"].string,let formal = json[i]["formal"].string,let short = json[i]["short"].string,let category = json[i]["category"].string
                    {
                        strCityName = cityName
                        strGeocode = geocode
                        strSystemid = systemid
                        strAddress = address
                        strTel = tel
                        strLibkey = libkey
                        strFormal = formal
                        strShort = short
                        strCategory = category
                        
                        let libraryInfoGetParams = LibraryInfoGetParams(strCityName: strCityName, strGeocode: strGeocode, strSystemid: strSystemid, strAddress: strAddress, strTel: strTel, strLibkey: strLibkey,strFormal: strFormal,strShort: short,strCategory: category)
                        
                        libraryInfoGetParamsArray.append(libraryInfoGetParams)
                        
                        if !strCityNameArray.contains(cityName)
                        {
                            strCityNameArray.append(cityName)
                            strSystemidArray.append(systemid)
                        }
                    }
                }
                cityNameGetDataComplete?.calilGetDataAppendOK(flag: 1)
                
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
