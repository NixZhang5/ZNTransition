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
    }
    
    var animationStyle: ZNAnimationStyle {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.animationStyle) as! ZNAnimationStyle
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.animationStyle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
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
