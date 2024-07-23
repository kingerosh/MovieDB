//
//  MovieDetailViewController.swift
//  MovieDB
//
//  Created by Ерош Айтжанов on 22.07.2024.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    private lazy var movieImage:UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var movieTitle:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 48, weight: .bold)
        return label
    }()
    
    var movieID = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        NetworkManager.shared.loadMovieDetail(movieID: movieID) {
            movie in
            self.movieTitle.text = movie.title
            NetworkManager.shared.loadImage(movie: movie) {
                image in
                self.movieImage.image = image
            }
        }
        
    }
    
    func setupUI() {
        view.addSubview(movieImage)
        view.addSubview(movieTitle)
        NSLayoutConstraint.activate([
            movieImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            movieImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            movieImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            movieTitle.topAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: 10),
            movieTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            movieTitle.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            movieImage.heightAnchor.constraint(equalToConstant: 460)
        ])
    }
    


}
