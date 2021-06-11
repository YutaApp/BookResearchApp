//
//  FavoriteBookDB.swift
//  BookResearchApp
//
//  Created by 齋藤勇太 on 2021/06/09.
//

import Foundation
import RealmSwift

class FavoriteBookDB:Object
{
    @objc dynamic var strTitle:String = ""
    @objc dynamic var strAuthor:String = ""
    @objc dynamic var strBookImageString:String = ""
    @objc dynamic var strPublishedDate:String = ""
    @objc dynamic var iPageCount:Int = 0
    @objc dynamic var strISBN10:String = ""
    @objc dynamic var strISBN13:String = ""
    @objc dynamic var strDescription:String = ""
}
