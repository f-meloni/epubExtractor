//
//  ImageCell.swift
//  EpubExtractor_Example
//
//  Created by Franco Meloni on 07/06/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class ImageCell: UITableViewCell {
    var coverImageView: UIImageView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.coverImageView = UIImageView(frame: self.contentView.frame)
        self.coverImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.coverImageView.contentMode = .scaleAspectFit
        
        self.contentView.addSubview(self.coverImageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
