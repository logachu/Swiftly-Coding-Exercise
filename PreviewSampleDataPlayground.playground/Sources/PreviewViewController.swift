import Foundation
import UIKit

// We only really need the width and height of the items so we'll
// represent them with something that already *has* a width and height.
public typealias LayoutItem = CGSize

extension LayoutItem {
    /// A funtion to scale each item from canvasUnits to deviceUnits
    func scaled(to factor: CGFloat) -> LayoutItem {
        return LayoutItem(width: self.width * factor, height: self.height * factor)
    }
}

// With 20:20 hindsight, this view controller should have just been NSView or UIView but I started from the
// single view playground template and didn't questions it 🤷🏻‍♂️

/// A view controller to show the shapes of all of the items in a vertical column.
public class PreviewViewController : UIViewController {
    public var items: [LayoutItem] = [] { didSet { updateLayout() }}
  
    func clearLayout() {
        for subview in view.subviews {
            subview.removeFromSuperview()
        }
    }
    
    func updateLayout() {
        clearLayout()
        view.backgroundColor = .white
        let spacingInCanvasUnits = CGFloat(1)
        let totalHeightInCanvasUnits = items
            .map { $0.height }
            .reduce(CGFloat(spacingInCanvasUnits)) { result, itemHeight in
                return result + itemHeight + spacingInCanvasUnits
            }
        let deviceUnit = self.view.bounds.size.height / totalHeightInCanvasUnits
        let spacing = spacingInCanvasUnits * deviceUnit
        var origin = CGPoint(x:spacing, y: spacing)
        
        for item in items {
            let itemView = UIView()
            itemView.backgroundColor = .orange
            let scaledSize = item.scaled(to: deviceUnit)
            itemView.frame = CGRect(origin: origin, size: scaledSize)
    
            origin = CGPoint(x: origin.x, y: origin.y + scaledSize.height + spacing)
            view.addSubview(itemView)
        }
    }
}
