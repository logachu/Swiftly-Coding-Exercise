//: To speed up iterating on the view controller its packaged into a
//: framework so it can be shared between a playground and an app
//: project because its a lot quicker to iterate in a playground.
//:
//: Note: Updates to the framework must be re-built before the
//: framework is re-run so select the ManagerSpecials scheme and hit
//: ⌘R to build followed by ⇧⌘↩︎ to re-run the playground. It seems
//: that sometimes the playground needs to be explicitly stopped
//: before re-running. And sometimes the live view just stops
//: appearing until you restart Xcode. “¯\_(ツ)_/¯“
//:
//: Tip: Set the playground to "Manually Run". Setting it to
//: "Automatically Run" seems to eventually hang the playground.

import UIKit
import Combine
import ManagerSpecials
import PlaygroundSupport


let bundle = Bundle(for: ManagerSpecialsViewController.self)
let storyboard = UIStoryboard(name: "Main", bundle: bundle)
let vc = storyboard.instantiateInitialViewController() as! ManagerSpecialsViewController
vc.preferredContentSize = CGSize(width: 414, height: 896) // iPhone 11 Xr
PlaygroundPage.current.liveView = vc

//vc.model = ManagerSpecialsModel()
vc.model = ManagerSpecialsModel(api: SwiftlyAPIMock())

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
