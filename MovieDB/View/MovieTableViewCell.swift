//
//  MovieTableViewCell.swift
//  MovieDB
//
//  Created by Ерош Айтжанов on 21.06.2024.
//

import UIKit
import SnapKit
import CoreData

class MovieTableViewCell: UITableViewCell {

    private lazy var movieImage:UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 30
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var movieTitle:UILabel = {
       let title = UILabel()
        title.textAlignment = .center
        title.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private lazy var stackView:UIStackView = {
       let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 15
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var favoriteImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "heart")
        return image
    }()
    
    private var isFavorite: Bool = false {
        
        didSet {
            favoriteImage.image = isFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        }
    }
    
    private var movie: Result?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func conf(movie: Result) {
        self.movie = movie
        NetworkManager.shared.loadImage(posterPath: movie.posterPath) { data in
            self.movieImage.image = UIImage(data: data)
        }
        movieTitle.text = movie.title
        loadFavorite(movie: movie)
    }
    
    func setupUI() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(movieImage)
        movieImage.addSubview(favoriteImage)
        stackView.addArrangedSubview(movieTitle)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        movieImage.snp.makeConstraints { make in
            make.height.equalTo(424)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide.snp.trailing).offset(-15)
            make.leading.equalToSuperview().offset(15)
        }
        favoriteImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
            make.height.equalTo(50)
            make.width.equalTo(60)
        }
        favoriteImage.isUserInteractionEnabled = true
        movieImage.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tap))
        favoriteImage.addGestureRecognizer(tap)
        
        
    }
    
    @objc func tap() {
        guard let movie else {return}
        if isFavorite {
            deleteFavorite(movie: movie)
        } else {
            saveFavorite(movie: movie)
        }
        
        isFavorite.toggle()
    }
    
    func saveFavorite(movie: Result) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.persistantContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "Favorite", in: context) else {return}
        let favorite = NSManagedObject(entity: entity, insertInto: context)
        favorite.setValue(movie.id, forKey: "movieID")
        favorite.setValue(movie.posterPath, forKey: "posterPath")
        favorite.setValue(movie.title, forKey: "title")
        do {
            try context.save()
        }
        catch {
            print("error save to CoreData")
        }
    }
    
    func deleteFavorite(movie: Result) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.persistantContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Favorite")
        fetchRequest.predicate = NSPredicate(format: "movieID == %d", movie.id)
        do {
            let result = try context.fetch(fetchRequest)
            if let objectDelete = result.first as? NSManagedObject {
                context.delete(objectDelete)
            }
            try context.save()
        } catch {
            print("error delete favorite")
        }
    }
    
    func loadFavorite(movie: Result) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.persistantContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Favorite")
        fetchRequest.predicate = NSPredicate(format: "movieID == %d", movie.id)
        do {
            let result = try context.fetch(fetchRequest)
            if !result.isEmpty {
                isFavorite = true
            } else {
                isFavorite = false
            }
        } catch {
            
        }
    }
    
    
}
