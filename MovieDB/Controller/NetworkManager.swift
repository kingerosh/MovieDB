//
//  NetworkManager.swift
//  MovieDB
//
//  Created by Ерош Айтжанов on 22.07.2024.
//

//
//  NetworkManager.swift
//  MovieDB
//
//  Created by adminIL on 02.07.2024.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private lazy var urlComponent:URLComponents = {
        var component = URLComponents()
        component.host = "api.themoviedb.org"
        component.scheme = "https"
        component.queryItems = [
            URLQueryItem(name: "api_key", value: "d351d913d674bd98da28dea154905f25")
        ]
        
        return component
    }()
    private let urlImage:String = "https://image.tmdb.org/t/p/w500/"
    
    func loadMovie(theme:theme, complition: @escaping ([Result]) -> Void) {
        urlComponent.path = "/3/movie/\(theme.rawValue)"
        guard let url = urlComponent.url else {return}
        let session = URLSession(configuration: .default)
        DispatchQueue.global().async {
            let task = session.dataTask(with: url) { data,response,error in
                guard let data = data else {return}
                if let movie = try? JSONDecoder().decode(Movie.self, from: data) {
                    DispatchQueue.main.async {
                        complition(movie.results)
                    }
                }
             
                
            }
            task.resume()
        }
    }
    
    func loadMovieDetail(movieID:Int, complition: @escaping (MovieDetail)->Void)
    {
        urlComponent.path = "/3/movie/\(movieID)"
        guard let url = urlComponent.url else {return}
        AF.request(url).responseDecodable(of: MovieDetail.self) { result in
            if let movie = try? result.result.get() {
                DispatchQueue.main.async {
                    complition(movie)
                }
            }
        }
        
        
    }

    func loadImage(posterPath:String, complition: @escaping (Data)-> Void) {
        guard let url = URL(string: urlImage+posterPath) else {return}
        AF.request(url).response { data in
            guard let result = data.data else {return}
            DispatchQueue.main.async {
                complition(result)
            }
        }
    }
}
