//
//  ViewController.swift
//  Masonry
//
//  Created by Barry on 10/26/19.
//  Copyright © 2019 Barry. All rights reserved.
//

import UIKit

let managersSpecialsCell = "ManagersSpecialsCell"

public class ManagerSpecialsViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var specialsCollectionView: UICollectionView!
    
    public var canvasUnit: UInt = 1 { didSet { specialsCollectionView.collectionViewLayout.invalidateLayout() } }
    public var specials: [Special] = []  {
        willSet { modelDiffs = newValue.difference(from:specials) }
        didSet {  update(from: modelDiffs) }
    }
    public var modelDiffs = CollectionDifference<Special>([])!
    override public func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 6
        layout.minimumInteritemSpacing = 6
        layout.scrollDirection = .vertical
        specialsCollectionView.collectionViewLayout = layout
        specialsCollectionView.delegate = self
    }
    
    func update(from diffs: CollectionDifference<Special>) {
        for diff in diffs {
            print(diff)
        }
        specialsCollectionView.reloadData()
    }
}

extension ManagerSpecialsViewController: UICollectionViewDataSource {
    func configure(_ cell: ManagersSpecialsCell, with special: Special) {
        cell.itemNamelabel.text = special.displayName
        cell.originalPriceLabel.text = special.originalPrice
        cell.specialPriceLabel.text = special.price
    }
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        specials.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: managersSpecialsCell, for: indexPath) as? ManagersSpecialsCell else {
            assertionFailure("No cell registered for \(managersSpecialsCell)")
            return UICollectionViewCell()
        }
        configure(cell, with: specials[indexPath.item])
        return cell
    }
}

extension ManagerSpecialsViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let special = specials[indexPath.row]
        let deviceUnit = collectionView.bounds.size.width / CGFloat(16)
        return CGSize(width: CGFloat(special.width) * deviceUnit, height: CGFloat(special.height) * deviceUnit)
    }
}
