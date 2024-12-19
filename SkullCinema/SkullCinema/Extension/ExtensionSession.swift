//
//  ExtensionSession.swift
//  SkullCinema
//
//  Created by Brandon Garcia Sanchez on 04/12/2024.
//

import Foundation

extension Session {
    func toString() -> String {
        return "\(self.day) \(self.month) - \(self.time)"
    }
}
