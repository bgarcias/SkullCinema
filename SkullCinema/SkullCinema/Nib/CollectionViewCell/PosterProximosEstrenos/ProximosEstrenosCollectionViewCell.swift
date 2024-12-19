//
//  ProximosEstrenosCollectionViewCell.swift
//  SkullCinema
//
//  Created by Brandon Garcia Sanchez on 05/12/2024.
//

import UIKit

class ProximosEstrenosCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageIV: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    
    func setupCell(_ movie: Movie) {
        imageIV.image = movie.image
        titleLabel.text = movie.title
        directorLabel.text = movie.director
    }
    
}
