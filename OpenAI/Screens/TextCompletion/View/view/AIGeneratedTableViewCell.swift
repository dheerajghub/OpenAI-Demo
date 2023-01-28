//
//  AIGeneratedTableViewCell.swift
//  OpenAI
//
//  Created by Dheeraj Kumar Sharma on 28/01/23.
//

import UIKit
import Lottie

class AIGeneratedTableViewCell: UITableViewCell {

    // MARK: PROPERTIES -
    
    var messageData: CustomChatModel? {
        didSet {
            guard let messageData = messageData else {
                return
            }

            AITextLabel.text = messageData.message
            if messageData.isLoading {
                loaderView.isHidden = false
                loaderView.play()
            } else {
                loaderView.stop()
                loaderView.isHidden = true
            }
        }
    }
    
    let AIProfileView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        imageView.layer.borderWidth = 0.8
        imageView.layer.cornerRadius = 17.5
        imageView.image = UIImage(named: "ic_openAI")
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let AITextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    let loaderView: AnimationView = {
        let view = AnimationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.animation = Animation.named("messageLoader")
        view.loopMode = .loop
    
        return view
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
        backgroundColor = .black
        clipsToBounds = true
        addSubview(AIProfileView)
        addSubview(AITextLabel)
        addSubview(loaderView)
    }
    
    func setUpConstraints(){
        NSLayoutConstraint.activate([
            AITextLabel.leadingAnchor.constraint(equalTo: AIProfileView.trailingAnchor, constant: 10),
            AITextLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            AITextLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            AITextLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            
            AIProfileView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            AIProfileView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            AIProfileView.widthAnchor.constraint(equalToConstant: 35),
            AIProfileView.heightAnchor.constraint(equalToConstant: 35),
            
            loaderView.leadingAnchor.constraint(equalTo: AIProfileView.trailingAnchor, constant: -20),
            loaderView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }


}
