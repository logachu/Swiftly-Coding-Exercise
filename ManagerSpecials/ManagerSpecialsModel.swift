//
//  ManagerSpecialsModel.swift
//  ManagerSpecials
//
//  Created by Barry on 11/6/19.
//  Copyright © 2019 Barry. All rights reserved.
//

import Foundation
import Combine

/* ---> ManagerSpecials JSON object <-------
 {
  "canvasUnit": 16,
  "managerSpecials": [{
     "display_name": "Alessi Pesto 3.5oz",
     "height": 4,
     "imageUrl": "https://raw.githubusercontent.com/prestoqinc/code-exercise-ios/master/images/J.png",
     "original_price": "3.99",
     "price": "3.99",
     "width": 4
   }]
 }
 */
public struct ManagerSpecials: Decodable {
    public let canvasUnit: UInt
    public let managerSpecials: [Coupon]
}

public struct Coupon: Decodable, Equatable {
    enum CodingKeys: String, CodingKey {
        case displayName = "display_name"
        case originalPrice = "original_price"
        case price
        case imageUrl
        case width
        case height
    }
    let displayName: String
    let originalPrice: String
    let price: String
    let imageUrl: String
    let width: Int
    let height: Int
}

public class ManagerSpecialsModel: ObservableObject, Identifiable {
    @Published  public var managerSpecials: ManagerSpecials = ManagerSpecials(canvasUnit: 1, managerSpecials: [])
    private var api: SwiftlyAPI
    private var disposables = Set<AnyCancellable>()

    public init(api: SwiftlyAPI = SwiftlyNetwork()) {
        self.api = api
    }
    
    public func refreshManagerSpecials() {
        disposables = [] // cancels any pending requests
        api.fetchManagerSpecials()
            .retry(1)
            .decode(type: ManagerSpecials.self, decoder: JSONDecoder())
            .replaceError(with: ManagerSpecials(canvasUnit: 1, managerSpecials: []))
            .receive(on: DispatchQueue.main)
            .assign(to:\.managerSpecials, on: self)
            .store(in: &disposables)
    }
}

public enum ManagersSpecialModelError: Error {
    case couldNotLoad
}
