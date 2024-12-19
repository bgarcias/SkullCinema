//
//  ExtensionInt.swift
//  SkullCinema
//
//  Created by Brandon Garcia Sanchez on 04/12/2024.
//

import Foundation
extension Int {
    func formatSingleDigitNumber() -> String {
        self < 10 ? "0\(self)" : "\(self)"
    }
}
