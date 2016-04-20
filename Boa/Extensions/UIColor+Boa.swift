import UIKit


extension UIColor {

    static func startColorForTemparture(temparture: Temparture) -> UIColor {
        
        if temparture.degreesInFahrenheit >= 100 {
            return UIColor(red: 181/255, green: 33/255, blue: 2/255, alpha: 1)
        } else if temparture.degreesInFahrenheit >= 60 {
            return UIColor(red: 245/255, green: 149/255, blue: 33/255, alpha: 1)
        } else if temparture.degreesInFahrenheit >= 40 {
            return UIColor(red: 99/255, green: 209/255, blue: 116/255, alpha: 1)
        } else if temparture.degreesInFahrenheit >= 20 {
            return UIColor(red: 75/255, green: 181/255, blue: 230/255, alpha: 1)
        } else {
            return UIColor(red: 227/255, green: 243/255, blue: 251/255, alpha: 1)
        }
    }
    
    static func endColorForTemparture(temparture: Temparture) -> UIColor {
        
        if temparture.degreesInFahrenheit >= 100 {
            return UIColor(red: 245/255, green: 149/255, blue: 33/255, alpha: 1)
        } else if temparture.degreesInFahrenheit >= 60 {
            return UIColor(red: 254/255, green: 320/255, blue: 64/255, alpha: 1)
        } else if temparture.degreesInFahrenheit >= 40 {
            return UIColor(red: 75/255, green: 181/255, blue: 230/255, alpha: 1)
        } else if temparture.degreesInFahrenheit >= 20 {
            return UIColor(red: 227/255, green: 243/255, blue: 251/255, alpha: 1)
        } else {
            return UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        }
    }
}
