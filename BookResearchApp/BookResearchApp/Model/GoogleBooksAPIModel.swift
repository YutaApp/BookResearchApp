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
                    let title = json["items"][i]["volumeInfo"]["title"].string!
                    let author = json["items"][i]["volumeInfo"]["authors"][0].string!
                    var bookImage = json["items"][i]["volumeInfo"]["imageLinks"]["thumbnail"].string!
                    let publishedDate = json["items"][i]["volumeInfo"]["publishedDate"].string!
                    let pageCount = json["items"][i]["volumeInfo"]["pageCount"].int!
                    let isbn10 = json["items"][i]["volumeInfo"]["industryIdentifiers"][0]["identifier"].string!
                    let isbn13 = json["items"][i]["volumeInfo"]["industryIdentifiers"][1]["identifier"].string!
                    let description = json["items"][i]["volumeInfo"]["description"].string!
                    
                    let from = bookImage.index(bookImage.startIndex, offsetBy: 0)
                    let to   = bookImage.index(bookImage.startIndex, offsetBy: 5)
                    let compareString = String(bookImage[from..<to])
                    
                    if(compareString != "https")
                    {
                        bookImage = bookImage.replacingOccurrences(of: "http", with: "https")
                    }
                    
                    let getGoogleBooksAPIData = GoogleBooksAPIParams(strTitle: title, strAuthor: author, strBookImageString: bookImage, strPublishedDate: publishedDate, iPageCount: pageCount, strISBN10: isbn10, strISBN13: isbn13, strDescription: description)
                        
                        self.params.append(getGoogleBooksAPIData)
                }
                
                self.getDataCompleteDelegate?.getDataOK(flag: 1)
                
            case .failure(let error):
                print(error)
                
            }
            
        }
    }
}
