//
//  DetailImageViewController.swift
//  Transition-Image-Sample
//
//  Created by kawaharadai on 2019/05/30.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit

final class DetailImageViewController: UIViewController {

    @IBOutlet weak private var detailImageView: UIImageView!
    private let image: UIImage

    init(image: UIImage) {
        self.image = image
        super.init(nibName: "", bundle: .main)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        detailImageView.image = image
    }

}
