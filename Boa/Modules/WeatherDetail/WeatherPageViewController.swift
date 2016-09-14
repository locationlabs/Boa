import Foundation
import UIKit

final class WeatherPageViewController: UIViewController {
    
    var presenter: WeatherDetailPresenterViewType!
    var styler: WeatherDetailStyleType!
    var pageViewController: UIPageViewController!
    var weatherReports: [WeatherReportEntity]!
    var initialIndex: Int!
    private var orderedWeatherDetailViewControllers: [WeatherDetailViewController]!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        UIApplication.sharedApplication().statusBarStyle = .LightContent
    }
    @IBAction func didPressListButton(sender: AnyObject) {
        presenter.requestListView()
    }
    
    let transition = ExpandingCellTransition()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transitioningDelegate = transition
        
        applyStyles()
        
        initViewControllers()
        pageControl.numberOfPages = weatherReports.count
        pageControl.currentPage = initialIndex
        
        pageViewController.dataSource = self
        pageViewController.delegate = self
        
        pageViewController.setViewControllers([orderedWeatherDetailViewControllers[initialIndex]],
            direction: .Forward, animated: true, completion: nil)
        
        
        addChildViewController(pageViewController)
        pageViewController.view.frame = CGRectMake(0,0,containerView.frame.size.width, containerView.frame.size.height)
        containerView.addSubview(pageViewController.view)
        pageViewController.didMoveToParentViewController(self)
    }
}

protocol WeatherPageViewType: class {
    
}

// MARK: - WeatherPageControlViewType
extension WeatherPageViewController: WeatherPageViewType {
    
}

extension WeatherPageViewController : UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let viewController = pageViewController.viewControllers?.first as! WeatherDetailViewController
        pageControl.currentPage = orderedWeatherDetailViewControllers.indexOf(viewController)!
    }

    func pageViewController(pageViewController: UIPageViewController,
        viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedWeatherDetailViewControllers.indexOf(viewController as! WeatherDetailViewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedWeatherDetailViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedWeatherDetailViewControllers[previousIndex]
    }
    
    func pageViewController(pageViewController: UIPageViewController,
        viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedWeatherDetailViewControllers.indexOf(viewController as! WeatherDetailViewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        
        guard orderedWeatherDetailViewControllers.count != nextIndex else {
            return nil
        }
    
        guard orderedWeatherDetailViewControllers.count > nextIndex else {
            return nil
        }
        
        return orderedWeatherDetailViewControllers[nextIndex]
    }
}

extension WeatherPageViewController {
    private func initViewControllers() {
        let weatherDetailStoryboard = UIStoryboard(name: "WeatherDetail", bundle: nil)

        orderedWeatherDetailViewControllers = weatherReports.map {
            let weatherDetailVC = weatherDetailStoryboard.instantiateViewControllerWithIdentifier("WeatherDetail") as! WeatherDetailViewController
            weatherDetailVC.weatherReport = $0
            weatherDetailVC.styler = styler
            return weatherDetailVC
        }
    }
}

extension WeatherPageViewController {
    private func applyStyles() {
        pageControl.pageIndicatorTintColor = UIColor(rgb: "#DBDBDB")
        pageControl.currentPageIndicatorTintColor = .whiteColor()
    }
}
