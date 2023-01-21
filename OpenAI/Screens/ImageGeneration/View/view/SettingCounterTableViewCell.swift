//
//  SettingCounterTableViewCell.swift
//  OpenAI
//
//  Created by Dheeraj Kumar Sharma on 21/01/23.
//

import UIKit

class SettingCounterTableViewCell: UITableViewCell {

    // MARK: PROPERTIES -
    
    var numberOfImage: ((Int) -> ())?
    var maxImageCount = 10
    var count: Int = 1 {
        didSet {
            counterView.countLabel.text = "\(count)"
        }
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Set number of images to generate"
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        return label
    }()
    
    lazy var counterView: CustomCounterView = {
        let view = CustomCounterView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        view.minusButton.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
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
        addSubview(titleLabel)
        addSubview(counterView)
    }
    
    func setUpConstraints(){
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: counterView.leadingAnchor, constant: -10),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            counterView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            counterView.heightAnchor.constraint(equalToConstant: 30),
            counterView.widthAnchor.constraint(equalToConstant: 100),
            counterView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    // MARK:- ACTION
    
    @objc func plusButtonTapped(){
        if count == maxImageCount {
            count = maxImageCount
        } else {
            count += 1
        }
        numberOfImage?(count)
    }
    
    @objc func minusButtonTapped(){
        if count == 1 {
            count = 1
        } else {
            count -= 1
        }
        numberOfImage?(count)
    }

}

class CustomCounterView: UIView {
    
    // MARK: PROPERTIES -
    
    let stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.distribution = .fill
        view.axis = .horizontal
        view.spacing = 0
        return view 
    }()
    
    let plusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.layer.cornerRadius = 4
        return button
    }()
    
    let minusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setImage(UIImage(systemName: "minus"), for: .normal)
        button.layer.cornerRadius = 4
        return button
    }()
    
    let countView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let countLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textAlignment = .center
        return label
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
        backgroundColor = .lightGray.withAlphaComponent(0.3)
        layer.cornerRadius = 4
        addSubview(stackView)
        stackView.addArrangedSubview(minusButton)
        
        stackView.addArrangedSubview(countView)
        countView.addSubview(countLabel)
        
        stackView.addArrangedSubview(plusButton)
    }
    
    func setUpConstraints(){
        countLabel.pin(to: countView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
            
            plusButton.widthAnchor.constraint(equalToConstant: 30),
            plusButton.heightAnchor.constraint(equalToConstant: 30),
            
            minusButton.widthAnchor.constraint(equalToConstant: 30),
            minusButton.heightAnchor.constraint(equalToConstant: 30),
            
            countView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
}
