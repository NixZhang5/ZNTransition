//
//  ZNAnimationBackEnd.swift
//  ZNTransitions
//
//  Created by xinpin on 2018/11/21.
//  Copyright © 2018年 Nix. All rights reserved.
//

import UIKit

class ZNAnimationBackEnd: NSObject { }

extension ZNAnimationBackEnd: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)
        toView?.frame = transitionContext.containerView.bounds
        transitionContext.containerView.addSubview(toView!)
        toView?.transform = CGAffineTransform.init(scaleX: 0.93, y: 0.93)

        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)
        transitionContext.containerView.bringSubview(toFront: fromView!)

        let origin = fromView?.frame
        UIView.animate(withDuration: 0.3, animations: {
            fromView?.frame = CGRect(x: CGFloat((fromView?.frame.width)!), y: CGFloat((fromView?.frame.origin.y)!), width: CGFloat((fromView?.frame.width)!), height: CGFloat((fromView?.frame.height)!))
            toView?.transform = CGAffineTransform.identity
        }) { (finished) in
            fromView?.frame = origin!
            toView?.transform = CGAffineTransform.identity
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
