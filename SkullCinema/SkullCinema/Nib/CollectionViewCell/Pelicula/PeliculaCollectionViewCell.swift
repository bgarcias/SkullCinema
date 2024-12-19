//
//  PeliculaCollectionViewCell.swift
//  SkullCinema
//
//  Created by Brandon Garcia Sanchez on 05/12/2024.
//

import UIKit

class PeliculaCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageIV: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    func setupCell(_ movie: Movie, showReleaseDate: Bool) {
        imageIV.image = movie.image
        titleLabel.text = movie.title
        genresLabel.text = movie.genresString()
        durationLabel.isHidden = showReleaseDate
        dateView.isHidden = !showReleaseDate
        if showReleaseDate {
            releaseDateLabel.text = movie.releaseDateString()
        } else {
            durationLabel.text = movie.durationString()
        }
    }
    
    
}
