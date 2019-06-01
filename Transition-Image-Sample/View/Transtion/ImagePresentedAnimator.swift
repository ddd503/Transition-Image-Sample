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
        let containerView = transitionContext.containerView
        // 遷移先のsuperViewをaddしないと画面が描画されない
        containerView.addSubview(presented.view)
        presented.view.alpha = 0
        // 遷移先のViewのframeが確定していないため確定させる（呼ばないと確定前のoriginが取れる）
        presented.view.layoutIfNeeded()

        guard let transitionableCell = presenting.collectionView.cellForItem(at: selectedCellIndex) as? TransitionableCell else {
            transitionContext.cancelInteractiveTransition()
            return
        }

        let animationView = UIView(frame: presented.view.frame)
        animationView.backgroundColor = .black

        let imageView = UIImageView(image: transitionableCell.imageView.image)
        imageView.frame.size = transitionableCell.imageView.frame.size
        imageView.contentMode = transitionableCell.imageView.contentMode
        imageView.frame.origin = presenting.collectionView.convert(transitionableCell.frame.origin, to: presenting.view)
        animationView.addSubview(imageView)
        containerView.addSubview(animationView)

        UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseIn, animations: {
            imageView.frame = self.presented.imageView.frame
        }, completion: { [weak self] _ in
            self?.presented.view.alpha = 1
            animationView.removeFromSuperview()
            transitionContext.completeTransition(true)
        })
    }
}
