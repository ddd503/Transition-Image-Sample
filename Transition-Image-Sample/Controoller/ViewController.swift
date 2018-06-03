//
//  ViewController.swift
//  Transition-Image-Sample
//
//  Created by kawaharadai on 2018/05/26.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    private let provider = CollectionViewProvider()
    var imageTransitionDelegate: ImageTransitionDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    private func setup() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = provider
        provider.imageDataList = DataSource.create()
        self.collectionView.reloadData()
        imageTransitionDelegate = ImageTransitionDelegate()
    }
}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let imageViewController = UIStoryboard(name: "Image", bundle: nil)
            .instantiateInitialViewController() as? ImageViewController else {
                return
        }
        
        imageViewController.transitioningDelegate = imageTransitionDelegate
        
        imageViewController.image = self.provider.imageDataList[indexPath.row].image
        
        present(imageViewController, animated: true, completion: nil)
        
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    // アイテムの大きさを設定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = self.view.frame.width / 3.5
        
        return CGSize(width: size, height: size)
    }
    
    // コレクションビュー自体の周りのinset（セル同士のinsetはstoryboardで）
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let inset: CGFloat =  self.view.frame.width / 24
        
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
}

extension ViewController: ImageSourceTransitionType {}
