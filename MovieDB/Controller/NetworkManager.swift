//
//  NetworkManager.swift
//  MovieDB
//
//  Created by Ерош Айтжанов on 22.07.2024.
//

import Foundation
import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private lazy var urlComponent: URLComponents = {
        var component = URLComponents()
        component.host = "api.themoviedb.org"
        component.scheme = "https"
        component.queryItems = [
            URLQueryItem(name: "api_key", value: "e207c55a4c4607df5271e464e6c3af7e")
        ]
        return component
    }()
    
    func loadMovie(complition: @escaping ([Result]) -> Void) {
        
        urlComponent.path = "/3/movie/now_playing"
        guard let url = urlComponent.url else {return}
        let session = URLSession(configuration: .default)
        DispatchQueue.global().async {
            let task = session.dataTask(with: url) {
                data, response, error in
                guard let data = data else {return}
                if let movie = try? JSONDecoder().decode(Movie.self, from: data) {
                    DispatchQueue.main.async {
                        complition(movie.results)
                    }
                } else {print("error")}
                
                
            }
            task.resume()
        }
    }
    
    func loadMovieDetail(movieID: Int, complition: @escaping (MovieDetail) -> Void) {
        urlComponent.path = "/3/movie/\(movieID)"
        guard let url = urlComponent.url else {return}
        let session = URLSession(configuration: .default)
        DispatchQueue.global().async {
            session.dataTask(with: url) {
                data, response, error in
                guard let data else {return}
                guard let movie = try? JSONDecoder().decode(MovieDetail.self, from: data) else {return}
                DispatchQueue.main.async {
                    complition(movie)
                }
                
            }.resume()
        }
    }
    
    func loadImage(movie: MovieDetail, complition: @escaping (UIImage) -> Void) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/"+movie.posterPath) else {return}
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    complition(UIImage(data: data)!)
                }
                
            }
        }
    }
}
