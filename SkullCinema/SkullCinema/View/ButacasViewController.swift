//
//  ButacasViewController.swift
//  SkullCinema
//
//  Created by Brandon Garcia Sanchez on 04/12/2024.
//

import UIKit

class ButacasViewController: UIViewController {
    
    @IBOutlet weak private var seatsCV: UICollectionView!
    @IBOutlet weak private var sessionLabel: UILabel!
    @IBOutlet weak private var selectedSeatsLabel: UILabel!
    @IBOutlet weak private var priceLabel: UILabel!
    @IBOutlet weak private var ticketsLabel: UILabel!
    
    var movie: Movie?
    var session: Session?
    private var seats: [Seat] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        createSeats()
        sessionLabel.text = session?.toString()
        seatsCV.setup("ButacaCollectionViewCell", ButacaFlowLayout())
    }
    
    private func createSeats() {
        guard let movie = movie, let session = session else { return }
        let soldSeats: [Seat] = Ticket.soldSeats(movie: movie, session: session)
        for section in 0..<9 {
            let sectionLength = section == 0 ? 5 : section == 1 ? 7 : 9
            for row in 0..<sectionLength {
                var seat = Seat(section, row)
                if soldSeats.contains(where: { soldSeat in soldSeat.isIdentical(seat) }) {
                    seat.sold = true
                }
                seats.append(seat)
            }
        }
    }
    
    private func selectedSeats() -> [Seat] { seats.filter({ $0.selected }) }
    
    private func selectedSeatsCount() -> Int { selectedSeats().count }
    
    private func selectedSeatsCodes() -> String {
        let selectedSeatCodes = selectedSeats().map({seat in seat.seatCode })
        return selectedSeatCodes.joined(separator: ", ")
    }
    
    private func calculateTotalPrice() -> Double { Double(selectedSeatsCount()) * 20.0 }
        
    private func seatIndexOf(_ indexPath: IndexPath)-> Int {
        let section = indexPath.section
        let row = indexPath.row
        let difference = section > 1 ? 6 : section > 0 ? 4 : 0
        return (section) * 9 + row - difference
    }
    
    private func seatOnTap(_ index: Int) {
        guard seats[index].sold != true else { return }
        let isSelected = seats[index].selected
        guard selectedSeatsCount() < 5 || isSelected else {
            self.showToast("No puedes reservar más de 10 entradas")
            return
        }
        seats[index].selected = !isSelected
        seatsCV.reloadData()
        ticketsLabel.text = String(selectedSeatsCount())
        selectedSeatsLabel.text = selectedSeatsCodes()
        priceLabel.text = String(format: " %.2f", calculateTotalPrice())
    }
    
    
    @IBAction func btnBuyTickets_TUI(_ sender: Any) {
        guard selectedSeatsCount() > 0 else {
            self.showToast("Por favor, escoge al menos una butaca.")
            return
        }
        
        // Crear el UIAlertController
        let alertController = UIAlertController(
            title: "Confirmación",
            message: "¿Estás seguro que deseas reservar los asientos seleccionados?",
            preferredStyle: .alert
        )
        
        // Agregar acción "Sí"
        let confirmAction = UIAlertAction(title: "Sí", style: .default) { _ in
            // Código para continuar con la siguiente vista
            let ticketVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TicketViewController") as! TicketViewController
            let ticket = Ticket(movie: self.movie!, session: self.session!, seats: self.selectedSeats(), price: self.calculateTotalPrice())
            ticketVC.ticket = ticket
            self.navigationController?.pushViewController(ticketVC, animated: true)
        }
        
        // Agregar acción "No"
        let cancelAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        
        // Añadir las acciones al UIAlertController
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        // Presentar el UIAlertController
        self.present(alertController, animated: true, completion: nil)
    }


}

extension ButacasViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int { 9 }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return seats.filter({seat in seat.section == section }).count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ButacaCollectionViewCell", for: indexPath) as! ButacaCollectionViewCell
        let seat: Seat = seats[seatIndexOf(indexPath)]
        cell.setupCell(seat)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        seatOnTap(seatIndexOf(indexPath))
    }
}
