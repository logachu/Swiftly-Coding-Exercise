//
//  ViewController.swift
//  Masonry
//
//  Created by Barry on 10/26/19.
//  Copyright © 2019 Barry. All rights reserved.
//

import UIKit

let managersSpecialsCell = "ManagersSpecialsCell"

public class ManagersSpecialsViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var specialsCollectionView: UICollectionView!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ManagersSpecialsViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        6
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: managersSpecialsCell, for: indexPath) as? ManagersSpecialsCell else {
            assertionFailure("No cell registered for \(managersSpecialsCell)")
            return UICollectionViewCell()
        }
        cell.msrpLabel.text = "DUDE!"
//        cell.contentView.layer.cornerRadius = 2.0
//           cell.contentView.layer.borderWidth = 1.0
//           cell.contentView.layer.borderColor = UIColor.clear.cgColor
//           cell.contentView.layer.masksToBounds = true;
//           cell.layer.shadowColor = UIColor.lightGray.cgColor
//           cell.layer.shadowOffset = CGSize(width:0,height: 2.0)
//           cell.layer.shadowRadius = 2.0
//           cell.layer.shadowOpacity = 1.0
//           cell.layer.masksToBounds = false;
//           cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
        return cell
    }
    
    
}
