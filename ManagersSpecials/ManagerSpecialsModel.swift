//
//  ManagersSpecialsModel.swift
//  ManagersSpecials
//
//  Created by Barry on 11/6/19.
//  Copyright © 2019 Barry. All rights reserved.
//
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

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
    public let managerSpecials: [Special]
}

public struct Special: Decodable, Equatable {
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
