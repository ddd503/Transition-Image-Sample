//
//  ImageTransitionProtocol.swift
//  Transition-Image-Sample
//
//  Created by kawaharadai on 2018/05/27.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//

import UIKit

protocol ImageSourceTransitionType {
    var collectionView: UICollectionView! { get }
}

protocol ImageDestinationTransitionType {
    var imageView: UIImageView! { get }
}

protocol TransitionableCell {
    var imageView: UIImageView! { get }
    
//    static var identifier: String { get }
}

extension TransitionableCell {
    static var identifier: String {
        get {
            return String(describing: self)
        }
    }
}
