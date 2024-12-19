//
//  BienvenidaCollectionViewCell.swift
//  SkullCinema
//
//  Created by Brandon Garcia Sanchez on 04/12/2024.
//

import UIKit

class BienvenidaCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var ImageIV: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    
    func setupCell(_ slide: OnboardingSlide) {
        ImageIV.image = slide.image
        titleLabel.text = slide.title
        textLabel.text = slide.text
    }
}
