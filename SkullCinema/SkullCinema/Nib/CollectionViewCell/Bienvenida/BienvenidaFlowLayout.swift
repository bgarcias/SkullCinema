//
//  BienvenidaFlowLayout.swift
//  SkullCinema
//
//  Created by Brandon Garcia Sanchez on 04/12/2024.
//

import UIKit

class BienvenidaFlowLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        scrollDirection = .horizontal
        minimumInteritemSpacing = 0.0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepare() {
        super.prepare()
        guard let collectionView = collectionView else { return }
        itemSize = collectionView.bounds.size
    }

}
