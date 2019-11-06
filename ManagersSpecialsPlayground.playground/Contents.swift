//: A UIKit based Playground for presenting user interface
  
import UIKit
import ManagersSpecials
import PlaygroundSupport

// Development flow more efficient when you put the view controller
// in a framework so it can be shared between a playground and an
// app project because its a lot quicker to iterate in a storyboard.
//
// Tip: Set the playground to "Manually Run" then define a keyboard
//      shortcut to run it. Setting it to "Automatically Run" seems
//      to eventually hang the playground.
let bundle = Bundle(for: ManagersSpecialsViewController.self)
let storyboard = UIStoryboard(name: "Main", bundle: bundle)
let vc = storyboard.instantiateInitialViewController() as! ManagersSpecialsViewController
PlaygroundPage.current.liveView = vc

