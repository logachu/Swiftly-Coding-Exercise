/*:
 I built this visualization to see the sample data as a single column of rectangles.
 I wanted to see if they were designed to layout well in a
 flow layout or would require a custom layout. It turns out they are! For example
 there are no tall narrow rectangles that would result in blank space below all
 of the elements in the same row that weren't as tall. Handling that would require
 a custom layout that doesn't just build rows then stack them like a flow layout.
 */
import Foundation

struct ManagerSpecialsData: Decodable {
    let canvasUnit: Int
    let managerSpecials: [ManagerSpecials]
}

// only need the width and height properties
struct ManagerSpecials: Decodable {
    let width: Int
    let height: Int
}

// I downloaded the sample data from https://prestoq.com/ios-coding-challenge and put in and a sample.json file
let url = Bundle.main.url(forResource: "sampledata", withExtension: "json")!
let data = try Data(contentsOf: url)
let decoded = try JSONDecoder().decode(ManagerSpecialsData.self, from: data)

let items = decoded.managerSpecials.map { LayoutItem(width: $0.width, height: $0.height) }

items.map { print(String(format:"(%2.f, %2.f)", $0.width, $0.height)) }

import UIKit
let view = ManagerSpecialsView(frame: CGRect(x: 0, y: 0, width: 100, height: 600))
view.backgroundColor = .white
view.items = items

import PlaygroundSupport
PlaygroundPage.current.liveView = view
