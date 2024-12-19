//
//  TicketViewController.swift
//  SkullCinema
//
//  Created by Brandon Garcia Sanchez on 04/12/2024.
//

import UIKit

class TicketViewController: UIViewController {

    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var seatsLabel: UILabel!
    @IBOutlet weak private var dateLabel: UILabel!
    @IBOutlet weak private var timeLabel: UILabel!
    @IBOutlet weak private var priceLabel: UILabel!
    
    var ticket: Ticket?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillTicket()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func fillTicket() {
        guard let ticket = ticket else { return }
        titleLabel.text = ticket.movie.title
        seatsLabel.text = ticket.seatCodes()
        dateLabel.text = ticket.session.date.toString()
        timeLabel.text = ticket.session.time
        priceLabel.text = String(format: "%.2f", ticket.price)
    }
    
    @IBAction func btnGoHome_TUI(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    

}
