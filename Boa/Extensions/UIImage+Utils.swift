import UIKit


public extension UIImage {
    
    public func withTint(color: UIColor) -> UIImage {
        
        if UIScreen.instancesRespondToSelector(#selector(NSDecimalNumberBehaviors.scale)) {
            UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        } else {
            UIGraphicsBeginImageContext(self.size)
        }
        
        let rect = CGRectMake(0, 0, self.size.width, self.size.height)
        
        color.set()
        UIRectFill(rect)
        
        drawInRect(rect, blendMode: CGBlendMode.DestinationIn, alpha: 1.0)
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return image;
    }
}