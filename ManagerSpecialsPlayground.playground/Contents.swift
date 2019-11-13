//: A UIKit based Playground for presenting user interface
  
import UIKit
import Combine
import ManagerSpecials
import PlaygroundSupport

// To speed up iterating on a view controller its packaged
// into  a framework so it can be shared between a playground and an
// app project because its a lot quicker to iterate in a playground.
//
// Tip: Set the playground to "Manually Run". Setting it to "Automatically Run"
//      seems to eventually hang the playground.
let bundle = Bundle(for: ManagerSpecialsViewController.self)
let storyboard = UIStoryboard(name: "Main", bundle: bundle)
let vc = storyboard.instantiateInitialViewController() as! ManagerSpecialsViewController
vc.preferredContentSize = CGSize(width: 414, height: 896) // iPHone 11 Xr
PlaygroundPage.current.liveView = vc

vc.model = ManagerSpecialsModel()
//vc.model = ManagerSpecialsModel(api: SwiftlyAPIMock())

func testAPIMock() {
    let api = SwiftlyAPIMock()
    _ = api.fetchManagerSpecials()
        .decode(type: ManagerSpecials.self, decoder: JSONDecoder())
        .sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
                print("Failure: \(error.localizedDescription)")
                assertionFailure()
            case .finished: break
            }
         },
         receiveValue: { value in
            print(value)
         }
    )
}
//testAPIMock()
