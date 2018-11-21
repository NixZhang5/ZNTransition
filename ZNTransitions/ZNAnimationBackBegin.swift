//
//  ZNAnimationBackBegin.swift
//  ZNTransitions
//
//  Created by xinpin on 2018/11/21.
//  Copyright © 2018年 Nix. All rights reserved.
//

import UIKit

class ZNAnimationBackBegin: NSObject {

}

extension ZNAnimationBackBegin: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)
        toView?.frame = transitionContext.containerView.bounds
        transitionContext.containerView.addSubview(toView!)
        toView?.frame = CGRect(x: CGFloat((toView?.frame.width)!), y: CGFloat((toView?.frame.origin.y)!), width: CGFloat((toView?.frame.width)!), height: CGFloat((toView?.frame.height)!))

        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)
        
        UIView.animate(withDuration: 0.3, animations: {
            toView?.frame = CGRect(x: 0, y: CGFloat((toView?.frame.origin.y)!), width: CGFloat((toView?.frame.width)!), height: CGFloat((toView?.frame.height)!))
            fromView?.transform = CGAffineTransform.init(scaleX: 0.93, y: 0.93)
        }) { (finished) in
            toView?.frame = CGRect(x: 0, y: CGFloat((toView?.frame.origin.y)!), width: CGFloat((toView?.frame.width)!), height: CGFloat((toView?.frame.height)!))
            fromView?.transform = CGAffineTransform.identity
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
