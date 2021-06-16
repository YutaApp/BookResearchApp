//
//  TableViewCell.swift
//  BookResearchApp
//
//  Created by 齋藤勇太 on 2021/06/14.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var libNameLabel: UILabel!
    @IBOutlet weak var confirmLabel: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

    }
    
    public func setRandomBackgroundColor()
    {
        let randomRed: CGFloat = CGFloat.random(in: 0...255) / 255
        let randomGreen: CGFloat = CGFloat.random(in: 0...255) / 255
        let randomBlue: CGFloat = CGFloat.random(in: 0...255) / 255
        self.backgroundColor = UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 0.8)
    }
    
}
