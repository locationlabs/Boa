import Foundation
import UIKit


enum Temparture {
    case Fahrenheit(degrees: Double)
    case Celsius(degrees: Double)
    
    var degreesInFahrenheit: Double {
        switch self {
        case .Fahrenheit(let degrees):
            return degrees
        case .Celsius(let degrees):
            return degrees * 1.8 + 32.0
        }
    }
    
    var degreesInCelsius: Double {
        switch self {
        case .Fahrenheit(let degrees):
            return (degrees - 32.0) / 1.8
        case .Celsius(let degrees):
            return degrees
        }
    }
}

// MARK: - Colors
extension Temparture {
    var startColor: UIColor {
        
        if degreesInFahrenheit >= 100 {
            return UIColor(red: 181/255, green: 33/255, blue: 2/255, alpha: 1)
        } else if degreesInFahrenheit >= 60 {
            return UIColor(red: 245/255, green: 149/255, blue: 33/255, alpha: 1)
        } else if degreesInFahrenheit >= 40 {
            return UIColor(red: 99/255, green: 209/255, blue: 116/255, alpha: 1)
        } else if degreesInFahrenheit >= 20 {
            return UIColor(red: 75/255, green: 181/255, blue: 230/255, alpha: 1)
        } else {
            return UIColor(red: 210/255, green: 226/255, blue: 237/255, alpha: 1)
        }
    }
    
    var endColor: UIColor {
        
        if degreesInFahrenheit >= 100 {
            return UIColor(red: 245/255, green: 149/255, blue: 33/255, alpha: 1)
        } else if degreesInFahrenheit >= 60 {
            return UIColor(red: 254/255, green: 320/255, blue: 64/255, alpha: 1)
        } else if degreesInFahrenheit >= 40 {
            return UIColor(red: 75/255, green: 181/255, blue: 230/255, alpha: 1)
        } else if degreesInFahrenheit >= 20 {
            return UIColor(red: 210/255, green: 226/255, blue: 237/255, alpha: 1)
        } else {
            return UIColor(red: 227/255, green: 243/255, blue: 251/255, alpha: 1)
        }
    }
    
    var textColor: UIColor {
        if degreesInFahrenheit >= 20 {
            return UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        } else {
            return UIColor(red: 44/255, green: 44/255, blue: 44/255, alpha: 1)
        }
    }
}

// MARK: - CustomStringConvertible
extension Temparture: CustomStringConvertible {
    var description: String {
        switch self {
        case .Fahrenheit(let degrees):
            return "\(Int(degrees))º"
        case .Celsius(let degrees):
            return "\(Int(degrees))º"
        }
    }
}