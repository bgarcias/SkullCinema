//
//  PeliculaFlowLayout.swift
//  SkullCinema
//
//  Created by Brandon Garcia Sanchez on 05/12/2024.
//

import UIKit

class PeliculaFlowLayout: UICollectionViewFlowLayout {
    private var columnCount = 2
    private var heightRatio: CGFloat = 4 / 3
    private var bottomInfoHeight: Double = 75
    
    init(minimumInteritemSpacing: Double = 10, minimumLineSpacing: Double = 5, bottomInfoHeight: Double = 75) {
        super.init()
        self.minimumInteritemSpacing = minimumInteritemSpacing
        self.minimumLineSpacing = minimumLineSpacing
        self.bottomInfoHeight = bottomInfoHeight
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepare() {
        super.prepare()
        guard let collectionView = collectionView else { return }
        let spacings = collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + minimumInteritemSpacing * CGFloat(columnCount - 1)
        let itemWidth = (collectionView.bounds.width - spacings) / CGFloat(columnCount)
        let itemHeight = itemWidth * heightRatio + bottomInfoHeight
        itemSize = CGSize(width: itemWidth, height: itemHeight)
    }

}
