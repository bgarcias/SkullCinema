//
//  SesionCollectionViewCell.swift
//  SkullCinema
//
//  Created by Brandon Garcia Sanchez on 05/12/2024.
//

import UIKit

class SesionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backgroundUIView: UIView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    
    func setupCell(session: Session,selected selectedCell: Bool) {
        let bgColor: UIColor = selectedCell ? UIColor(named: "PrimaryColor") ?? UIColor.black : UIColor.white
        let textColor: UIColor = selectedCell ? UIColor.white : UIColor.black
        backgroundUIView.backgroundColor = bgColor
        monthLabel.textColor = textColor
        dayLabel.textColor = textColor
        monthLabel.text = session.month
        dayLabel.text = session.day
        
        // Convertir el mes a español
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "es_ES") // Idioma español
        dateFormatter.dateFormat = "MMM" // Formato del mes abreviado
            
        let date = session.date // Asegúrate de que `session.date` sea un tipo `Date`
        monthLabel.text = dateFormatter.string(from: date).capitalized // Ejemplo: "Dic"
        dayLabel.text = "\(Calendar.current.component(.day, from: date))" // Día del mes

    }
    
    
}
