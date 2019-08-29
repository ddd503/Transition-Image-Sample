//
//  ImageDismissedAnimator.swift
//  Transition-Image-Sample
//
//  Created by kawaharadai on 2018/05/27.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//

import UIKit

final class ImageDismissedAnimator: NSObject, UIViewControllerAnimatedTransitioning {
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
        let animationView = UIView(frame: presented.view.frame)
        // 遷移元のViewをaddしておく（containerViewには遷移先のViewしかaddされないから遷移元のViewを仮に乗せる）
        containerView.addSubview(presenting.view)

        let backgroundView = UIView(frame: animationView.frame)
        backgroundView.backgroundColor = .white
        animationView.addSubview(backgroundView)

        let imageView = UIImageView(image: presented.imageView.image)
        imageView.contentMode = presented.imageView.contentMode
        imageView.frame = presented.imageView.frame
        animationView.addSubview(imageView)
        containerView.addSubview(animationView)

        guard let transitionableCell = presenting.collectionView.cellForItem(at: selectedCellIndex) as? CollectionViewCell else {
            transitionContext.cancelInteractiveTransition()
            return
        }
        
        let destinationFrame = transitionableCell.imageView.superview!.convert(transitionableCell.imageView.frame, to: containerView)
        let cellBackgroundView = UIView(frame: destinationFrame)
        cellBackgroundView.backgroundColor = .white
        containerView.insertSubview(cellBackgroundView, aboveSubview: presenting.view)

        UIView.animate(withDuration: duration, animations: {
            backgroundView.alpha = 0
            imageView.frame = destinationFrame
        }) { (_) in
            cellBackgroundView.removeFromSuperview()
            animationView.removeFromSuperview()
            transitionContext.completeTransition(true)
        }
    }
}

