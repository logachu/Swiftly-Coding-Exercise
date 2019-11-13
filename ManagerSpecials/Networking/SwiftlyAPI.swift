//
//  SwiftlyAPI.swift
//  ManagerSpecials
//
//  Copyright © 2019 Barry Tolnas. All rights reserved.
//

import Foundation
import Combine

public protocol SwiftlyAPI {
    func fetchManagerSpecials() -> AnyPublisher<Data, URLError>
}

public enum SwiftlyAPIError: Error {
    case urlParsing
    case responseParsing(description: String)
    case network(description: String)
}

public struct SwiftlyNetwork: SwiftlyAPI {
    enum Endpoints {
        static let managerSpecials = "https://prestoq.com/ios-coding-challenge"
    }
    
    public init() { }
    
    public func fetchManagerSpecials() -> AnyPublisher<Data, URLError> {
        return URLSession.shared.dataTaskPublisher(for: URL(string: Endpoints.managerSpecials)!)
            .map(\.data)
            .eraseToAnyPublisher()
    }
}

#if DEBUG
public struct SwiftlyAPIMock: SwiftlyAPI {
    public init() { }
    public func fetchManagerSpecials() -> AnyPublisher<Data, URLError> {
        let url = Bundle.main.url(forResource: "sampledata", withExtension: "json")!
        let data = try! Data(contentsOf: url) // not worried about force unwrapping in mocks
        return Just(data)
            .delay(for: .init(1), scheduler: RunLoop.main)
            .mapError { _ in URLError(.badServerResponse) } // need this to convert Never to URLError
            .eraseToAnyPublisher()
    }
}
#endif
