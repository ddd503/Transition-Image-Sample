//
//  ImagePresentedAnimator.swift
//  Transition-Image-Sample
//
//  Created by kawaharadai on 2018/05/27.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//

import UIKit

final class ImagePresentedAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    weak var presenting: ImageSourceTransitionType?
    weak var presented: ImageDestinationTransitionType?
    let duration: TimeInterval
    let selectedCellIndex: IndexPath

    init(presenting: ImageSourceTransitionType, presented: ImageDestinationTransitionType, duration: TimeInterval, selectedCellIndex: IndexPath) {
        self.presenting = presenting
        self.presented = presented
        self.duration = duration
        self.selectedCellIndex = selectedCellIndex
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let presenting = presenting, let presented = presented else {
            transitionContext.cancelInteractiveTransition()
            return
        }

        let containerView = transitionContext.containerView
        // 遷移先のViewのFrameに最終配置位置のFrameをset
        presented.view.frame = transitionContext.finalFrame(for: presented)
        presented.view.layoutIfNeeded()
        // 遷移先のsuperViewをaddしないと画面が描画されない
        containerView.addSubview(presented.view)
        presented.view.alpha = 0

        guard let transitionableCell = presenting.collectionView.cellForItem(at: selectedCellIndex) as? CollectionViewCell else {
            transitionContext.cancelInteractiveTransition()
            return
        }

        let animationView = UIView(frame: presenting.view.frame)
        animationView.backgroundColor = .white
        let imageView = UIImageView(frame: transitionableCell.imageView.superview!.convert(transitionableCell.imageView.frame, to: animationView))
        imageView.image = transitionableCell.imageView.image
        imageView.contentMode = transitionableCell.imageView.contentMode
        animationView.addSubview(imageView)
        containerView.addSubview(animationView)

        let animation = UIViewPropertyAnimator(duration: duration, dampingRatio: 0.8) {
            imageView.frame = presented.imageView.frame
        }
        animation.addCompletion { (_) in
            presented.view.alpha = 1
            animationView.removeFromSuperview()
            transitionContext.completeTransition(true)
        }
        animation.startAnimation()
    }
}
