//
//  SearchBooksOfLibraryViewController.swift
//  BookResearchApp
//
//  Created by 齋藤勇太 on 2021/06/11.
//

import UIKit
import DropDown

class SearchBooksOfLibraryViewController: UIViewController,CityNameGetDataCompleteDelegate {
   
    @IBOutlet weak var dropdownViewC: UIView!
    @IBOutlet weak var dropdownView: UIView!
    @IBOutlet weak var prefectureNameBtn: UIButton!
    @IBOutlet weak var cityNameBtn: UIButton!
    
    let appKey:String = "0843cb9fb76b0d035ac60cc0cbf885d4"
    let libraryInfoGetModel = LibraryInfoGetModel()
    
    let dropDown = DropDown()
    let dropDownC = DropDown()
    let prefectureNameArray = [
        "北海道",
        "青森県",
        "岩手県",
        "宮城県",
        "秋田県",
        "山形県",
        "福島県",
        "茨城県",
        "栃木県",
        "群馬県",
        "埼玉県",
        "千葉県",
        "東京都",
        "神奈川県",
        "新潟県",
        "富山県",
        "石川県",
        "福井県",
        "山梨県",
        "長野県",
        "岐阜県",
        "静岡県",
        "愛知県",
        "三重県",
        "滋賀県",
        "京都府",
        "大阪府",
        "兵庫県",
        "奈良県",
        "和歌山県",
        "鳥取県",
        "島根県",
        "岡山県",
        "広島県",
        "山口県",
        "徳島県",
        "香川県",
        "愛媛県",
        "高知県",
        "福岡県",
        "佐賀県",
        "長崎県",
        "熊本県",
        "大分県",
        "宮崎県",
        "鹿児島県",
        "沖縄県"
    ]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        initDropDown()
    }
    
    func initDropDown()
    {
        dropDown.anchorView = dropdownView
        dropDown.dataSource = prefectureNameArray
        dropDown.selectionAction = {[unowned self] (index:Int, item:String) in
            prefectureNameBtn.setTitle(prefectureNameArray[index], for: .normal)
            
            let url = "https://api.calil.jp/library?appkey=\(appKey)&pref=\(prefectureNameArray[index])&format=json&callback="
            let encodingURL = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            libraryInfoGetModel.getCityName(url: encodingURL!)
            libraryInfoGetModel.cityNameGetDataComplete = self
        }
    }
    
    func initDropDownC()
    {
        dropDownC.anchorView = dropdownViewC
        dropDownC.dataSource = libraryInfoGetModel.strCityNameArray
        dropDownC.selectionAction = {[unowned self](index:Int,item:String)in
            cityNameBtn.setTitle(libraryInfoGetModel.strCityNameArray[index], for: .normal)
        }
    }
    
    func cityNameAppendOK(flag: Int)
    {
        if flag == 1
        {
            cityNameBtn.setTitle(libraryInfoGetModel.strCityNameArray[0], for: .normal)
            initDropDownC()
        }
    }
    
    @IBAction func selectPrefectureButton(_ sender: Any)
    {
        dropDown.show()
    }
    
  
    @IBAction func selectCityButton(_ sender: Any)
    {
        dropDownC.show()
    }
    
    
}
