//
//  PeliculaPosterCollectionViewCell.swift
//  SkullCinema
//
//  Created by Brandon Garcia Sanchez on 05/12/2024.
//

import UIKit

class PeliculaPosterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageIV: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var starsView: UIView!
    @IBOutlet weak var star0IV: UIImageView!
    @IBOutlet weak var star1IV: UIImageView!
    @IBOutlet weak var star2IV: UIImageView!
    @IBOutlet weak var star3IV: UIImageView!
    @IBOutlet weak var star4IV: UIImageView!
    
    func setupCell(_ movie: Movie) {
        imageIV.image = movie.image
        titleLabel.text = movie.title
        setStars(movie.star)
    }
    
    func setStars(_ star: Int) {
        for i in 0..<star {
            let keyPath = "star\(i)IV"
            if let imageView = self.value(forKey: keyPath) as? UIImageView {
                let image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate)
                imageView.image = image
                imageView.tintColor = .systemYellow
            }
        }
    }
    
}
