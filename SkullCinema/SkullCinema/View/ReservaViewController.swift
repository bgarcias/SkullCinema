//
//  ReservaViewController.swift
//  SkullCinema
//
//  Created by Brandon Garcia Sanchez on 04/12/2024.
//

import UIKit

class ReservaViewController: UIViewController {
    
    @IBOutlet weak private var imageIV: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var durationLabel: UILabel!
    @IBOutlet weak private var contentRatingLabel: UILabel!
    @IBOutlet weak private var genreLabel: UILabel!
    @IBOutlet weak private var sessionDaysCV: UICollectionView!
    
    
    var movie: Movie?
    private var sessionDays: [Session] = []
    private var selectedSession: Session?
    private var sessionTimes: [String] = []
    private var selectedTime: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        initDays()
        initTimes()
        fillMovieInfo()
        sessionDaysCV.setup("SesionCollectionViewCell", SesionFlowLayout())
    }
    
    private func initDays() {
        let today = Date()
        for i in 0..<10 {
            let date = today.futureDate(daysToAdd: i)
            let day: Session = Session(date: date)
            sessionDays.append(day)
        }
        selectedSession = sessionDays.first
    }
    
    private func initTimes(endHour: Int = 22) {
        sessionTimes = []
        
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a" // Formato de 12 horas con AM/PM
        
        let now = Date()
        let components = Calendar.current.dateComponents([.hour, .minute], from: now)
        var currentHour = components.hour ?? 0
        var currentMinute = components.minute ?? 0
        
        // Redondear al siguiente intervalo de 30 minutos
        if currentMinute > 0 && currentMinute < 30 {
            currentMinute = 30
        } else if currentMinute >= 30 {
            currentMinute = 0
            currentHour += 1
        }
        
        // Generar horarios desde la hora redondeada actual hasta el fin del horario
        while currentHour < endHour {
            if let fullHourDate = createDate(hour: currentHour, minute: currentMinute) {
                sessionTimes.append(formatter.string(from: fullHourDate)) // Ejemplo: 12:30 PM
            }
            
            // Incrementar por intervalos de 30 minutos
            if currentMinute == 0 {
                currentMinute = 30
            } else {
                currentMinute = 0
                currentHour += 1
            }
        }
    }

    
    // Función auxiliar para crear fechas
    private func createDate(hour: Int, minute: Int) -> Date? {
        var components = DateComponents()
        components.hour = hour
        components.minute = minute
        return Calendar.current.date(from: components)
    }
    
    private func fillMovieInfo() {
        guard let movie = movie else { return }
        imageIV.image = movie.image
        titleLabel.text = movie.title
        durationLabel.text = movie.durationString()
        contentRatingLabel.text = movie.contentRating.rawValue
        genreLabel.text = movie.genresString()
    }
    
    @IBAction func btnChooseSeats_TUI(_ sender: Any) {
        guard let selectedTime = selectedTime else {
            self.showToast("Por favor, escoge una sesión")
            return
        }
        let seatsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ButacasViewController") as! ButacasViewController
        seatsVC.movie = movie
        selectedSession?.time = selectedTime
        seatsVC.session = selectedSession
        navigationController?.pushViewController(seatsVC, animated: true)
    }

}

extension ReservaViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sessionDays.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SesionCollectionViewCell", for: indexPath) as! SesionCollectionViewCell
        let sessionDay = sessionDays[indexPath.row]
        cell.setupCell(session: sessionDay, selected: sessionDay.isIdentical(selectedSession))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedSession = sessionDays[indexPath.row]
        sessionDaysCV.reloadData()
    }
}

extension ReservaViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { sessionTimes.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TiempoSesionTableViewCell", owner: self)?.first as! TiempoSesionTableViewCell
        cell.setupCell(time: sessionTimes[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTime = sessionTimes[indexPath.row]
    }
}
