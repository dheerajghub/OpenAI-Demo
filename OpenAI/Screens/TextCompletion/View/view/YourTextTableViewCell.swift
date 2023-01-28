//
//  YourTextTableViewCell.swift
//  OpenAI
//
//  Created by Dheeraj Kumar Sharma on 28/01/23.
//

import UIKit

class YourTextTableViewCell: UITableViewCell {

    // MARK: PROPERTIES -
    
    let yourProfileView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .lightGray.withAlphaComponent(0.5)
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let yourTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .right
        label.textColor = .black
        return label
    }()
    
    // MARK: MAIN -
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: FUNCTIONS -
    
    func setUpViews(){
        backgroundColor = .white
        addSubview(yourTextLabel)
        addSubview(yourProfileView)
    }
    
    func setUpConstraints(){
        NSLayoutConstraint.activate([
            yourTextLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            yourTextLabel.trailingAnchor.constraint(equalTo: yourProfileView.leadingAnchor, constant: -10),
            yourTextLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            yourTextLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            
            yourProfileView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            yourProfileView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            yourProfileView.widthAnchor.constraint(equalToConstant: 20),
            yourProfileView.heightAnchor.constraint(equalToConstant: 20)
        ])
    }

}
