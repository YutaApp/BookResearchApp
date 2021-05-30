//
//  SearchViewController.swift
//  BookResearchApp
//
//  Created by 齋藤勇太 on 2021/05/30.
//

import UIKit

class SearchViewController: UIViewController {

    
    @IBOutlet weak var searchKeywordTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var publisherTextField: UITextField!
    
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var authorImageView: UIImageView!
    @IBOutlet weak var publisherImageView: UIImageView!
    @IBOutlet weak var alertLabel: UILabel!
    
    var titleTapFlg = false
    var authorTapFlg = false
    var publisherTapFlg = false
    var searchURL = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        alertLabel.isHidden = true
        ChangeTextFieldLayer(textField: titleTextField, imageView: titleImageView,tapFlg: false)
        ChangeTextFieldLayer(textField: authorTextField, imageView: authorImageView,tapFlg: false)
        ChangeTextFieldLayer(textField: publisherTextField, imageView: publisherImageView,tapFlg: false)
    }

    @IBAction func titleTap(_ sender: Any)
    {
        if(titleTapFlg)
        {
            ChangeTextFieldLayer(textField: titleTextField, imageView: titleImageView, tapFlg: true)
            titleTapFlg = false
        }
        else if(!titleTapFlg)
        {
            ChangeTextFieldLayer(textField: titleTextField, imageView: titleImageView, tapFlg: false)
            titleTapFlg = true
        }
    }
    
    @IBAction func authorTap(_ sender: Any)
    {
        if(authorTapFlg)
        {
            ChangeTextFieldLayer(textField: authorTextField, imageView: authorImageView, tapFlg: true)
            authorTapFlg = false
        }
        else if(!authorTapFlg)
        {
            ChangeTextFieldLayer(textField: authorTextField, imageView: authorImageView, tapFlg: false)
            authorTapFlg = true
        }
    }
    
    
    @IBAction func publisherTap(_ sender: Any)
    {
        if(publisherTapFlg)
        {
            ChangeTextFieldLayer(textField: publisherTextField, imageView: publisherImageView, tapFlg: true)
            publisherTapFlg = false
        }
        else if(!publisherTapFlg)
        {
            ChangeTextFieldLayer(textField: publisherTextField, imageView: publisherImageView, tapFlg: false)
            publisherTapFlg = true
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
            searchURL = "https://www.googleapis.com/books/v1/volumes?q=\(searchKeywordTextField.text!)"
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
        
        
        
    }
}
