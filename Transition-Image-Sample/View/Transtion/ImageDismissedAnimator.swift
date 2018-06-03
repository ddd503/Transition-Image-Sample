//
//  ImageDismissedAnimator.swift
//  Transition-Image-Sample
//
//  Created by kawaharadai on 2018/05/27.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//

import UIKit

final class ImageDismissedAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        // 遷移中のviewの取り出し
        let containerView = transitionContext.containerView
        // 遷移のスピードを決定
        let animationDuration = transitionDuration(using: transitionContext)
        // 遷移元のVCとviewを取り出し
        guard
            let fromVC = transitionContext.viewController(forKey: .from) as? ImageDestinationTransitionType,
            let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from) else {
                return
        }
        // 遷移中に遷移先のviewを見せるため
        fromView.backgroundColor = UIColor.clear
        
        // 遷移元のイメージビューのスクショを撮る
        let snapshot = fromVC.imageView.snapshotView(afterScreenUpdates: false)
        // 遷移元のイメージビューのフレームを取得
        snapshot?.frame = CGRect(x: 0, y: 0, width: fromVC.imageView.frame.width, height: fromVC.imageView.frame.height)
        
        snapshot?.autoresizingMask = [.flexibleHeight, .flexibleWidth, .flexibleTopMargin, .flexibleBottomMargin]
        fromVC.imageView.alpha = 0.0
        
        guard
            let toVC = transitionContext.viewController(forKey: .to) as? ImageSourceTransitionType,
            let toView = transitionContext.view(forKey: .to) else {
                return
        }
        
        containerView.insertSubview(toView, belowSubview: fromView)
        
        guard let selectedIndexPath = toVC.collectionView.indexPathsForSelectedItems?.first else {
            return
        }
        let selectedCell = toVC.collectionView.cellForItem(at: selectedIndexPath) as! ImageCollectionViewCellType
        selectedCell.imageView.alpha = 0.0
        selectedCell.imageView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        
        toVC.collectionView.frame = transitionContext.finalFrame(for: toVC as! UIViewController)
        
        // create animationView
        let animationView = UIView(frame: fromVC.imageView.frame)
        animationView.clipsToBounds = true
        animationView.addSubview(snapshot!)
        containerView.addSubview(animationView)
        
        // baseViewを用意（いらないかも）
        let baseView = UIView(frame: fromVC.imageView.frame)
        baseView.backgroundColor = .clear
        containerView.insertSubview(baseView, belowSubview: animationView)
        
        UIView.animateKeyframes(
            withDuration: animationDuration,
            delay: 0.0,
            options: .calculationModeLinear,
            animations: {
                
                UIView.addKeyframe(
                    withRelativeStartTime: 0.0,
                    relativeDuration: 1.0,
                    animations: {
                        
                        fromVC.imageView.alpha = 0.0
                        animationView.frame = containerView.convert(
                            selectedCell.imageView.frame,
                            from: selectedCell.imageView.superview
                        )
                        baseView.alpha = 0.0
                        selectedCell.imageView.alpha = 1.0
                })
                
                UIView .addKeyframe(
                    withRelativeStartTime: 0.95,
                    relativeDuration: 0.05,
                    animations: {
                        snapshot?.alpha = 0.0
                })
                
        }) { _ in
            
            baseView.removeFromSuperview()
            snapshot?.removeFromSuperview()
            animationView.removeFromSuperview()
            fromVC.imageView.isHidden = false
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}

