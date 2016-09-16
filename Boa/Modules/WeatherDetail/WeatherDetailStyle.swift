import UIKit

protocol WeatherDetailStyleType {
    func styleGradientView(view: UIView, withTemperature temperature: Temperature)
    func stylePageControl(pageControl: UIPageControl)
}

// MARK: - EventDetailStyleType
struct WeatherDetailStyle: WeatherDetailStyleType, BaseStyleType {
    func styleGradientView(view: UIView, withTemperature temperature: Temperature) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = view.frame
        gradient.colors = [temperature.startColor.CGColor, temperature.endColor.CGColor]
        view.layer.insertSublayer(gradient, atIndex: 0)
    }
    func stylePageControl(pageControl: UIPageControl) {
        pageControl.pageIndicatorTintColor = UIColor(rgb: "#DBDBDB")
        pageControl.currentPageIndicatorTintColor = .whiteColor()
    }
}
