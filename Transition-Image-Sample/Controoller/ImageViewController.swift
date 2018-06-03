//
//  ImageViewController.swift
//  Transition-Image-Sample
//
//  Created by kawaharadai on 2018/05/27.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // ボタンもアニメーションで出す
        if !self.backButton.isEnabled {
            UIView.animate(withDuration: 0.5, delay: 0.3, options: .curveLinear, animations: {
                self.backButton.alpha = 1.0
            }) { (_) in
                self.backButton.isEnabled = true
            }
        }
    }
    
    // 戻る
    @IBAction func back(_ sender: UIButton) {
        sender.isHidden = true
        self.dismiss(animated: true, completion: nil)
    }
}

extension ImageViewController: ImageDestinationTransitionType {}
