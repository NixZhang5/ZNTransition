//
//  UIViewController+ZNPush.swift
//  ZNTransitions
//
//  Created by xinpin on 2018/11/21.
//  Copyright © 2018年 Nix. All rights reserved.
//

import UIKit

enum ZNAnimationStyle {
    case backScale
    case erect
}

extension UIViewController {
    
    private struct AssociatedKeys {
        static var animationStyle = "animationStyle"
        static var transitionDelegate = "transitionDelegate"
    }
    
    var animationStyle: ZNAnimationStyle {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.animationStyle) as! ZNAnimationStyle
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.animationStyle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var transitionDelegate: ZNVCTransitionDelegate {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.transitionDelegate) as! ZNVCTransitionDelegate
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.transitionDelegate, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func zn_presentErectVC(_ viewController: UIViewController, completion:(() -> Void)?) {
        self.zn_presentVC(viewController, type: .erect, height: 0, point: CGPoint.zero, completion: completion)
    }
    
    func zn_presentVC(_ viewController: UIViewController, type: ZNAnimationStyle, height: CGFloat, point: CGPoint, completion:(() -> Void)?) {
        
        self.transitionDelegate = ZNVCTransitionDelegate.shareInstance
        self.transitionDelegate.height = height
        self.transitionDelegate.touchPoint = point
        viewController.animationStyle = type
        viewController.modalPresentationStyle = UIModalPresentationStyle.custom
        viewController.transitioningDelegate = self.transitionDelegate
        self.present(viewController, animated: true, completion: completion)
    }
    
    func zn_dismissWithPoint(_ point: CGPoint, completion:(() -> Void)?) {
        let transitionDelegate = self.transitionDelegate
        transitionDelegate.touchPoint = point
        self.dismiss(animated: true, completion: completion)
    }
    
    func zn_dismissViewControllerAnimated(_ animated: Bool, completion:(() -> Void)?) {
        if (!animated) {
            self.presentingViewController?.resetInitialInfo()
        }
        self.zn_dismissViewControllerAnimated(animated, completion: completion)
    }
    
    func resetInitialInfo() {
        if (self.view.layer.anchorPoint == CGPoint(x: 0.5, y: 0.5)) {
            return
        }
        self.view.alpha = 1
        self.view.layer.transform = CATransform3DIdentity
        self.view.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.view.layer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }

}

extension UINavigationController {
        
    private struct AssociatedKeys {
        static var interactionDelegate = "interactionDelegate"
    }
    
    var interactionDelegate: ZNVCInteractionDelegate {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.interactionDelegate) as! ZNVCInteractionDelegate
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.interactionDelegate, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func zn_pushBackScaleViewController(_ viewController: UIViewController) {
        self.zn_pushViewController(viewController, style: .backScale)
    }
    
    func zn_pushViewController(_ viewController: UIViewController, style: ZNAnimationStyle) {
        self.interactionDelegate = ZNVCInteractionDelegate.shareInstance
        self.interactionDelegate.navigation = self
        viewController.animationStyle = style
        let edgePan = UIScreenEdgePanGestureRecognizer.init(target: self.interactionDelegate, action: #selector(self.interactionDelegate.edgePanAction(gesture:)))
        edgePan.edges = UIRectEdge.left
        viewController.view.addGestureRecognizer(edgePan)

        if (self.delegate !== self.interactionDelegate) {
            self.interactionDelegate.delegate = (self.delegate != nil) ? self.delegate : nil
            self.delegate = self.interactionDelegate
        }
        self.pushViewController(viewController, animated: true)
    }
}
