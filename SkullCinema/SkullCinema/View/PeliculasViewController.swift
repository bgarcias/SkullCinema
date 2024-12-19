//
//  PeliculasViewController.swift
//  SkullCinema
//
//  Created by Brandon Garcia Sanchez on 04/12/2024.
//

import UIKit


enum ShowType: Int {
    case NowShowing = 0
    case Upcoming = 1
}

class PeliculasViewController: UIViewController {

    @IBOutlet weak private var showTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak private var moviesCV: UICollectionView!
    
    // MARK: - Variables
    
    var movies: [Movie] = []
    var upcomingMovies: [Movie] = []
    var showType: ShowType = ShowType.NowShowing

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showTypeSegmentedControl.selectedSegmentIndex = showType.rawValue
        moviesCV.setup("PeliculaCollectionViewCell", PeliculaFlowLayout())
    }
        
    // MARK: - Actions
    
    @IBAction private func showTypeSegmentedControl_ValueChanged(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        showType = index == 0 ? ShowType.NowShowing : ShowType.Upcoming
        moviesCV.reloadData()
    }
}

extension PeliculasViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        showType == ShowType.NowShowing ? movies.count : upcomingMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PeliculaCollectionViewCell", for: indexPath) as! PeliculaCollectionViewCell
        let movie = showType == ShowType.NowShowing ? movies[indexPath.row] : upcomingMovies[indexPath.row]
        cell.setupCell(movie, showReleaseDate: showType == ShowType.Upcoming)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = showType == ShowType.NowShowing ? movies[indexPath.row] : upcomingMovies[indexPath.row]
        let vcMovieDetail = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PeliculasDetalleViewController") as! PeliculasDetalleViewController
        vcMovieDetail.movie = movie
        navigationController?.pushViewController(vcMovieDetail, animated: true)
    }
}
