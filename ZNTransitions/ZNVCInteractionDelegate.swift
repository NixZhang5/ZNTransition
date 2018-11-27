//
//  ZNVCInteractionDelegate.swift
//  ZNTransitions
//
//  Created by xinpin on 2018/11/21.
//  Copyright © 2018年 Nix. All rights reserved.
//

import UIKit

class ZNVCInteractionDelegate: UIPercentDrivenInteractiveTransition {

    weak var navigation: UINavigationController?
    weak var delegate: UINavigationControllerDelegate?

    var isPop: Bool = false
    var isInteraction: Bool = false
    
    public static let shareInstance: ZNVCInteractionDelegate = {
        return ZNVCInteractionDelegate()
    }()
}

extension ZNVCInteractionDelegate: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return isInteraction ? isPop ? self : nil : nil
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        var objc: UIViewControllerAnimatedTransitioning?
        if operation == .push {
            isPop = false
            switch toVC.animationStyle {
            case .backScale:
                objc = ZNAnimationBackBegin()
            case .erect:
                objc = ZNAnimationErectBegin()
            }
        } else if operation == .pop {
            isPop = true
            switch fromVC.animationStyle {
            case .backScale:
                objc = ZNAnimationBackEnd()
            case .erect:
                objc = ZNAnimationErectEnd()
            }
        }
        return objc
    }
    
    @objc func edgePanAction(gesture: UIScreenEdgePanGestureRecognizer) {
        let rate: CGFloat = gesture.translation(in: UIApplication.shared.keyWindow).x / UIScreen.main.bounds.width
        let velocity: CGFloat = gesture.velocity(in: UIApplication.shared.keyWindow).x
        switch gesture.state {
        case .began:
            isInteraction = true
            self.navigation?.popViewController(animated: true)
            break
        case .changed:
            isInteraction = false
            self.update(rate)
            break
        case .ended:
            isInteraction = false
            if (rate >= 0.4) {
                self.finish()
            } else {
                if (velocity > 1000) {
                    self.finish()
                }
                else {
                    self.cancel()
                }
            }
            break
        default:
            isInteraction = false
            self.cancel()
            break
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if self.delegate !== nil && self.delegate !== self && (self.delegate?.responds(to: #selector(navigationController(_:willShow:animated:))))! {
            self.delegate?.navigationController!(navigationController, willShow: viewController, animated: animated)
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if self.delegate !== nil && self.delegate !== self && (self.delegate?.responds(to: #selector(navigationController(_:didShow:animated:))))! {
            self.delegate?.navigationController!(navigationController, didShow: viewController, animated: animated)
        }
    }
    
    func navigationControllerSupportedInterfaceOrientations(_ navigationController: UINavigationController) -> UIInterfaceOrientationMask {
        if self.delegate !== nil && self.delegate !== self && (self.delegate?.responds(to: #selector(navigationControllerSupportedInterfaceOrientations(_:))))! {
            return (self.delegate?.navigationControllerSupportedInterfaceOrientations!(navigationController))!
        }
        return .portrait
    }
    
    func navigationControllerPreferredInterfaceOrientationForPresentation(_ navigationController: UINavigationController) -> UIInterfaceOrientation {
        if self.delegate !== nil && self.delegate !== self && (self.delegate?.responds(to: #selector(navigationControllerPreferredInterfaceOrientationForPresentation(_:))))! {
            return (self.delegate?.navigationControllerPreferredInterfaceOrientationForPresentation!(navigationController))!
        }
        return .unknown
    }
}







