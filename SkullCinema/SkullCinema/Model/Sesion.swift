//
//  Sesion.swift
//  SkullCinema
//
//  Created by Brandon Garcia Sanchez on 04/12/2024.
//

import Foundation

struct Session {
    var date: Date
    
    // ID único basado en fecha y hora
    var id: String {
        date.toString("dd/MM/yyyy HH:mm")
    }
    
    // Mes en español
    var month: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es_ES") // Configurar idioma a español
        formatter.dateFormat = "MMMM" // Formato para el mes
        return formatter.string(from: date).capitalized // Capitalizar (E.g., "dic")
    }
    
    // Día del mes
    var day: String {
        String(Calendar.current.component(.day, from: date))
    }
    
    // Hora de la sesión
    var time: String {
        get {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm" // Formato para la hora
            return formatter.string(from: date)
        }
        set {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy HH:mm"
            let newDate = formatter.date(from: "\(date.toString("dd/MM/yyyy")) \(newValue)")
            date = newDate ?? date
        }
    }
    
    // Verificar si dos sesiones son idénticas
    func isIdentical(_ session: Session?) -> Bool {
        id == session?.id
    }
    
    // Inicializador
    init(date: Date) {
        self.date = date
    }
}

