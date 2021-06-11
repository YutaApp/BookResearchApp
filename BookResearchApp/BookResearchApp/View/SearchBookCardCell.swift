//
//  SearchBookCardCell.swift
//  BookResearchApp
//
//  Created by 齋藤勇太 on 2021/05/22.
//

import UIKit
import VerticalCardSwiper

class SearchBookCardCell: CardCell {

    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var publishedDateLabel: UILabel!
    @IBOutlet weak var pageCountLabel: UILabel!
    @IBOutlet weak var isbn10Label: UILabel!
    @IBOutlet weak var isbn13Label: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var amazonTap: UIButton!
    @IBOutlet weak var rakutenTap: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    public func setRandomBackgroundColor() {
        
        let randomRed: CGFloat = CGFloat.random(in: 0...255) / 255
        let randomGreen: CGFloat = CGFloat.random(in: 0...255) / 255
        let randomBlue: CGFloat = CGFloat.random(in: 0...255) / 255
        self.backgroundColor = UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 0.8)
    }
    
    
}
