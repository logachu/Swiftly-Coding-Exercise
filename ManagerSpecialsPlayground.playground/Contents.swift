//: A UIKit based Playground for presenting user interface
  
import UIKit
import ManagerSpecials
import PlaygroundSupport

// To speed up iterating on a view controller its packaged
// into  a framework so it can be shared between a playground and an
// app project because its a lot quicker to iterate in a playground.
//
// Tip: Set the playground to "Manually Run" then define a keyboard
//      shortcut to run it. Setting it to "Automatically Run" seems
//      to eventually hang the playground.
let bundle = Bundle(for: ManagerSpecialsViewController.self)
let storyboard = UIStoryboard(name: "Main", bundle: bundle)
let vc = storyboard.instantiateInitialViewController() as! ManagerSpecialsViewController
PlaygroundPage.current.liveView = vc

let model: ManagerSpecials = try! {
    let url = Bundle.main.url(forResource: "sampledata", withExtension: "json")!
    let data = try Data(contentsOf: url)
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    let specials = try decoder.decode(ManagerSpecials.self, from: data)
    return specials
}()
vc.canvasUnit = model.canvasUnit
vc.specials = model.managerSpecials

