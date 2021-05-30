//
//  SearchViewController.swift
//  BookResearchApp
//
//  Created by 齋藤勇太 on 2021/05/30.
//

import UIKit

class SearchViewController: UIViewController {

    
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var authorImageView: UIImageView!
    @IBOutlet weak var publisherImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    @IBAction func titleTap(_ sender: Any) {
        print(titleImageView.tag)
        print(authorImageView.tag)
        print(publisherImageView.tag)
    }
}
