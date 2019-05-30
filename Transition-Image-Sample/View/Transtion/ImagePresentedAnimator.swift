//
//  ImagePresentedAnimator.swift
//  Transition-Image-Sample
//
//  Created by kawaharadai on 2018/05/27.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//

import UIKit

final class ImagePresentedAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    let presenting: ImageSourceTransitionType
    let presented: ImageDestinationTransitionType
    let transitionableCell: TransitionableCell
    let duration: TimeInterval

    init(presenting: ImageSourceTransitionType, presented: ImageDestinationTransitionType, transitionableCell: TransitionableCell, duration: TimeInterval) {
        self.presenting = presenting
        self.presented = presented
        self.transitionableCell = transitionableCell
        self.duration = duration
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView

        let animationDuration = transitionDuration(using: transitionContext)
        
        guard
            let toView = transitionContext.view(forKey: .to),
            let toVC = transitionContext.viewController(forKey: .to) as? ImageDestinationTransitionType else {
                return
        }
        
        // set image
        toVC.imageView.image = transitionableCell.imageView.image
        
        let finalFrame = presented.imageView.frame
        
        toView.clipsToBounds = true
        containerView.addSubview(toView)
        
        let selectedCellFrame = containerView.convert(
            transitionableCell.imageView.frame,
            from: transitionableCell.imageView.superview
        )
        
        // create animationView
        let animationView = UIView(frame: selectedCellFrame)
        animationView.backgroundColor = .clear
        animationView.clipsToBounds = true
        
        let imageView = UIImageView(image: transitionableCell.imageView.image)
        imageView.frame = CGRect(x: 0.0, y: 0.0, width: selectedCellFrame.width, height: selectedCellFrame.height)
        imageView.contentMode = toVC.imageView.contentMode
        imageView.autoresizingMask = [.flexibleHeight, .flexibleWidth, .flexibleTopMargin, .flexibleBottomMargin]
        
        animationView.addSubview(imageView)
        containerView.addSubview(animationView)
        
        // create baseview（スナップショットをとって動かすため、VCとスナップショットの間に挟んでバツボタンを消すためだけ）
        let blackView = UIView(frame: presenting.collectionView.frame)
        blackView.backgroundColor = .black
        containerView.insertSubview(blackView, belowSubview: animationView)
        
        UIView.animate(withDuration: animationDuration,
                       delay: 0.0,
                       options: .curveEaseOut,
                       animations: {
                        animationView.frame = finalFrame
                        
        }, completion: { _ in
            
            // アニメーションが完了したら、animationView, whiteViewを削除する
            animationView.removeFromSuperview()
            blackView.removeFromSuperview()
            transitionContext.completeTransition(true)
        })
    }

}
