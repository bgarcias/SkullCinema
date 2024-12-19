//
//  PeliculasDetalleViewController.swift
//  SkullCinema
//
//  Created by Brandon Garcia Sanchez on 04/12/2024.
//

import UIKit

class PeliculasDetalleViewController: UIViewController {
    
    @IBOutlet weak private var imageIV: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var releaseDateLabel: UILabel!
    @IBOutlet weak private var genreLabel: UILabel!
    @IBOutlet weak private var filmReviewLabel: UILabel!
    @IBOutlet weak private var durationLabel: UILabel!
    @IBOutlet weak private var castLabel: UILabel!
    @IBOutlet weak private var contentRatingLabel: UILabel!
    @IBOutlet weak private var directorLabel: UILabel!
    
    
    var movie: Movie?
    private var pageTitle: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        pageTitle = self.title
        fillMovieInformation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = ""
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.title = pageTitle
    }
    
    private func fillMovieInformation() {
        guard let movie else { return }
        imageIV.image = movie.image
        titleLabel.text = movie.title
        releaseDateLabel.text = movie.releaseDateString()
        genreLabel.text = movie.genresString()
        durationLabel.text = movie.durationString()
        contentRatingLabel.text = movie.contentRating.rawValue
        filmReviewLabel.text = movie.filmReview
        directorLabel.text = movie.director
        castLabel.attributedText = movie.castList()
    }
    
    @IBAction func btnBookTickets_TUI(_ sender: Any) {
        guard let movie else { return }
        let reservationVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ReservaViewController") as! ReservaViewController
        reservationVC.movie = movie
        navigationController?.pushViewController(reservationVC, animated: true)
    }

}
