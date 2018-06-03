//
//  ImageTransitionDelegate.swift
//  Transition-Image-Sample
//
//  Created by kawaharadai on 2018/05/27.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//

import UIKit

final class ImageTransitionDelegate: NSObject {}

extension ImageTransitionDelegate: UIViewControllerTransitioningDelegate {
    
    /// 対象画面に遷移してくるときに呼ばれる
    func animationController(
        forPresented presented: UIViewController,
        presenting: UIViewController,
        source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return ImagePresentedAnimator()
    }
    
    /// 対象画面を閉じるときに呼ばれる
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ImageDismissedAnimator()
    }
}
