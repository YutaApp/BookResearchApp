//
//  FavoriteBookCardViewController.swift
//  BookResearchApp
//
//  Created by 齋藤勇太 on 2021/06/09.
//

import UIKit
import VerticalCardSwiper
import RealmSwift

class FavoriteBookCardViewController: UIViewController,VerticalCardSwiperDelegate,VerticalCardSwiperDatasource {
   
    var favoriteBookDataArray = [FavoriteBookDBParams]()
    var deleteIndex = Int()
    
    //Amazon・楽天ブックスに飛ぶためのURL
    var amazonURL = String()
    var rakutenBooksURL = String()
    
    @IBOutlet weak var favoriteCardSwiper: VerticalCardSwiper!
    @IBOutlet weak var toast: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        toast.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        bookDataGetFromRealm()
        
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
            
            cardCell.amazonTap.addTarget(self, action: #selector(amazonToMove(_:)), for: .touchUpInside)
            cardCell.amazonTap.tag = index
            
            cardCell.rakutenTap.addTarget(self, action: #selector(rakutenBooksToMove(_:)), for: .touchUpInside)
            cardCell.rakutenTap.tag = index
            
            cardCell.isbn10Copy.addTarget(self, action: #selector(isbn10Copy(_:)), for: .touchUpInside)
            cardCell.isbn10Copy.tag = index
            
            cardCell.isbn13Copy.addTarget(self, action: #selector(isbn13Copy(_:)), for: .touchUpInside)
            cardCell.isbn13Copy.tag = index
            
            return cardCell
        }
        return CardCell()
    }
    
    @objc func rakutenBooksToMove(_ sender:UIButton)
    {
        rakutenBooksURL = "https://books.rakuten.co.jp/search?sitem=\(favoriteBookDataArray[sender.tag].strTitle)"
        print(rakutenBooksURL)
        
        let webVC = storyboard?.instantiateViewController(identifier: "webView") as! WebViewController
        
        webVC.rakutenBooksURL = rakutenBooksURL
        
        self.present(webVC, animated: true, completion: nil)
    }
    
    @objc func amazonToMove(_ sender:UIButton)
    {
        if(favoriteBookDataArray[sender.tag].strISBN10 == "表記なし")
        {
            amazonURL = "https://www.amazon.co.jp"
        }
        else
        {
            amazonURL = "https://www.amazon.co.jp/dp/\(favoriteBookDataArray[sender.tag].strISBN10)"
        }
        
        let webVC = storyboard?.instantiateViewController(identifier: "webView") as! WebViewController
        
        webVC.amazonURL = amazonURL
        
        self.present(webVC, animated: true, completion: nil)
    }
    
    @objc func isbn10Copy(_ sender:UIButton)
    {
        UIPasteboard.general.string = favoriteBookDataArray[sender.tag].strISBN10
        toastShow(msg: "ISBN10をコピーしました")
    }
    
    @objc func isbn13Copy(_ sender:UIButton)
    {
        UIPasteboard.general.string = favoriteBookDataArray[sender.tag].strISBN13
        toastShow(msg: "ISBN13をコピーしました")
    }
    
    func willSwipeCardAway(card: CardCell, index: Int, swipeDirection: SwipeDirection)
    {
        if swipeDirection == .Left || swipeDirection == .Right
        {
            deleteIndex = index
            bookDataDeleteFromRealm()
            favoriteBookDataArray.remove(at: index)
        }
    }
    
    func bookDataGetFromRealm()
    {
        favoriteBookDataArray.removeAll()
        
        let favoriteBookDB = try! Realm()
        let results = favoriteBookDB.objects(FavoriteBookDB.self)
        
        for index in 0..<results.count
        {
            let favoriteBookDBParams = FavoriteBookDBParams(strTitle: results[index].strTitle, strAuthor: results[index].strAuthor, strBookImageString: results[index].strBookImageString, strPublishedDate: results[index].strPublishedDate, iPageCount: results[index].iPageCount, strISBN10: results[index].strISBN10, strISBN13: results[index].strISBN13, strDescription: results[index].strDescription)
            
            favoriteBookDataArray.append(favoriteBookDBParams)
        }
    }
    
    func bookDataDeleteFromRealm()
    {
        let saveWriteToRealm = try! Realm()
        let deleteData = saveWriteToRealm.objects(FavoriteBookDB.self).filter("strTitle == '\(favoriteBookDataArray[deleteIndex].strTitle)'")
         
         try! saveWriteToRealm.write
         {
            saveWriteToRealm.delete(deleteData)
         }
        
    }
    
    func toastShow(msg:String)
    {
        toast.isHidden = false
        toast.alpha = 1.0
        toast.text = msg
        toast.layer.cornerRadius = 10
        //self.view.addSubview(toast)
        
        UIView.animate(withDuration: 2.5)
        {
            self.toast.alpha = 0.0
        }
    }

}
