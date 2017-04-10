import UIKit


public extension UIImage {
    
    public func withTint(_ color: UIColor) -> UIImage {
        
        if UIScreen.instancesRespond(to: #selector(NSDecimalNumberBehaviors.scale)) {
            UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        } else {
            UIGraphicsBeginImageContext(self.size)
        }
        
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        
        color.set()
        UIRectFill(rect)
        
        draw(in: rect, blendMode: CGBlendMode.destinationIn, alpha: 1.0)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
}
