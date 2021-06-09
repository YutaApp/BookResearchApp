//
//  GoogleBooksAPIModel.swift
//  BookResearchApp
//
//  Created by 齋藤勇太 on 2021/06/02.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol GetDataCompleteDelegate {
    func getDataOK(flag:Int)
}

class GoogleBooksAPIModel
{
    var params = [GoogleBooksAPIParams]()
    var getDataCompleteDelegate:GetDataCompleteDelegate?
    var newBookImageString = String()
    var strType1 = String()
    var strType2 = String()
    
    var strTitle = String()
    var strAuthor = String()
    var strBookImage = String()
    var strPublishedDate = String()
    var iPageCount = Int()
    var strISBN10 = String()
    var strISBN13 = String()
    var strDescription = String()
    
    
    func getData(url:String)
    {
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON
        { [self] (response) in
            
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
                    strType1 = ""
                    strType2 = ""
                    
                    strTitle = "不明"
                    strAuthor = "不明"
                    strBookImage = ""
                    strPublishedDate = "不明"
                    iPageCount = 0
                    strISBN10 = "表記なし"
                    strISBN13 = "表記なし"
                    strDescription = "なし"
                    
                    if let title = json["items"][i]["volumeInfo"]["title"].string
                    {
                        strTitle = title
                    }
                    
                    if let author = json["items"][i]["volumeInfo"]["authors"][0].string
                    {
                        strAuthor = author
                    }
                    
                    if let bookImage = json["items"][i]["volumeInfo"]["imageLinks"]["thumbnail"].string
                    {
                        strBookImage = bookImage
                        
                        let from = strBookImage.index(strBookImage.startIndex, offsetBy: 0)
                        let to   = strBookImage.index(strBookImage.startIndex, offsetBy: 5)
                        let compareString = String(strBookImage[from..<to])
                        
                        if(compareString != "https")
                        {
                            strBookImage = strBookImage.replacingOccurrences(of: "http", with: "https")
                        }
                    }
                    
                    if let publishedDate = json["items"][i]["volumeInfo"]["publishedDate"].string
                    {
                        strPublishedDate = publishedDate
                    }
                    
                    if let pageCount = json["items"][i]["volumeInfo"]["pageCount"].int
                    {
                        iPageCount = pageCount
                    }
                    
                    if let type1 = json["items"][i]["volumeInfo"]["industryIdentifiers"][0]["type"].string
                    {
                        strType1 = type1
                    }
                    
                    if let type2 = json["items"][i]["volumeInfo"]["industryIdentifiers"][1]["type"].string
                    {
                        strType2 = type2
                    }
                    
                    if strType1 == "ISBN_10"
                    {
                        if let isbn10 = json["items"][i]["volumeInfo"]["industryIdentifiers"][0]["identifier"].string
                        {
                            strISBN10 = isbn10
                        }
                    }
                    else if strType1 == "ISBN_13"
                    {
                        if let isbn13 = json["items"][i]["volumeInfo"]["industryIdentifiers"][0]["identifier"].string
                        {
                            strISBN13 = isbn13
                        }
                    }
                    
                    if strType2 == "ISBN_10"
                    {
                        if let isbn10 = json["items"][i]["volumeInfo"]["industryIdentifiers"][1]["identifier"].string
                        {
                            strISBN10 = isbn10
                        }
                    }
                    else if strType2 == "ISBN_13"
                    {
                        if let isbn13 = json["items"][i]["volumeInfo"]["industryIdentifiers"][1]["identifier"].string
                        {
                            strISBN13 = isbn13
                        }
                    }
                   
                    
                    if let description = json["items"][i]["volumeInfo"]["description"].string
                    {
                        strDescription = description
                    }
                    
                    let getGoogleBooksAPIData = GoogleBooksAPIParams(strTitle: strTitle, strAuthor: strAuthor, strBookImageString: strBookImage, strPublishedDate: strPublishedDate, iPageCount: iPageCount, strISBN10: strISBN10, strISBN13: strISBN13, strDescription: strDescription)
                        
                        self.params.append(getGoogleBooksAPIData)
                }
                
                self.getDataCompleteDelegate?.getDataOK(flag: 1)
                
            case .failure(let error):
                print(error)
                
            }
            
        }
    }
}
