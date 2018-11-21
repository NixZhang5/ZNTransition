//
//  ZNAnimationErectBegin.swift
//  ZNTransitions
//
//  Created by xinpin on 2018/11/21.
//  Copyright © 2018年 Nix. All rights reserved.
//

import UIKit

class ZNAnimationErectBegin: NSObject {
    
}

extension ZNAnimationErectBegin: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)
        toView?.frame = transitionContext.containerView.bounds
        transitionContext.containerView.addSubview(toView!)
        toView?.layer.anchorPoint = CGPoint(x: 0, y: 0.5)
        toView?.layer.position = CGPoint(x: CGFloat((toView?.frame.width)!), y: CGFloat((toView?.frame.height)! * 0.5))
        
        var rotateTransform = CATransform3DRotate(CATransform3DIdentity, CGFloat(-Double.pi / 2.0), 0, 1, 0)
        rotateTransform.m34 = -1 / 500.0
        toView?.layer.transform = rotateTransform

        UIView.animate(withDuration: 0.3, animations: {
            toView?.layer.transform = CATransform3DIdentity
            toView?.layer.position = CGPoint(x: 0, y: CGFloat((toView?.frame.height)! * 0.5))
        }) { (finished) in
            toView?.layer.transform = CATransform3DIdentity
            toView?.layer.position = CGPoint(x: CGFloat((toView?.frame.width)! * 0.5), y: CGFloat((toView?.frame.height)! * 0.5))
            toView?.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
