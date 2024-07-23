//
//  MovieTableViewCell.swift
//  MovieDB
//
//  Created by Ерош Айтжанов on 21.06.2024.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    lazy var movieImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    lazy var movieTitle: UILabel = {
        let title = UILabel()
        title.textAlignment = .center
        title.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    lazy var stackView:UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        
        return stack
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
        stackView.addArrangedSubview(movieTitle)
        
//        NSLayoutConstraint.activate([
//            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
//            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
//            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
//            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
//            movieImage.heightAnchor.constraint(equalToConstant: 460)
//            
//        
//        ])
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(33)
        }
        movieImage.snp.makeConstraints { make in
            make.height.equalTo(460)
        }
        
    }
    
}
