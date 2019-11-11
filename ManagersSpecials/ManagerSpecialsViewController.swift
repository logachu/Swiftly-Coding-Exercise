//
//  ViewController.swift
//  Masonry
//
//  Created by Barry on 10/26/19.
//  Copyright © 2019 Barry. All rights reserved.
//

import UIKit
import Combine
import SDWebImage

let managersSpecialsCell = "ManagersSpecialsCell"

public class ManagerSpecialsViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var specialsCollectionView: UICollectionView!
    
    let spacing = CGFloat(8)

    public var model: ManagerSpecialsModel? = nil {
        didSet {
            model?.$managerSpecials.subscribe(managerSpecials).store(in: &disposables)
            model?.refreshManagerSpecials()
        }
    }
    public var managerSpecials = CurrentValueSubject<ManagerSpecials,Never>(ManagerSpecials(canvasUnit: 1, managerSpecials: []))
    private var disposables = Set<AnyCancellable>()
    var canvasUnit: UInt { managerSpecials.value.canvasUnit }
    var specials: [Special] { managerSpecials.value.managerSpecials }

    override public func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.scrollDirection = .vertical
        specialsCollectionView.collectionViewLayout = layout
        specialsCollectionView.delegate = self
        
        managerSpecials
            .sink { [unowned self] _ in self.update() }
            .store(in: &disposables)
    }
    
    func update() {
        specialsCollectionView.reloadData()
    }
}

extension ManagerSpecialsViewController: UICollectionViewDataSource {
    func configure(_ cell: ManagersSpecialsCell, with special: Special) {
        cell.itemNamelabel.text = special.displayName
        cell.originalPriceLabel.text = special.originalPrice
        cell.specialPriceLabel.text = special.price
        cell.photoView.sd_setImage(with: URL(string: special.imageUrl), placeholderImage: UIImage(named: "placeholder"))
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        managerSpecials.value.managerSpecials.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: managersSpecialsCell, for: indexPath) as? ManagersSpecialsCell else {
            assertionFailure("No cell registered for \(managersSpecialsCell)")
            return UICollectionViewCell()
        }
        configure(cell, with: managerSpecials.value.managerSpecials[indexPath.item])
        return cell
    }
}

extension ManagerSpecialsViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let special = managerSpecials.value.managerSpecials[indexPath.row]
        let deviceUnit = CGFloat(floor(collectionView.bounds.size.width - (5*spacing)) / 16.0)
        return CGSize(width: CGFloat(special.width) * deviceUnit, height: CGFloat(special.height) * deviceUnit)
    }
}
