//
//  ExtensionUICollectionView.swift
//  SkullCinema
//
//  Created by Brandon Garcia Sanchez on 04/12/2024.
//

import Foundation

import UIKit

extension UICollectionView {
    func setup(_ nibName: String, _ flowLayout: UICollectionViewFlowLayout) {
        self.register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: nibName)
        self.collectionViewLayout = flowLayout
    }
}
