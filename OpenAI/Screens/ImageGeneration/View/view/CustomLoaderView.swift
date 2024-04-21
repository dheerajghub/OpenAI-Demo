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
    
    var animationView: LottieAnimationView?
    let loaderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.setupanimation()
        }
        
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
        guard let animationView else { return }
        animationView.play()
    }
    
    func hideLoader(){
        self.isHidden = true
        guard let animationView else { return }
        animationView.stop()
    }
    
    // MARK: - ACTIONS
    
    @objc func cancelTapped(){
        hideLoader()
    }
    
    func setupanimation(){
        
        // remove all subviews from loader view first
        self.loaderView.subviews.forEach { view in
            view.removeFromSuperview()
        }
        
        var animationView: LottieAnimationView?
        animationView = .init(name: "laoder")
        animationView?.frame = self.loaderView.bounds
        animationView?.contentMode = .scaleAspectFit
        animationView?.loopMode = .loop
        loaderView.addSubview(animationView!)
        animationView?.pin(to: loaderView)
        animationView?.play()
    }

}
