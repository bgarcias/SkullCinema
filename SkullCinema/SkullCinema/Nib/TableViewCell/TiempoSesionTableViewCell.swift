//
//  TiempoSesionTableViewCell.swift
//  SkullCinema
//
//  Created by Brandon Garcia Sanchez on 05/12/2024.
//

import UIKit

class TiempoSesionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var selectedIV: UIImageView!
    
    func setupCell(time: String) {
        timeLabel.text = time
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectedIV.isHidden = !selected
        timeLabel.font = .systemFont(ofSize: 17, weight: selected ? .medium : .regular)
    }
}
