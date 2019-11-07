//
//  ManagersSpecialsModel.swift
//  ManagersSpecials
//
//  Created by Barry on 11/6/19.
//  Copyright © 2019 Barry. All rights reserved.
//

import Foundation

public struct ManagerSpecials: Decodable {
    public let canvasUnit: UInt
    public let managerSpecials: [Special]
}

public struct Special: Decodable, Equatable {
    let displayName: String
    let originalPrice: String
    let price: String
    let imageUrl: String
    let width: Int
    let height: Int
}
