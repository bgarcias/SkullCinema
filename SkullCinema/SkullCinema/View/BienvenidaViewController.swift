//
//  BienvenidaViewController.swift
//  SkullCinema
//
//  Created by Brandon Garcia Sanchez on 04/12/2024.
//

import UIKit

class BienvenidaViewController: UIViewController {
    
    @IBOutlet weak private var slidesCV: UICollectionView!
    @IBOutlet weak private var pageControl: UIPageControl!
    @IBOutlet weak private var btnNext: UIButton!
    @IBOutlet weak private var btnSkip: UIButton!
    
    private var slides: [OnboardingSlide] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSlides()
        slidesCV.setup("BienvenidaCollectionViewCell", BienvenidaFlowLayout())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func loadSlides() {
        let slide0 = OnboardingSlide(image: "Bienvenida0", title: "Horarios de Función", text: "El horario de la función indica el inicio de proyección de publicidad y avances de los próximos estrenos. Luego de éstos, comenzará la película. ¡Planifica tu tiempo y no te pierdas nada!")
        let slide1 = OnboardingSlide(image: "Bienvenida1", title: "QR desde tu Celular", text: "Muestra tu código QR directamente desde tu celular al ingresar al cine. No necesitas imprimir nada. ¡Disfruta de una experiencia sin papel y más rápida!.")
        let slide2 = OnboardingSlide(image: "Bienvenida2", title: "¡Sin Colas!", text: "Olvídate de las largas filas. Dirígete directamente a la sala de cine para disfrutar de tu película. No necesitas pasar por boletería, ¡todo es más rápido y cómodo!.")
        slides.append(contentsOf: [slide0, slide1, slide2])
    }
    
    private func setButtonAttributes(isLastPage: Bool) {
        let buttonTitle = isLastPage ? "  Saltar  " : "Siguiente"
        btnNext.setAttributedTitle(NSAttributedString(string: buttonTitle, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: .bold)]), for: .normal)
        btnSkip.isHidden = isLastPage
    }
    
    private func moveSlide(_ index: Int) {
        let pageIndexPath = IndexPath(item: index, section: 0)
        slidesCV.isPagingEnabled = false
        slidesCV.scrollToItem(at: pageIndexPath, at: .centeredHorizontally, animated: true)
        slidesCV.isPagingEnabled = true
    }
    
    private func goToHomeView() {
        performSegue(withIdentifier: "homeSegue", sender: self)
    }
    
    
    @IBAction private func pageControl_ValueChanged(_ sender: Any) {
        let pageIndex = pageControl.currentPage
        moveSlide(pageIndex)
    }
    
    @IBAction private func btnNext_TUI(_ sender: Any) {
        let pageIndex = pageControl.currentPage
        guard pageIndex < 2 else {
            goToHomeView()
            return
        }
        moveSlide(pageIndex + 1)
    }
    
    @IBAction private func btnSkip_TUI(_ sender: Any) {
        goToHomeView()
    }

}

extension BienvenidaViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BienvenidaCollectionViewCell", for: indexPath) as! BienvenidaCollectionViewCell
        let slide = slides[indexPath.row]
        cell.setupCell(slide)
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = slidesCV.bounds.width
        let currentPage = Int((scrollView.contentOffset.x + pageWidth / 2) / pageWidth)
        if pageControl.currentPage != currentPage {
            setButtonAttributes(isLastPage: currentPage == slides.count - 1)
        }
        pageControl.currentPage = currentPage
    }

}
