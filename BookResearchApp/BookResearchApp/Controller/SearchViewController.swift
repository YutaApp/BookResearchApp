//
//  SearchViewController.swift
//  BookResearchApp
//
//  Created by 齋藤勇太 on 2021/05/30.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var bubunLabel: UILabel!
    @IBOutlet weak var kanzenLabel: UILabel!
    @IBOutlet weak var newOrderLabel: UILabel!
    
    @IBOutlet weak var searchKeywordTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var publisherTextField: UITextField!
    
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var authorImageView: UIImageView!
    @IBOutlet weak var publisherImageView: UIImageView!
    @IBOutlet weak var alertLabel: UILabel!
    @IBOutlet weak var bubunSearchImageView: UIImageView!
    @IBOutlet weak var kanzenSearchImageView: UIImageView!
    @IBOutlet weak var newOrderImageView: UIImageView!
    
    var titleTapFlg = false
    var authorTapFlg = false
    var publisherTapFlg = false
    var bubunTapFlg = false
    var newOrderTapFlg = false
    var kanzenTapFlg = false
    var searchURL = ""
    
    var googleBooksAPIModel = GoogleBooksAPIModel()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        alertLabel.isHidden = true
        ChangeImageViewAndLabelLayer(imageView: newOrderImageView, label: newOrderLabel, color: .gray, imageName: "square", useFlg: false)
        ChangeTextFieldLayer(textField: titleTextField, imageView: titleImageView,tapFlg: false)
        ChangeTextFieldLayer(textField: authorTextField, imageView: authorImageView,tapFlg: false)
        ChangeTextFieldLayer(textField: publisherTextField, imageView: publisherImageView,tapFlg: false)
    }
    
    @IBAction func bubunTap(_ sender: Any)
    {
        if(!bubunTapFlg)
        {
            ChangeImageViewAndLabelLayer(imageView: kanzenSearchImageView, label: kanzenLabel, color: .gray, imageName: "square", useFlg: false)
            ChangeImageViewAndLabelLayer(imageView: newOrderImageView, label: newOrderLabel, color: .black, imageName: "square", useFlg: true)
            
            bubunSearchImageView.image = UIImage(systemName: "checkmark.square")
            bubunTapFlg = true
        }
        else if(bubunTapFlg)
        {
            ChangeImageViewAndLabelLayer(imageView: kanzenSearchImageView, label: kanzenLabel, color: .black, imageName: "square", useFlg: true)
            
            bubunSearchImageView.image = UIImage(systemName: "square")
            bubunTapFlg = false
        }
        
        if(!bubunTapFlg && !kanzenTapFlg)
        {
            ChangeImageViewAndLabelLayer(imageView: newOrderImageView, label: newOrderLabel, color: .gray, imageName:  "square", useFlg: false)
            newOrderTapFlg = false
        }
    }
    
    @IBAction func kanzenTap(_ sender: Any)
    {
        if(!kanzenTapFlg)
        {
            ChangeImageViewAndLabelLayer(imageView: bubunSearchImageView, label: bubunLabel, color: .gray, imageName: "square", useFlg: false)
            ChangeImageViewAndLabelLayer(imageView: newOrderImageView, label: newOrderLabel, color: .black, imageName: "square", useFlg: true)
            
            kanzenSearchImageView.image = UIImage(systemName: "checkmark.square")
            kanzenTapFlg = true
        }
        else if(kanzenTapFlg)
        {
            ChangeImageViewAndLabelLayer(imageView: bubunSearchImageView, label: bubunLabel, color: .black, imageName: "square", useFlg: true)
            
            kanzenSearchImageView.image = UIImage(systemName: "square")
            kanzenTapFlg = false
        }
        
        if(!bubunTapFlg && !kanzenTapFlg)
        {
            ChangeImageViewAndLabelLayer(imageView: newOrderImageView, label: newOrderLabel, color: .gray, imageName:  "square", useFlg: false)
            newOrderTapFlg = false
        }
    }
    
    
    @IBAction func newOrderTap(_ sender: Any)
    {
        if(bubunTapFlg || kanzenTapFlg)
        {
            if(!newOrderTapFlg)
            {
                newOrderImageView.image = UIImage(systemName: "checkmark.square")
                newOrderTapFlg = true
            }
            else if(newOrderTapFlg)
            {
                newOrderImageView.image = UIImage(systemName: "square")
                newOrderTapFlg = false
            }
            
        }
        else
        {
            ChangeImageViewAndLabelLayer(imageView: newOrderImageView, label: newOrderLabel, color: .gray, imageName:  "square", useFlg: false)
            newOrderTapFlg = false
        }
    }
    
    
    @IBAction func titleTap(_ sender: Any)
    {
        if(searchKeywordTextField.text?.isEmpty == false)
        {
            if(titleTapFlg)
            {
                ChangeTextFieldLayer(textField: titleTextField, imageView: titleImageView, tapFlg: false)
                titleTapFlg = false
            }
            else if(!titleTapFlg)
            {
                ChangeTextFieldLayer(textField: titleTextField, imageView: titleImageView, tapFlg: true)
                titleTapFlg = true
            }
        }
    }
    
    @IBAction func authorTap(_ sender: Any)
    {
        if(searchKeywordTextField.text?.isEmpty == false)
        {
            if(authorTapFlg)
            {
                ChangeTextFieldLayer(textField: authorTextField, imageView: authorImageView, tapFlg: false)
                authorTapFlg = false
            }
            else if(!authorTapFlg)
            {
                ChangeTextFieldLayer(textField: authorTextField, imageView: authorImageView, tapFlg: true)
                authorTapFlg = true
            }
        }
    }
    
    
    @IBAction func publisherTap(_ sender: Any)
    {
        if(searchKeywordTextField.text?.isEmpty == false)
        {
            if(publisherTapFlg)
            {
                ChangeTextFieldLayer(textField: publisherTextField, imageView: publisherImageView, tapFlg: false)
                publisherTapFlg = false
            }
            else if(!publisherTapFlg)
            {
                ChangeTextFieldLayer(textField: publisherTextField, imageView: publisherImageView, tapFlg: true)
                publisherTapFlg = true
            }
        }
    }
    
    func ChangeTextFieldLayer(textField:UITextField!,imageView:UIImageView,tapFlg:Bool)
    {
        if(!tapFlg)
        {
            textField.isEnabled = false
            textField.backgroundColor = UIColor.lightGray
            textField.alpha = 0.5
            imageView.image = UIImage(systemName: "square")
        }
        else if(tapFlg)
        {
            textField.isEnabled = true
            textField.backgroundColor = UIColor.white
            textField.alpha = 1.0
            imageView.image = UIImage(systemName: "checkmark.square")
        }
    }
    
    func ChangeImageViewAndLabelLayer(imageView:UIImageView!, label:UILabel!, color:UIColor! ,imageName:String!,useFlg:Bool!)
    {
        imageView.isUserInteractionEnabled = useFlg
        imageView.image = UIImage(systemName: imageName)
        label.textColor = color
    }
    
    func MakeGoogleBooksAPIRequestURL() -> URL?
    {
        var requestURL:URL?
        
        searchURL = "https://www.googleapis.com/books/v1/volumes?q=\(searchKeywordTextField.text!)"
        
        if(kanzenTapFlg)
        {
            searchURL += "-term"
        }
        
        if(titleTapFlg)
        {
            searchURL += "+intitle:\(titleTextField.text!)"
        }
        
        if(authorTapFlg)
        {
            searchURL += "+inauthor:\(authorTextField.text!)"
        }
        
        if(publisherTapFlg)
        {
            searchURL += "+inpublisher:\(publisherTextField.text!)"
        }
        
        if(newOrderTapFlg)
        {
            searchURL += "&orderBy=newest"
        }
        
        searchURL += "&langRestrict=ja&maxResults=40"
        
        let encodingSearchURL = searchURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        requestURL = URL(string:encodingSearchURL!)!
        
        print(requestURL as Any)

        return requestURL
        
    }
    
    @IBAction func searchAction(_ sender: Any)
    {
        if(searchKeywordTextField.text?.isEmpty == true)
        {
            searchKeywordTextField.layer.borderColor = UIColor.red.cgColor
            searchKeywordTextField.layer.borderWidth = 0.5
            alertLabel.isHidden = false
        }
        else
        {
            searchKeywordTextField.layer.borderWidth = 0.0
            alertLabel.isHidden = true
            
            //作成した検索URLを元にAFでGoogle Books APIを叩く
            googleBooksAPIModel.getData(url:MakeGoogleBooksAPIRequestURL()!)
        }
    }
}
