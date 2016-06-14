//
//  MultipleURLsCollectionViewController.swift
//  Agrume Example
//

import UIKit
import Agrume

final class MultipleURLsCollectionViewController: UICollectionViewController {

    private let identifier = "Cell"

    private struct ImageWithURL {
        let image: UIImage
        let URL: Foundation.URL
    }

    private let images = [
        ImageWithURL(image: UIImage(named: "MapleBacon")!,
                     URL: URL(string: "https://dl.dropboxusercontent.com/u/512759/MapleBacon.png")!),
        ImageWithURL(image: UIImage(named: "EvilBacon")!,
                     URL: URL(string: "https://dl.dropboxusercontent.com/u/512759/EvilBacon.png")!)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: view.bounds.width, height: view.bounds.height)
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! DemoCell
        cell.imageView.image = images[indexPath.row].image
        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let URLs = images.map { $0.URL }
        let agrume = Agrume(imageURLs: URLs, startIndex: indexPath.row, backgroundBlurStyle: .extraLight)
        agrume.didScroll = { [unowned self] index in
            self.collectionView?.scrollToItem(at: IndexPath(row: index, section: 0), at: [], animated: false)
        }
        agrume.showFrom(self)
    }

}
