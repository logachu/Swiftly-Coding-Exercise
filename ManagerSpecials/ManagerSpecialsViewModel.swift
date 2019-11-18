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
    public let coupons: [CouponViewModel]

    static let initialValue = ManagersSpecialsViewModel(ManagerSpecials(canvasUnit: 1, managerSpecials: []))
    
    init(_ model: ManagerSpecials) {
        canvasUnit = model.canvasUnit
        coupons = model.managerSpecials.map { CouponViewModel(canvasUnit: model.canvasUnit, $0) }
    }
}

// A Coupon's shape will ultimately determine which cell type is used to render it.
// CouponViewModel.shape(use:for:) is the rule which maps a size to a shape.
enum CouponShape {
       case squarish // width and height are less than a multiple of one-another
       case wide      // much wider than it is high
       case small     // too small to include a photo
       case unknown // other shapes such as tall and skinny are not currently handled
}

public struct CouponViewModel {
    let displayName: String
    let originalPrice: NSAttributedString
    let price: String
    let imageUrl: String
    let size: CGSize
    var shape: CouponShape
    
    private static let strikeOutAttributes: [NSAttributedString.Key: Any] = [
        .strikethroughStyle: NSUnderlineStyle.single.rawValue,
        .strikethroughColor: UIColor.black
    ]
    
    init(canvasUnit: UInt, _ model: Coupon) {
        displayName = model.displayName
        originalPrice = NSAttributedString(string: model.originalPrice, attributes: CouponViewModel.strikeOutAttributes)
        price = model.price
        imageUrl = model.imageUrl
        let modelSize = CGSize(width: model.width, height: model.height)
        size = modelSize
        shape = CouponViewModel.shape(using: canvasUnit, for: modelSize)
        print(displayName, shape, CGFloat(model.width) / CGFloat(canvasUnit),  CGFloat(model.width) / CGFloat(model.height))
    }
    
   static func shape(using canvasUnit: UInt, for size: CGSize) -> CouponShape {
        let width = size.width
        let height = size.height
        let aspectRatio = width / height

        if aspectRatio > 2 { return .wide}

        let small = (CGFloat(canvasUnit) / CGFloat(4))
        if width <= small { return .small }

        if aspectRatio > 0.5 && aspectRatio <= 2 { return .squarish }

        return .unknown
    }
}
