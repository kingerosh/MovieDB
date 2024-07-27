//
//  FavoriteViewController.swift
//  MovieDB
//
//  Created by Ерош Айтжанов on 27.07.2024.
//

import UIKit

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
        table.register(MovieTableViewCell.self, forCellReuseIdentifier: "movie")
        return table
    }()
    
    var movieData:[Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        
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
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }


}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movieData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
