//
//  HXHFlipTransition.swift
//  FlipTransitionAnimationDemo
//
//  Created by 张强 on 2016/11/20.
//  Copyright © 2016年 ColorPen. All rights reserved.
//

import UIKit

enum HXHFlipTransition {
    case present
    case dismiss
    
    func animation() -> UIViewControllerAnimatedTransitioning {
        return FlipTransitionAnimation(type: self)
    }
}

class FlipTransitionAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    private var toViewPreAngle : CGFloat = CGFloat(M_PI_2)
    private var frowViewAngle : CGFloat = CGFloat(-M_PI_2)

    // MARK: - Life Cycle
    
    init(type : HXHFlipTransition) {
        toViewPreAngle = CGFloat((type == .present) ? M_PI_2 : -M_PI_2)
        frowViewAngle = CGFloat((type == .present) ? -M_PI_2 : M_PI_2)
    }
    
    // MARK: - delegate
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.8
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        // 1.
        let fromVC = transitionContext.viewController(forKey: .from)!
        let toVC   = transitionContext.viewController(forKey: .to)!
        let fromView = fromVC.view!
        let toView   = toVC.view!
        
        // 2. 转场容器View
        let containerView = transitionContext.containerView
        containerView.addSubview(toView)
        
        // 3.
        var transform = CATransform3DIdentity
        // 设置透视效果，一般设为 -0.002
        transform.m34 = -0.002
        // 将动画影响到父视图下的所有子视图
        containerView.layer.sublayerTransform = transform
        
        // 4.
        let initialFrame = transitionContext.initialFrame(for: fromVC)
        // 给 toVC 设置初始 frame
        toView.frame = initialFrame
        // 预先将toView旋转90°，否则会遮挡fromView
        toView.layer.transform = rotate_Y(angle: self.toViewPreAngle)
        
        // 5. animation - fromView 与 toView 一起动画，正反面一起动
        let duration = transitionDuration(using: transitionContext)
        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: .calculationModeLinear, animations: {
            // 可见动画分解
            // a. 将fromView从初始状态，旋转90°，立起来
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5, animations: {
                fromVC.view.layer.transform = self.rotate_Y(angle: self.frowViewAngle)
            })
            // b. 将开始已经置于90°的toView旋转为初始状态
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                toView.layer.transform = CATransform3DIdentity
            })
        }) { (finished) in
            // c. 将fromView置为初始状态
            fromView.layer.transform = CATransform3DIdentity
            transitionContext.completeTransition(true)
        }
    }
    
    /**
     沿着Y轴旋转
     angle 旋转的角度
     */
    private func rotate_Y(angle: CGFloat) -> CATransform3D {
        return  CATransform3DMakeRotation(angle, 0.0, 1.0, 0.0);
    }
    
}

