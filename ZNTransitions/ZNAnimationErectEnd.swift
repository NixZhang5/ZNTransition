//
//  ZNAnimationErectEnd.swift
//  ZNTransitions
//
//  Created by xinpin on 2018/11/21.
//  Copyright © 2018年 Nix. All rights reserved.
//

import UIKit

class ZNAnimationErectEnd: NSObject {

}

extension ZNAnimationErectEnd: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)
        let snapShot = fromView?.snapshotView(afterScreenUpdates: false)
        transitionContext.containerView.addSubview(toView!)
        transitionContext.containerView.addSubview(snapShot!)
        toView?.frame = transitionContext.containerView.bounds
        
        snapShot?.layer.anchorPoint = CGPoint(x: 0, y: 0.5)
        snapShot?.layer.position = CGPoint(x: 0, y: CGFloat((snapShot?.frame.height)! * 0.5))

        var rotateTransform = CATransform3DRotate(CATransform3DIdentity, CGFloat(-Double.pi / 2.0), 0, 1, 0)
        rotateTransform.m34 = -1 / 500.0
        fromView?.isHidden = true
        
        UIView.animate(withDuration: 0.3, animations: {
            snapShot?.layer.position = CGPoint(x: CGFloat((snapShot?.frame.width)!), y: CGFloat((snapShot?.frame.height)! * 0.5))
            snapShot?.layer.transform = rotateTransform
        }) { (finished) in
            snapShot?.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
