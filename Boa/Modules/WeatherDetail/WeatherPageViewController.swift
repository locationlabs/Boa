import Foundation
import UIKit

final class WeatherPageViewController: UIViewController {
    
    var presenter: WeatherDetailPresenterViewType!
    var styler: WeatherDetailStyleType!
    var pageViewController: UIPageViewController!
    var weatherReports: [WeatherReportEntity]!
    var initialIndex: Int!
    fileprivate var orderedWeatherDetailViewControllers: [WeatherDetailViewController]!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    @IBAction func didPressListButton(_ sender: AnyObject) {
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
            direction: .forward, animated: true, completion: nil)
        
        
        addChildViewController(pageViewController)
        pageViewController.view.frame = CGRect(x: 0,y: 0,width: containerView.frame.size.width, height: containerView.frame.size.height)
        containerView.addSubview(pageViewController.view)
        pageViewController.didMove(toParentViewController: self)
    }
}

protocol WeatherPageViewType: class {
    
}

// MARK: - WeatherPageControlViewType
extension WeatherPageViewController: WeatherPageViewType {
    
}

extension WeatherPageViewController : UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let viewController = pageViewController.viewControllers?.first as! WeatherDetailViewController
        pageControl.currentPage = orderedWeatherDetailViewControllers.index(of: viewController)!
    }

    func pageViewController(_ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedWeatherDetailViewControllers.index(of: viewController as! WeatherDetailViewController) else {
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
    
    func pageViewController(_ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedWeatherDetailViewControllers.index(of: viewController as! WeatherDetailViewController) else {
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
    fileprivate func initViewControllers() {
        let weatherDetailStoryboard = UIStoryboard(name: "WeatherDetail", bundle: nil)

        orderedWeatherDetailViewControllers = weatherReports.map {
            let weatherDetailVC = weatherDetailStoryboard.instantiateViewController(withIdentifier: "WeatherDetail") as! WeatherDetailViewController
            weatherDetailVC.weatherReport = $0
            weatherDetailVC.styler = styler
            return weatherDetailVC
        }
    }
}

extension WeatherPageViewController {
    fileprivate func applyStyles() {
        styler.stylePageControl(pageControl)
    }
}
