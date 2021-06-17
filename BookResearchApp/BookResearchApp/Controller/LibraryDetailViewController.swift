//
//  LibraryDetailViewController.swift
//  BookResearchApp
//
//  Created by 齋藤勇太 on 2021/06/16.
//

import UIKit

class LibraryDetailViewController: UIViewController {

    var strFormal = String()
    var strShort = String()
    var strCategory = String()
    var strAddress = String()
    var strTel = String()
    
    @IBOutlet weak var formalLabel: UILabel!
    @IBOutlet weak var shortLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var telLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        formalLabel.text = strFormal
        shortLabel.text = strShort
        decideCategoryName(label: categoryLabel, cate: strCategory)
        addressLabel.text = strAddress
        telLabel.text = strTel
    }
    
    func decideCategoryName(label:UILabel,cate:String)
    {
        switch (cate) {
        case "SMALL":
            label.text = "図書室・公民館"
            break
        
        case "MEDIUM":
            label.text = "図書館(地域)"
            break
        
        case "LARGE":
            label.text = "図書館(広域)"
            break
        
        case "UNIV":
            label.text = "大学"
            break
            
        case "SPECIAL":
            label.text = "専門"
            break
            
        case "BM":
            label.text = "移動・BM"
            break
        default:
            label.text = ""
        }
    }

}
