//
//  CollectionViewCell.swift
//  Masonry
//
//  Created by Barry on 10/26/19.
//  Copyright © 2019 Barry. All rights reserved.
//

import UIKit

class ManagersSpecialsCell: UICollectionViewCell {
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var msrpLabel: UILabel!
    @IBOutlet weak var specialPriceLabel: UILabel!
    @IBOutlet weak var itemNamelabel: UILabel!
    
    static let cornerRadius = CGFloat(5)

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layer.cornerRadius = ManagersSpecialsCell.cornerRadius
        layer.shadowRadius = 20
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1;
        layer.shadowOffset = CGSize(width: 0,height: 2);
        
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 10).cgPath
    }
}
