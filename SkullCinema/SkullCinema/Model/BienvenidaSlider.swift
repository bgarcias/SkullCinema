//
//  BienvenidaSlider.swift
//  SkullCinema
//
//  Created by Brandon Garcia Sanchez on 04/12/2024.
//

import Foundation
import UIKit

struct OnboardingSlide{
    var image: UIImage?
    var title: String
    var text: String
    
    init(image imageName: String, title: String, text: String) {
        self.image = UIImage(named: imageName)
        self.title = title
        self.text = text
    }
}
