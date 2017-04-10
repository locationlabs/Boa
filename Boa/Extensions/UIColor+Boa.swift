import UIKit


extension UIColor {

    static func startColorForTemperature(_ temperature: Temperature) -> UIColor {
        
        if temperature.degreesInFahrenheit >= 100 {
            return UIColor(red: 181/255, green: 33/255, blue: 2/255, alpha: 1)
        } else if temperature.degreesInFahrenheit >= 60 {
            return UIColor(red: 245/255, green: 149/255, blue: 33/255, alpha: 1)
        } else if temperature.degreesInFahrenheit >= 40 {
            return UIColor(red: 99/255, green: 209/255, blue: 116/255, alpha: 1)
        } else if temperature.degreesInFahrenheit >= 20 {
            return UIColor(red: 75/255, green: 181/255, blue: 230/255, alpha: 1)
        } else {
            return UIColor(red: 227/255, green: 243/255, blue: 251/255, alpha: 1)
        }
    }
    
    static func endColorForTemperature(_ temperature: Temperature) -> UIColor {
        
        if temperature.degreesInFahrenheit >= 100 {
            return UIColor(red: 245/255, green: 149/255, blue: 33/255, alpha: 1)
        } else if temperature.degreesInFahrenheit >= 60 {
            return UIColor(red: 254/255, green: 320/255, blue: 64/255, alpha: 1)
        } else if temperature.degreesInFahrenheit >= 40 {
            return UIColor(red: 75/255, green: 181/255, blue: 230/255, alpha: 1)
        } else if temperature.degreesInFahrenheit >= 20 {
            return UIColor(red: 227/255, green: 243/255, blue: 251/255, alpha: 1)
        } else {
            return UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        }
    }
    
}

public extension UIColor {
    
    /**
     Will crete an UIColor from an #HEX string. Shamelessly taken from:
     https://github.com/yeahdongcn/UIColor-Hex-Swift with a few tweaks
     
     var solid = UIColor(rgb: "#ffcc00")
     var alpha = UIColor(rgb: "#ffcc00", a: 0.5)
     
     - parameter rgba: hex color string
     */
    public convenience init(rgb: String, a: Float? = 1.0) {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        
        if rgb.hasPrefix("#") {
            let index = rgb.characters.index(rgb.startIndex, offsetBy: 1)
            let hex = rgb.substring(from: index)
            let scanner = Scanner(string: hex)
            var hexValue: CUnsignedLongLong = 0
            if scanner.scanHexInt64(&hexValue) {
                if hex.characters.count == 6 {
                    red = CGFloat((hexValue & 0xFF0000) >> 16)
                    green = CGFloat((hexValue & 0x00FF00) >> 8)
                    blue = CGFloat(hexValue & 0x0000FF)
                } else {
                    throwException("Invalid rgb string, length should be 7")
                }
            } else {
                throwException("Scan hex error")
            }
        } else {
            throwException("Invalid RGB string, missing # as prefix")
        }
        self.init(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: CGFloat(a!))
    }
    
    /**
     Convenience method for creating a copy of an existing color and applying an alpha to it. The
     original instance is NOT altered.
     
     - parameter alpha: the alpha to apply 0 - 1
     
     - returns: a new color with the given alpha
     */
    public func withAlpha(_ alpha: Float) -> UIColor {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        getRed(&red, green: &green, blue: &blue, alpha: nil)
        return UIColor(red: red, green: green, blue: blue, alpha: CGFloat(alpha))
    }
    
}

/**
 Syntax sugar wround throwing an exception for an invalid color. Local to this file only
 
 - parameter description: the error description to throw
 */
private func throwException(_ description: String) {
    NSException.raise(NSExceptionName(rawValue: "InvalidColor"), format: description, arguments: getVaList([]))
}
