//
//  FavoriteBookCardViewController.swift
//  BookResearchApp
//
//  Created by 齋藤勇太 on 2021/06/09.
//

import UIKit
import VerticalCardSwiper

class FavoriteBookCardViewController: UIViewController,VerticalCardSwiperDelegate,VerticalCardSwiperDatasource {
   
    var favoriteBookDataArray = [GoogleBooksAPIParams]()
    
    @IBOutlet weak var favoriteCardSwiper: VerticalCardSwiper!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if UserDefaults.standard.object(forKey: "favoriteBookData") != nil
        {
            favoriteBookDataArray = UserDefaults.standard.object(forKey: "favoriteBookData") as! [GoogleBooksAPIParams]
        }
        
        favoriteCardSwiper.delegate = self
        favoriteCardSwiper.datasource = self
        favoriteCardSwiper.register(nib: UINib(nibName: "SearchBookCardCell", bundle: nil), forCellWithReuseIdentifier: "CardCell")
        favoriteCardSwiper.reloadData()
    }
    
    func numberOfCards(verticalCardSwiperView: VerticalCardSwiperView) -> Int
    {
        return favoriteBookDataArray.count
    }
    
    func cardForItemAt(verticalCardSwiperView: VerticalCardSwiperView, cardForItemAt index: Int) -> CardCell
    {
        if let cardCell = verticalCardSwiperView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: index) as? SearchBookCardCell
        {
            verticalCardSwiperView.backgroundColor = UIColor.clear
            view.backgroundColor = verticalCardSwiperView.backgroundColor
            cardCell.setRandomBackgroundColor()
            cardCell.titleLabel.text = favoriteBookDataArray[index].strTitle
            cardCell.authorLabel.text = favoriteBookDataArray[index].strAuthor
            cardCell.publishedDateLabel.text = favoriteBookDataArray[index].strPublishedDate
            
            if favoriteBookDataArray[index].iPageCount == 0
            {
                cardCell.pageCountLabel.text = "表記なし"
            }
            else
            {
                cardCell.pageCountLabel.text = String(favoriteBookDataArray[index].iPageCount)
            }
           
            cardCell.isbn10Label.text = "ISBN10: " + favoriteBookDataArray[index].strISBN10
            cardCell.isbn13Label.text = "ISBN13: " + favoriteBookDataArray[index].strISBN13
            cardCell.textView.text = favoriteBookDataArray[index].strDescription
            cardCell.bookImageView.sd_setImage(with: URL(string:favoriteBookDataArray[index].strBookImageString), placeholderImage: UIImage(named:"noimage"), options: .continueInBackground, context: nil)
            
            return cardCell
        }
        return CardCell()
    }
    


}
