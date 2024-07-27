//
//  MovieTableViewCell.swift
//  MovieDB
//
//  Created by Ерош Айтжанов on 21.06.2024.
//

import UIKit
import SnapKit

class MovieTableViewCell: UITableViewCell {

    lazy var movieImage:UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 30
        image.clipsToBounds = true
        return image
    }()
    
    lazy var movieTitle:UILabel = {
       let title = UILabel()
        title.textAlignment = .center
        title.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    lazy var stackView:UIStackView = {
       let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 15
        stack.axis = .vertical
        return stack
    }()
    
    lazy var favoriteImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "heart")
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        
    }
}
