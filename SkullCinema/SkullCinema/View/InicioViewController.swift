//
//  InicioViewController.swift
//  SkullCinema
//
//  Created by Brandon Garcia Sanchez on 04/12/2024.
//

import UIKit
import FirebaseAuth

class InicioViewController: UIViewController {
    
    @IBOutlet weak private var moviesHeader: MovieSlideHeader!
    @IBOutlet weak private var moviesCV: UICollectionView!
    @IBOutlet weak private var upcomingMoviesHeader: MovieSlideHeader!
    @IBOutlet weak private var upcomingMoviesCV: UICollectionView!
    
    private var movies: [Movie] = []
    private var upcomingMovies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMovies()
        loadUpcomingMovies()
        setupCollectionViews()
        configureReusableViewHeaders()
        func getUser(){
            let _ = Auth.auth().currentUser?.email
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        // Verificar si hay un usuario autenticado
        if Auth.auth().currentUser == nil {
            redirectToLogin()
        }
    }
    
    private func redirectToLogin() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        
        let navController = UINavigationController(rootViewController: loginVC)
        navController.modalPresentationStyle = .fullScreen
        
        self.present(navController, animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    private func loadMovies() {
        movies = [
            Movie(
                image: "CodigoTrajeRojo",
                title: "Codigo: Traje Rojo",
                filmReview: "Tras el secuestro de Papá Noel, nombre en clave: RED ONE, el Jefe de Seguridad del Polo Norte (Dwayne Johnson) debe formar equipo con el cazarrecompensas más infame del mundo (Chris Evans) en una misión trotamundos llena de acción para salvar la Navidad.",
                releaseDate: "15/11/2024".toDate(),
                duration: 123,
                genres: [Genero.Acción, Genero.Aventura],
                contentRating: ContentRating.APT,
                director: "Jake Kasdan",
                cast: ["Dwayne Johnson", "Chris Evans", "Lucy Liu"],
                star: 4
            ), Movie(
                image: "Eltiempoquetenemos",
                title: "El tiempo que tenemos",
                filmReview: "Almut y Tobias tienen un encuentro inesperado que cambiará sus vidas para siempre. A través de momentos de su vida juntos se revela una verdad difícil que sacude los cimientos de su relación. Mientras emprenden un camino desafiante, aprenden a apreciar cada momento del recorrido inusual que ha tomado su historia de amor.",
                releaseDate: "31/10/2024".toDate(),
                duration: 107,
                genres: [Genero.Romance, Genero.Drama, Genero.Comedia],
                contentRating: ContentRating.MAS14,
                director: "John Crowley",
                cast: ["Andrew Garfield", "Florence Pugh", "Marama Corlett"],
                star: 3
            ), Movie(
                image: "GladiadorII",
                title: "Gladiador II",
                filmReview: "Dieciséis años después de la muerte de Marco Aurelio, Roma está gobernada por los despiadados emperadores gemelos Geta y Caracalla. El nieto de Aurelio, Lucio Vero, vive bajo el seudónimo de Hanno con su esposa Arishat en el reino norteafricano de Numidia.",
                releaseDate: "15/11/2024".toDate(),
                duration: 148,
                genres: [Genero.Acción, Genero.Aventura, Genero.Histórica],
                contentRating: ContentRating.MAS18,
                director: "Ridley Scott",
                cast: ["Paul Mescal", "Denzel Washington", "Pedro Pascal"],
                star: 4
            ), Movie(
                image: "Moana2",
                title: "Moana 2",
                filmReview: "Después de recibir una llamada inesperada de sus antepasados ​​​​orientadores, Moana debe viajar a los mares lejanos de Oceanía y a aguas peligrosas y perdidas hace mucho tiempo para vivir una aventura diferente a todo lo que ha enfrentado antes.",
                releaseDate: "27/11/2024".toDate(),
                duration: 100,
                genres: [Genero.Animada, Genero.Aventura, Genero.Musical],
                contentRating: ContentRating.APT,
                director: "Dana Ledoux Miller",
                cast: ["Dwayne Johnson", "Auli'i Cravalho", "Nicole Scherzinger"],
                star: 5
            ), Movie(
                image: "RobotSalvaje",
                title: "Robot Salvaje",
                filmReview: "Esta aventura épica cuenta la historia de una robot, Rozzum 7-1-3-4, Roz para abreviar, que naufraga en una isla inhabitada y debe aprender a adaptarse a los entornos rigurosos construyendo relaciones con los animales de la isla y convirtiéndose en la madre adoptiva de una cría de ganso huérfana.",
                releaseDate: "27/10/2024".toDate(),
                duration: 101,
                genres: [Genero.Animada, Genero.Aventura],
                contentRating: ContentRating.APT,
                director: "Chris Sanders",
                cast: ["Kit Connor", "Pedro Pascal", "Bill Nighy"],
                star: 4
            ), Movie(
                image: "VenomElultimobaile",
                title: "Venom: El último baile",
                filmReview: "Eddie y Venom están a la fuga. Perseguidos por sus sendos mundos y cada vez más cercados, el dúo se ve abocado a tomar una decisión devastadora que hará que caiga el telón sobre el último baile de Venom y Eddie.",
                releaseDate: "24/11/2024".toDate(),
                duration: 109,
                genres: [Genero.Acción, Genero.Aventura, Genero.Comedia],
                contentRating: ContentRating.MAS14,
                director: "Kelly Marcel",
                cast: ["Tom Hardy", "Juno Temple", "Chiwetel Ejiofor"],
                star: 4
            ), Movie(
                image: "Wicked",
                title: "Wicked",
                filmReview: "Ambientada en la Tierra de Oz, mucho antes de la llegada de Dorothy Gale desde Kansas. Elphaba es una joven incomprendida por su inusual color verde que aún no ha descubierto su verdadero poder. Glinda es una popular joven marcada por sus privilegios y su ambición que aún no ha descubierto su verdadera pasión.",
                releaseDate: "22/11/2024".toDate(),
                duration: 160,
                genres: [Genero.Musical, Genero.Aventura, Genero.Drama],
                contentRating: ContentRating.APT,
                director: "Jon M. Chu",
                cast: ["Ariana Grande", "Cynthia Erivo", "Jeff Goldblum"],
                star: 3
            ),
        ]
    }
    
    private func loadUpcomingMovies() {
        upcomingMovies = [
            Movie(
                image: "KravenElCazador",
                title: "Kraven El Cazador",
                filmReview: "El inmigrante ruso Sergei Kravinoff emprende una misión para demostrar que es el mejor cazador del mundo.",
                releaseDate: "23/12/2024".toDate(),
                duration: 127,
                genres: [Genero.Acción, Genero.CienciaFicción],
                contentRating: ContentRating.MAS14,
                director: "J. C. Chandor",
                cast: ["Aaron Taylor-Johnson", "Russell Crowe", "Ariana DeBose"],
                star: 4
            ), Movie(
                image: "Sonic3",
                title: "Sonic 3",
                filmReview: "El filme sigue, de nuevo, las aventuras del famoso erizo de Sega y su nuevo amigo y compañero Tails. Una vez más, el terrible Robotnik tiene siniestros planes para poner en peligro a toda la humanidad y el héroe de color azul tiene que ponerse manos a la obra para salvar la Tierra y a sus amigos.",
                releaseDate: "20/12/2024".toDate(),
                duration: 109,
                genres: [Genero.Animada, Genero.Acción ],
                contentRating: ContentRating.APT,
                director: "Jeff Fowler",
                cast: ["Ben Schwartz", "Idris Elba", "Keanu Reeves"],
                star: 3
            ), Movie(
                image: "PaddingtonenPeru",
                title: "Paddington en Perú",
                filmReview: "Cuando Paddington descubre que su amada Tía Lucy desapareció de la Casa para Osos Retirados, la familia Brown y él se dirigen a la selva de Perú a buscarla; la única pista de su ubicación es un lugar marcado en un enigmático mapa.",
                releaseDate: "16/01/2025".toDate(),
                duration: 98,
                genres: [Genero.Comedia, Genero.Animada, Genero.Aventura],
                contentRating: ContentRating.APT,
                director: "Dougal Wilsone",
                cast: ["Antonio Banderas", "Ben Whishaw", "Carlos Carlín"],
                star: 5
            ), Movie(
                image: "MufasaElReyLeon",
                title: "Mufasa: El Rey León",
                filmReview: "Cuenta con Rafiki como el encargado de transmitir la leyenda de Mufasa a la joven cachorra de león Kiara, hija de Simba y Nala, con Timón y Pumba aportando sus característicos trucos. Narrada con flashbacks, la historia presenta a Mufasa como un cachorro huérfano, perdido y solo hasta que conoce a un simpático león llamado Taka",
                releaseDate: "20/12/2024".toDate(),
                duration: 120,
                genres: [Genero.Animada, Genero.Musical, Genero.Aventura],
                contentRating: ContentRating.APT,
                director: "Barry Jenkins",
                cast: ["Beyoncé", "Blue Ivy", "Donald Glover"],
                star: 3
            ), Movie(
                image: "SoloLevelingSegundoDespertar",
                title: "Solo Leveling: Segundo Despertar",
                filmReview: "Cuando aparecieran portales que conectan mundos paralelos y otorgan poderes sobrenaturales a algunos humanos llamados Cazadores, el más débil, Sung Jinwoo, tropieza con una rara mazmorra que le permite fortalecerse, cambiando su destino.",
                releaseDate: "25/12/2024".toDate(),
                duration: 120,
                genres: [Genero.Animada, Genero.Fantasia, Genero.Animada],
                contentRating: ContentRating.MAS14,
                director: "Shunsuke Nakashige",
                cast: ["Taito Ban", "Reina Ueda", "Genta Nakamura"],
                star: 5
            ),
        ]
    }
    
    private func setupCollectionViews() {
        moviesCV.setup("PeliculaPosterCollectionViewCell", PeliculaPosterFlowLayout())
        upcomingMoviesCV.setup("ProximosEstrenosCollectionViewCell", PeliculaPosterFlowLayout(bottomHeight: 35, imageAspectRatio: 1))
    }
    
    private func configureReusableViewHeaders() {
        moviesHeader.configureView(title: "En Cartelera", onPressed: {self.goToMovies()})
        upcomingMoviesHeader.configureView(title: "Próximos Estrenos", onPressed: {self.goToMovies(ShowType.Upcoming)})
    }
    
    private func goToMovies(_ showType: ShowType = ShowType.NowShowing) {
        let moviesVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "PeliculasViewController") as! PeliculasViewController
        moviesVC.showType = showType
        moviesVC.movies = movies
        moviesVC.upcomingMovies = upcomingMovies
        navigationController?.pushViewController(moviesVC, animated: true)
    }
    
    
    func logOut() {
        do {
            try Auth.auth().signOut() // Cerrar sesión en Firebase
            redirectToLogin()
        } catch let error {
            print("Error al cerrar sesión: \(error.localizedDescription)")
        }
    }
    
    @IBAction func logOut(_ sender: UIButton) {
        logOut()
    }
    
    
}

extension InicioViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { collectionView == moviesCV ? movies.count : upcomingMovies.count }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let upcomingMovie: Bool = collectionView == upcomingMoviesCV
        let movie: Movie = upcomingMovie ? upcomingMovies[indexPath.row] : movies[indexPath.row]
        if upcomingMovie {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProximosEstrenosCollectionViewCell", for: indexPath) as! ProximosEstrenosCollectionViewCell
            cell.setupCell(movie)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PeliculaPosterCollectionViewCell", for: indexPath) as! PeliculaPosterCollectionViewCell
            cell.setupCell(movie)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = collectionView == moviesCV ? movies[indexPath.row] : upcomingMovies[indexPath.row]
        let movieDetailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PeliculasDetalleViewController") as! PeliculasDetalleViewController
        movieDetailVC.movie = movie
        navigationController?.pushViewController(movieDetailVC, animated: true)
    }
    
}
