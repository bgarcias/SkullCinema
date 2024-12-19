//
//  ExtensionString.swift
//  SkullCinema
//
//  Created by Brandon Garcia Sanchez on 04/12/2024.
//

import Foundation

extension String {
    func toDate()->Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.date(from: self)!
    }
}
