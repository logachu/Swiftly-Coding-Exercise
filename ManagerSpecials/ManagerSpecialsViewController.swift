//
//  ViewController.swift
//  Masonry
//
//  Created by Barry on 10/26/19.
//  Copyright © 2019 Barry. All rights reserved.
//

import UIKit
import CoreGraphics
import Combine
import SDWebImage

public class ManagerSpecialsViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var specialsCollectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let spacing = CGFloat(8)

    public var model: ManagerSpecialsModel? = nil {
        didSet {
            model?.$managerSpecials
                .map(ManagersSpecialsViewModel.init(_:))
                .subscribe(managerSpecials).store(in: &disposables)
            model?.refreshManagerSpecials()
        }
    }
    public var managerSpecials = CurrentValueSubject<ManagersSpecialsViewModel,Never>(ManagersSpecialsViewModel.initialValue)
    private var disposables = Set<AnyCancellable>()
    var canvasUnit: UInt { managerSpecials.value.canvasUnit }
    var specials: [CouponViewModel] { managerSpecials.value.coupons }

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
        
        activityIndicator.startAnimating()
    }
    
    func update() {
        activityIndicator.stopAnimating()
        specialsCollectionView.reloadData()
    }
}

extension ManagerSpecialsViewController: UICollectionViewDataSource {
    func configure(_ cell: CouponCell, with special: CouponViewModel) {
        if cell.photoView != nil {
            cell.photoView.sd_setImage(with: URL(string: special.imageUrl), placeholderImage: UIImage(named: "placeholder"))
        }
        cell.itemNamelabel.text = special.displayName
        cell.originalPriceLabel.attributedText = special.originalPrice
        cell.specialPriceLabel.text = special.price
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        managerSpecials.value.coupons.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let coupon = managerSpecials.value.coupons[indexPath.item]
        let reuseIdentifier = CouponCell.reuseIdentifier(for: coupon.shape)
        print(reuseIdentifier)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? CouponCell else {
            assertionFailure("No cell registered for \(reuseIdentifier)")
            return UICollectionViewCell()
        }
        configure(cell, with: managerSpecials.value.coupons[indexPath.item])
        return cell
    }
}

extension ManagerSpecialsViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let coupon = managerSpecials.value.coupons[indexPath.row]
        let deviceUnit = CGFloat(floor(collectionView.bounds.size.width - (5*spacing)) / 16.0)
        return coupon.size.applying(CGAffineTransform.identity.scaledBy(x: deviceUnit, y: deviceUnit))
    }
}
