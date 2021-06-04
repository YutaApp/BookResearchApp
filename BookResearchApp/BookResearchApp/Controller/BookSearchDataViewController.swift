//
//  BookSearchDataViewController.swift
//  BookResearchApp
//
//  Created by 齋藤勇太 on 2021/06/03.
//

import UIKit
import VerticalCardSwiper
import SDWebImage

class BookSearchDataViewController: UIViewController, VerticalCardSwiperDelegate, VerticalCardSwiperDatasource {
  
    //データを受け取る用の変数
    var strTitle = String()
    var strAuthor = String()
    var strBookImageString = String()
    var strPublishedDate = String()
    var iPageCount = Int()
    var strISBN10 = String()
    var strISBN13 = String()
    var strDescription = String()
    var googleBooksDataArray = [GoogleBooksAPIParams]()
    
    @IBOutlet weak var cardSwiper: VerticalCardSwiper!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        cardSwiper.delegate = self
        cardSwiper.datasource = self
        cardSwiper.register(nib: UINib(nibName: "SearchBookCardCell", bundle: nil), forCellWithReuseIdentifier: "CardCell")
        cardSwiper.reloadData()
    }
    
    func numberOfCards(verticalCardSwiperView: VerticalCardSwiperView) -> Int
    {
        return googleBooksDataArray.count
    }
    
    func cardForItemAt(verticalCardSwiperView: VerticalCardSwiperView, cardForItemAt index: Int) -> CardCell
    {
        if let cardCell = verticalCardSwiperView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: index) as? SearchBookCardCell
        {
            verticalCardSwiperView.backgroundColor = UIColor.orange
            view.backgroundColor = verticalCardSwiperView.backgroundColor
            cardCell.setRandomBackgroundColor()
            cardCell.titleLabel.text = googleBooksDataArray[index].strTitle
            cardCell.authorLabel.text = googleBooksDataArray[index].strAuthor
            cardCell.publishedDateLabel.text = googleBooksDataArray[index].strPublishedDate
            cardCell.pageCountLabel.text = String(googleBooksDataArray[index].iPageCount)
            cardCell.isbn10Label.text = googleBooksDataArray[index].strISBN10
            cardCell.isbn13Label.text = googleBooksDataArray[index].strISBN13
            cardCell.textView.text = googleBooksDataArray[index].strDescription
            cardCell.bookImageView.sd_setImage(with: URL(string:googleBooksDataArray[index].strBookImageString), completed: nil)
            
            return cardCell
        }
        return CardCell()
    }
    

}
