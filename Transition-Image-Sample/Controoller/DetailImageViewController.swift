//
//  DetailImageViewController.swift
//  Transition-Image-Sample
//
//  Created by kawaharadai on 2019/05/30.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit

final class DetailImageViewController: UIViewController, ImageDestinationTransitionType {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak private var closeButton: UIButton!
    private let image: UIImage

    init(image: UIImage) {
        self.image = image
        super.init(nibName: "DetailImageViewController", bundle: .main)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !closeButton.isEnabled {
            UIView.animate(withDuration: 0.5, delay: 0.3, options: .curveLinear, animations: {
                self.closeButton.alpha = 1.0
            }) { (_) in
                self.closeButton.isEnabled = true
            }
        }
    }

    @IBAction func didTapClose(_ sender: UIButton) {
        sender.isHidden = true
        dismiss(animated: true, completion: nil)
    }

}
