import UIKit

protocol BaseStyleType {
    func generalBackgroundColor() -> UIColor
}

// MARK: - CategoryPickerStyleType
extension BaseStyleType {
    func generalBackgroundColor() -> UIColor {
        return .yellowColor()
    }
}
