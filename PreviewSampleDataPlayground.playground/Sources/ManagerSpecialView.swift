import Foundation
import UIKit

// We only really need the width and height of the items so we'll
// represent them with something that already *has* a width and height.
public typealias LayoutItem = CGSize

extension LayoutItem {
    /// A funtion to scale each item from canvasUnits to deviceUnits
    func scaled(by factor: CGFloat) -> LayoutItem {
        return LayoutItem(width: self.width * factor, height: self.height * factor)
    }
}

public class ManagerSpecialsView: UIView {
    public var items: [LayoutItem] = [] { didSet { setNeedsDisplay() }}
    
    private func layout(for viewHeight: CGFloat) -> [CGRect] {
        let spacing = CGFloat(2)
        let totalItemHeights = items.map { $0.height }
                                    .reduce(CGFloat(spacing)) { result, height in result + height + spacing }
        let scaleFactor = viewHeight / totalItemHeights
        let scaledSpacing = spacing * scaleFactor
        var bottom = scaledSpacing
        var itemRects: [CGRect] = []
        for item in items {
            let scaledItem = item.scaled(by: scaleFactor)
            itemRects.append(CGRect(x: scaledSpacing, y: bottom, width: scaledItem.width, height: scaledItem.height))
            bottom += scaledSpacing + scaledItem.height
        }
        return itemRects
    }
    
    override public func draw(_ rect: CGRect) {
        let itemRects = layout(for: rect.size.height)
        guard let context = UIGraphicsGetCurrentContext() else { fatalError() }
        context.beginPath()
        context.setFillColor(UIColor.orange.cgColor)
        for itemRect in itemRects {
            context.addRect(itemRect)
        }
        context.fillPath(using: .evenOdd)
    }
}
