//
//  CustomLoaderView.swift
//  OpenAI
//
//  Created by Dheeraj Kumar Sharma on 14/01/23.
//

import UIKit
import Lottie

class CustomLoaderView: UIView {

    // MARK: PROPERTIES -
    
    let loaderView: AnimationView = {
        let view = AnimationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.animation = Animation.named("loader")
        view.loopMode = .loop
    
        return view
    }()
    
    let loaderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red.withAlphaComponent(0.2)
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    // MARK: MAIN -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: FUNCTIONS -
    
    func setUpViews(){
        backgroundColor = .white
        addSubview(loaderLabel)
        addSubview(cancelButton)
        addSubview(loaderView)
    }
    
    func setUpConstraints(){
        NSLayoutConstraint.activate([
            loaderView.centerXAnchor.constraint(equalTo: centerXAnchor),
            loaderView.centerYAnchor.constraint(equalTo: centerYAnchor),
            loaderView.heightAnchor.constraint(equalToConstant: 100),
            loaderView.widthAnchor.constraint(equalToConstant: 100),
            
            loaderLabel.topAnchor.constraint(equalTo: loaderView.bottomAnchor),
            loaderLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            cancelButton.widthAnchor.constraint(equalToConstant: 80),
            cancelButton.topAnchor.constraint(equalTo: loaderLabel.bottomAnchor, constant: 20),
            cancelButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            cancelButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func showLoader(){
        self.isHidden = false
        loaderView.play()
    }
    
    func hideLoader(){
        self.isHidden = true
        loaderView.stop()
    }
    
    // MARK: - ACTIONS
    
    @objc func cancelTapped(){
        hideLoader()
    }

}
