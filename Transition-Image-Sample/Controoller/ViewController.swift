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
    private var imageDataList = [ImageData]()
    private let numberOfColums: CGFloat = 3
    private let spacing: CGFloat = 15

    var imageTransitionDelegate: ImageTransitionDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    private func setup() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        imageDataList = DataSource.create()
        self.collectionView.reloadData()
        imageTransitionDelegate = ImageTransitionDelegate()
    }

    private func itemSize() -> CGSize {
        let insets = self.insets()
        let allSpace = (numberOfColums - 1) * spacing + (insets.left + insets.right)
        let itemLength = (collectionView.bounds.size.width - allSpace) / numberOfColums
        return CGSize(width: itemLength, height: itemLength)
    }

    private func insets() -> UIEdgeInsets {
        return UIEdgeInsets(top: 40, left: spacing, bottom: 0, right: spacing)
    }

}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageDataList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as? CollectionViewCell else {
            fatalError("cell is nil")
        }

        cell.setup(imageData: imageDataList[indexPath.row])
        return cell
    }

}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let image = UIImage(named: imageDataList[indexPath.item].name) else { return }
        let detailImageVC = DetailImageViewController(image: image)
//        imageViewController.transitioningDelegate = imageTransitionDelegate
//        imageViewController.image = imageDataList[indexPath.row].image
        present(detailImageVC, animated: true, completion: nil)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return itemSize()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return insets()
    }
}
