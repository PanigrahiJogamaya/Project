//
//  AnimationController.swift
//  MatchChallenge
//
//  Created by Jogamaya Panigrahi on 7/16/18.
//  Copyright © 2018 Jogamaya Panigrahi. All rights reserved.
//

import Foundation
import UIKit
class CustomAnimationController: NSObject, UIViewControllerAnimatedTransitioning{
    //Check whether the navigation is from destination to source view
    var isReverseDirection = false

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        //To view controller
        let destViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        //From view controller
        let sourceViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        //To view
        let destView = destViewController?.view
        //From view
        let sourceView = sourceViewController?.view
        //Check whether the navigation is from destination to source view.If yes, set direction is -1.Otherwise set the direction as 1.
        let direction:CGFloat = isReverseDirection ? -1:1
        // Set the transformations
        let constant = -0.006
        destView?.layer.anchorPoint = CGPoint(x:direction == 1 ? 0:1,y:0.5)
        sourceView?.layer.anchorPoint = CGPoint(x:direction == 1 ? 1:0,y:0.5)
        var viewSource:CATransform3D = CATransform3DMakeRotation(direction*CGFloat(Double.pi / 2), 0.0, 1.0, 0.0)
        var viewDest:CATransform3D = CATransform3DMakeRotation(-direction*CGFloat(Double.pi / 2), 0.0, 1.0, 0.0)
        viewSource.m34 = CGFloat(constant)
        viewDest.m34 = CGFloat(constant)
        container.transform = CGAffineTransform(translationX: direction*container.frame.size.width/2.0,y: 0)
        destView?.layer.transform = viewDest
        container.addSubview(destView!)
        //Animate with the above properties  for transform
        UIView.animate(withDuration:transitionDuration(using: transitionContext) , animations: {
            container.transform = CGAffineTransform(translationX: -direction*container.frame.size.width/2.0,y: 0)
            sourceView?.layer.transform = viewSource
            destView?.layer.transform = viewDest
        },completion:{
            finished in
            container.transform = CGAffineTransform.identity
            sourceView?.layer.transform = CATransform3DIdentity
            destView?.layer.transform = CATransform3DIdentity
            sourceView?.layer.anchorPoint = CGPoint(x:0.5,y:0.5)
            destView?.layer.anchorPoint = CGPoint(x:0.5,y:0.5)
            
            
            if(transitionContext.transitionWasCancelled){
                destView?.removeFromSuperview()
            }
            else{
                sourceView?.removeFromSuperview()
            }
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
        
    }
    

   
}
