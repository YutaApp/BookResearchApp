//
//  BookSearchDataViewController.swift
//  BookResearchApp
//
//  Created by 齋藤勇太 on 2021/06/03.
//

import UIKit
import VerticalCardSwiper
import SDWebImage
import RealmSwift

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
    var favoriteBookDataArray = [GoogleBooksAPIParams]()
    
    //お気に入りに登録するインデックス
    var saveIndex = Int()
    
    //Amazon・楽天ブックスに飛ぶためのURL
    var amazonURL = String()
    var rakutenBooksURL = String()
    
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
            verticalCardSwiperView.backgroundColor = UIColor.clear
            view.backgroundColor = verticalCardSwiperView.backgroundColor
            cardCell.setRandomBackgroundColor()
            cardCell.titleLabel.text = googleBooksDataArray[index].strTitle
            cardCell.authorLabel.text = googleBooksDataArray[index].strAuthor
            cardCell.publishedDateLabel.text = googleBooksDataArray[index].strPublishedDate
            
            if googleBooksDataArray[index].iPageCount == 0
            {
                cardCell.pageCountLabel.text = "表記なし"
            }
            else
            {
                cardCell.pageCountLabel.text = String(googleBooksDataArray[index].iPageCount)
            }
           
            cardCell.isbn10Label.text = "ISBN10: " + googleBooksDataArray[index].strISBN10
            cardCell.isbn13Label.text = "ISBN13: " + googleBooksDataArray[index].strISBN13
            cardCell.textView.text = googleBooksDataArray[index].strDescription
            cardCell.bookImageView.sd_setImage(with: URL(string:googleBooksDataArray[index].strBookImageString), placeholderImage: UIImage(named:"noimage"), options: .continueInBackground, context: nil)
            
            cardCell.amazonTap.addTarget(self, action: #selector(amazonToMove(_:)), for: .touchUpInside)
            cardCell.amazonTap.tag = index
            
            cardCell.rakutenTap.addTarget(self, action: #selector(rakutenBooksToMove(_:)), for: .touchUpInside)
            cardCell.rakutenTap.tag = index
            
            return cardCell
        }
        return CardCell()
    }
    
    @objc func rakutenBooksToMove(_ sender:UIButton)
    {
        rakutenBooksURL = "https://books.rakuten.co.jp/search?sitem=\(googleBooksDataArray[sender.tag].strTitle)"
        print(rakutenBooksURL)
        
        let webVC = storyboard?.instantiateViewController(identifier: "webView") as! WebViewController
        
        webVC.rakutenBooksURL = rakutenBooksURL
        
        self.present(webVC, animated: true, completion: nil)
    }
    
    @objc func amazonToMove(_ sender:UIButton)
    {
        if(googleBooksDataArray[sender.tag].strISBN10 == "表記なし")
        {
            amazonURL = "https://www.amazon.co.jp"
        }
        else
        {
            amazonURL = "https://www.amazon.co.jp/dp/\(googleBooksDataArray[sender.tag].strISBN10)"
        }
        
        let webVC = storyboard?.instantiateViewController(identifier: "webView") as! WebViewController
        
        webVC.amazonURL = amazonURL
        
        self.present(webVC, animated: true, completion: nil)
    }
    
    func willSwipeCardAway(card: CardCell, index: Int, swipeDirection: SwipeDirection)
    {
        if swipeDirection == .Left
        {
            googleBooksDataArray.remove(at: index)
        }
        else if swipeDirection == .Right
        {
            saveIndex = index
            favoriteBookDataArray.append(googleBooksDataArray[saveIndex])
            googleBooksDataArray.remove(at: saveIndex)
            saveData(array: favoriteBookDataArray)
        }
    }
    
    @IBAction func back(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    func saveData(array:[GoogleBooksAPIParams])
    {
       let endIndex = favoriteBookDataArray.count - 1
       let saveData = FavoriteBookDB(value: [
        "strTitle":array[endIndex].strTitle,
        "strAuthor":array[endIndex].strAuthor,
        "strBookImageString":array[endIndex].strBookImageString,
        "strPublishedDate":array[endIndex].strPublishedDate,
        "iPageCount":array[endIndex].iPageCount,
        "strISBN10":array[endIndex].strISBN10,
        "strISBN13":array[endIndex].strISBN13,
        "strDescription":array[endIndex].strDescription
       ])
        
       let saveWriteToRealm = try! Realm()
        
        try! saveWriteToRealm.write
        {
            saveWriteToRealm.add(saveData)
        }
    }
    
}
