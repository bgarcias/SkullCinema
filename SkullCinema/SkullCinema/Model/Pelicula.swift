//
//  Pelicula.swift
//  SkullCinema
//
//  Created by Brandon Garcia Sanchez on 04/12/2024.
//

import Foundation
import UIKit

enum Genero: String {
    case Acción
    case Comedia
    case Drama
    case Fantasia
    case Terror
    case Misterio
    case Romance
    case Criminal
    case CienciaFicción = "Ciencia-Ficción"
    case Musical
    case Biográfica
    case Histórica
    case Aventura
    case Animada
}

enum ContentRating: String {
    case APT = "Apta para todos"
    case MAS14 = "+14"
    case MAS18 = "+18"
}

struct Movie {
    var image: UIImage
    var title: String
    var filmReview: String
    var releaseDate: Date
    var duration: Int
    var genres: [Genero]
    var contentRating: ContentRating
    var director: String
    var cast: [String]
    var star: Int
    
    init(
        image imageAssetName: String,
        title: String,
        filmReview: String,
        releaseDate: Date,
        duration: Int,
        genres: [Genero],
        contentRating: ContentRating,
        director: String,
        cast: [String],
        star: Int
    ) {
        self.image = UIImage(named: imageAssetName) ?? UIImage(systemName: "photo")!
        self.title = title
        self.filmReview = filmReview
        self.releaseDate = releaseDate
        self.duration = duration
        self.genres = genres
        self.contentRating = contentRating
        self.director = director
        self.cast = cast
        self.star = star
    }
    
    func isIdentical(_ other: Movie) -> Bool {
        return title == other.title && releaseDate.isSameDate(other.releaseDate) && director == other.director
    }
    
    func durationString() -> String {
        let hour: Int = Int(floor(Double(duration) / 60))
        let minute: Int = duration - hour * 60
        let hourStr = hour > 1 ? "Horas" : "Hora"
        return "\(hour) \(hourStr) \(minute > 0 ? "\(minute) Minutos" : "")"
    }
    
    func releaseDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: releaseDate)
    }
    
    func genresString() -> String {
        var first3Genres: [String] = []
        for i in 0..<(genres.count > 2 ? 3 : genres.count) {
            first3Genres.append(genres[i].rawValue)
        }
        return first3Genres.joined(separator: ", ")
    }
    
    func castList() -> NSAttributedString {
        let castString = NSAttributedString(string: "Reparto: ", attributes: [.font: UIFont.systemFont(ofSize: 17, weight: .medium)])
        let list = NSAttributedString(string: cast.joined(separator: ", "), attributes: [.font: UIFont.systemFont(ofSize: 17)])
        let castList = NSMutableAttributedString()
        castList.append(castString)
        castList.append(list)
        return castList
    }
}

