import Foundation
import UIKit

private let kExpandingCellTransitionDuration: TimeInterval = 0.4

@objc
protocol ExpandingTransitionPresentingViewController {
    func expandingTransitionTargetViewForTransition(transition: ExpandingCellTransition) -> UIView!
}

enum TransitionType {
    case None
    case Presenting
    case Dismissing
}

enum TransitionState {
    case Initial
    case Final
}

class ExpandingCellTransition: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    var type: TransitionType = .None
    var presentingController: UIViewController!
    var presentedController: UIViewController!
    
    var topRegionSnapshot: UIView!
    var bottomRegionSnapshot: UIView!
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return kExpandingCellTransitionDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let duration = transitionDuration(using: transitionContext)
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let containerView = transitionContext.containerView
        
        var foregroundViewController = toViewController
        var backgroundViewController = fromViewController
        
        if type == .Dismissing {
            foregroundViewController = fromViewController
            backgroundViewController = toViewController
        }
        
        containerView.addSubview(foregroundViewController.view)
        
        
        // get target view
        var targetViewController = backgroundViewController
        if let navController = targetViewController as? UINavigationController {
            targetViewController = navController.topViewController!
        }
        let targetViewMaybe = (targetViewController as? ExpandingTransitionPresentingViewController)?.expandingTransitionTargetViewForTransition(transition: self)
        
        assert(targetViewMaybe != nil, "Cannot find target view in background view controller")
        
        let targetView = targetViewMaybe!
        
        
        // setup animation
        let targetFrame = backgroundViewController.view.convert(targetView.frame, from: targetView.superview)
        if type == .Presenting {
            sliceSnapshotsInBackgroundViewController(backgroundViewController: backgroundViewController, targetFrame: targetFrame, targetView: targetView)
        }
        
        containerView.addSubview(topRegionSnapshot)
        containerView.addSubview(bottomRegionSnapshot)
        
        let width = backgroundViewController.view.bounds.width
        let height = backgroundViewController.view.bounds.height
        
        let preTransition: TransitionState = (type == .Presenting ? .Initial : .Final)
        let postTransition: TransitionState = (type == .Presenting ? .Final : .Initial)
        
        configureViewsToState(state: preTransition, width: width, height: height, targetFrame: targetFrame, foregroundView: foregroundViewController.view)
        
        
        // perform animation
        backgroundViewController.view.isHidden = true
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: { () -> Void in
            [self]
            self.configureViewsToState(state: postTransition, width: width, height: height, targetFrame: targetFrame, foregroundView: foregroundViewController.view)
            }, completion: {
                (finished) in
                [self]
                self.topRegionSnapshot.removeFromSuperview()
                self.bottomRegionSnapshot.removeFromSuperview()
                
                backgroundViewController.view.isHidden = false
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        presentingController = presenting
        if let navController = presentingController as? UINavigationController {
            presentingController = navController.topViewController
        }
        
        if presentingController is ExpandingTransitionPresentingViewController {
            type = .Presenting
            return self
        } else {
            type = .None
            return nil
        }
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if presentingController is ExpandingTransitionPresentingViewController {
            type = .Dismissing
            return self
        } else {
            type = .None
            return nil
        }
    }
    
    func sliceSnapshotsInBackgroundViewController(backgroundViewController: UIViewController, targetFrame: CGRect, targetView: UIView) {
        let view = backgroundViewController.view
        let width = view?.bounds.width
        let height = view?.bounds.height
        
        // create top region snapshot
        topRegionSnapshot = view?.resizableSnapshotView(from: CGRect(x: 0, y: 0, width: width!, height: targetFrame.maxY), afterScreenUpdates: false, withCapInsets: UIEdgeInsets.zero)
        
        // create bottom region snapshot
        bottomRegionSnapshot = view?.resizableSnapshotView(from: CGRect(x: 0, y: targetFrame.maxY, width: width!, height: height!-targetFrame.maxY), afterScreenUpdates: false, withCapInsets: UIEdgeInsets.zero)
    }
    
    func configureViewsToState(state: TransitionState, width: CGFloat, height: CGFloat, targetFrame: CGRect, foregroundView: UIView) {
        switch state {
        case .Initial:
            topRegionSnapshot.frame = CGRect(x: 0, y: 0, width: width, height: targetFrame.maxY)
            bottomRegionSnapshot.frame = CGRect(x: 0, y: targetFrame.maxY, width: width, height: height-targetFrame.maxY)
            
        case .Final:
            topRegionSnapshot.frame = CGRect(x: 0, y: -targetFrame.maxY, width: width, height: targetFrame.maxY)
            bottomRegionSnapshot.frame = CGRect(x: 0, y: height, width: width, height: height-targetFrame.maxY)
        }
    }
}


