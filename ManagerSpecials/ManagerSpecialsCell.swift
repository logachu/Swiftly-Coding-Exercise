//
//  CollectionViewCell.swift
//  Masonry
//
//  Created by Barry on 10/26/19.
//  Copyright © 2019 Barry. All rights reserved.
//

import UIKit

class ManagerSpecialsCell: UICollectionViewCell {
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var originalPriceLabel: UILabel!
    @IBOutlet weak var specialPriceLabel: UILabel!
    @IBOutlet weak var itemNamelabel: UILabel!
    
    static let cornerRadius = CGFloat(5)

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layer.cornerRadius = ManagerSpecialsCell.cornerRadius
        layer.shadowRadius = 15
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0,height: 10)
        layer.borderColor = UIColor(white: 0.85, alpha: 1).cgColor
        layer.borderWidth = 1
        
        
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 10).cgPath
    }
}
