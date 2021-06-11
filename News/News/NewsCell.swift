//
//  NewsCell.swift
//  NewsReader
//
//  Created by mac on 2021/5/19.
//

import UIKit

class NewsCell: UITableViewCell {


    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    @IBOutlet weak var Header: UILabel!
    @IBOutlet weak var Date: UILabel!
    @IBOutlet weak var Img: UIImageView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
