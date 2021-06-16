//
//  SearchBooksOfLibraryViewController.swift
//  BookResearchApp
//
//  Created by 齋藤勇太 on 2021/06/11.
//

import UIKit
import DropDown
import PKHUD

class SearchBooksOfLibraryViewController: UIViewController,CalilGetDataCompleteDelegate,UITableViewDelegate,UITableViewDataSource,TableViewReloadOKDelegate{
   
    @IBOutlet weak var dropdownViewC: UIView!
    @IBOutlet weak var dropdownView: UIView!
    @IBOutlet weak var prefectureNameBtn: UIButton!
    @IBOutlet weak var cityNameBtn: UIButton!
    @IBOutlet weak var isbnTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    let appKey:String = "0843cb9fb76b0d035ac60cc0cbf885d4"
    let libraryInfoGetModel = LibraryInfoGetModel()
    let calilBookJyoutaiGetModel = CalilBookJyoutaiGetModel()
    var searchIndex = Int()
    var systemid:String = ""
    
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
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
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
            searchIndex = index
        }
    }
    
    func calilGetDataAppendOK(flag: Int)
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
    
    @IBAction func search(_ sender: Any)
    {
        HUD.show(.progress)
        
        for i in 0..<libraryInfoGetModel.libraryInfoGetParamsArray.count
        {
            if libraryInfoGetModel.libraryInfoGetParamsArray[i].strCityName == libraryInfoGetModel.strCityNameArray[searchIndex]
            {
                systemid = libraryInfoGetModel.libraryInfoGetParamsArray[i].strSystemid
                break
            }
        }
        
        if isbnTextField.text?.isEmpty == false && systemid != ""
        {
            let url = "https://api.calil.jp/check?appkey=\(appKey)&isbn=\(isbnTextField.text!)&systemid=\(systemid)&callback=no"
            
            print(url)
            
            calilBookJyoutaiGetModel.kashidashiCheck(url: url, isbn: isbnTextField.text!, systemid: systemid)
            calilBookJyoutaiGetModel.tableViewReloadOKDelegate = self
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return calilBookJyoutaiGetModel.libkeyKArray.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        cell.setRandomBackgroundColor()
        
        for i in 0..<libraryInfoGetModel.libraryInfoGetParamsArray.count
        {
            if calilBookJyoutaiGetModel.libkeyKArray[indexPath.row] == libraryInfoGetModel.libraryInfoGetParamsArray[i].strLibkey
            {
                cell.libNameLabel.text = libraryInfoGetModel.libraryInfoGetParamsArray[i].strFormal
                print(cell.libNameLabel.text!)
            }
        }
        cell.confirmLabel.text = calilBookJyoutaiGetModel.libkeyVArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return tableView.estimatedRowHeight
    }
    
    func reloadOK(flg: Int)
    {
        if flg == 1
        {
            tableView.reloadData()
            HUD.hide()
        }
    }
    
}
