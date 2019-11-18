//
//  ManagerSpecialsViewModel.swift
//  ManagerSpecials
//
//  Created by Barry on 11/14/19.
//  Copyright © 2019 Barry. All rights reserved.
//
// In this case these view models are effectively passthrough except for the strike out text
// For the originalPrice field. In a more realistic scenario there would be more work going on
// here like localization so it wouldn't be so much pure boilerplate.

import UIKit

public struct ManagersSpecialsViewModel {
    public let canvasUnit: UInt
    public let managerSpecials: [CouponViewModel]

    static let initialValue = ManagersSpecialsViewModel(ManagerSpecials(canvasUnit: 1, managerSpecials: []))
    
    init(_ model: ManagerSpecials) {
        canvasUnit = model.canvasUnit
        managerSpecials = model.managerSpecials.map(CouponViewModel.init)
    }
}

public struct CouponViewModel {
    let displayName: String
    let originalPrice: NSAttributedString
    let price: String
    let imageUrl: String
    let size: CGSize
    
    private static let strikeOutAttributes: [NSAttributedString.Key: Any] = [
        .strikethroughStyle: NSUnderlineStyle.single.rawValue,
        .strikethroughColor: UIColor.black
    ]
    
    init(_ model: Coupon) {
        displayName = model.displayName
        originalPrice = NSAttributedString(string: model.originalPrice, attributes: CouponViewModel.strikeOutAttributes)
        price = model.price
        imageUrl = model.imageUrl
        size = CGSize(width: model.width, height: model.height)
    }
}
