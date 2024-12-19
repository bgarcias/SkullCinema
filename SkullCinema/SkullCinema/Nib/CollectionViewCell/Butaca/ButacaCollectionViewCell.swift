//
//  ButacaCollectionViewCell.swift
//  SkullCinema
//
//  Created by Brandon Garcia Sanchez on 05/12/2024.
//

import UIKit

class ButacaCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageIV: UIImageView!
    
    func setupCell(_ seat: Seat) {
        // Configurar el nombre del icono según el estado del asiento
        let imageName = seat.sold || seat.selected ? "circle.fill" : "circle"
        imageIV.image = UIImage(systemName: imageName)
        
        // Configurar el color del asiento según su estado
        if seat.sold {
            // Rojo para ocupado
            imageIV.tintColor = UIColor.red
        } else if seat.selected {
            // Negro sólido para seleccionado
            imageIV.tintColor = UIColor.black
        } else {
            // Blanco sin relleno para disponible
            imageIV.tintColor = UIColor.black // Mantener contorno negro
            imageIV.backgroundColor = UIColor.clear // Fondo transparente
        }
    }
    
}
