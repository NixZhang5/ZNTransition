//
//  ZNVCTransitionDelegate.swift
//  ZNTransitions
//
//  Created by xinpin on 2018/11/27.
//  Copyright © 2018年 Nix. All rights reserved.
//

import UIKit

class ZNVCTransitionDelegate: NSObject {
    
    var height: CGFloat?
    
    var touchPoint: CGPoint?
    
    public static let shareInstance: ZNVCTransitionDelegate = {
        return ZNVCTransitionDelegate()
    }()
}

extension ZNVCTransitionDelegate: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        var objc: UIViewControllerAnimatedTransitioning?
        switch presented.animationStyle {
        case .erect:
            objc = ZNAnimationErectBegin()
        default:
            break
        }
        return objc
    }
    
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        var objc: UIViewControllerAnimatedTransitioning?
        switch dismissed.animationStyle {
        case .erect:
            objc = ZNAnimationErectEnd()
        default:
            break
        }
        return objc
    }
}
