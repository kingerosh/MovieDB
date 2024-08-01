//
//  FavoriteViewController.swift
//  MovieDB
//
//  Created by Ерош Айтжанов on 27.07.2024.
//

import UIKit
import CoreData

class FavoriteViewController: UIViewController {
    
    lazy var movieLabel: UILabel = {
        let label = UILabel()
        label.text = "Favorites"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var movieTableView: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.dataSource = self
        table.delegate = self
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(MovieTableViewCell.self, forCellReuseIdentifier: "favorite")
        return table
    }()
    
    var movieData:[Result] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadFromCoreData()
        movieTableView.reloadData()
    }
    
    func setupUI() {
        view.addSubview(movieLabel)
        view.addSubview(movieTableView)
        movieLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(15)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
        }
        movieTableView.snp.makeConstraints { make in
            make.top.equalTo(movieLabel.snp.bottom).offset(15)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    func loadFromCoreData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.persistantContainer.viewContext
        let fetch: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Favorite")
        do {
            let result = try context.fetch(fetch)
            var movies:[Result] = []
            for data in result as! [NSManagedObject] {
                let movieID = data.value(forKey: "movieID") as! Int
                let title = data.value(forKey: "title") as! String
                let posterPath = data.value(forKey: "posterPath") as! String
                let movie = Result(id: movieID, posterPath: posterPath, title: title)
                movies.append(movie)
            }
            movieData = movies
            
        }
        catch {
            print("error loadCoreData")
        }
    }


}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movieData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = movieTableView.dequeueReusableCell(withIdentifier: "favorite", for: indexPath) as! MovieTableViewCell
        let movie = movieData[indexPath.row]
        cell.conf(movie: movie)
        cell.method = { [weak self] in
            self!.loadFromCoreData()
            self!.movieTableView.reloadData()
        }
        
        return cell
    }

    
}
