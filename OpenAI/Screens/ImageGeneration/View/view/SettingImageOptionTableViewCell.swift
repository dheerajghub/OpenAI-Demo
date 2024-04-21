//
//  SettingImageOptionTableViewCell.swift
//  OpenAI
//
//  Created by Dheeraj Kumar Sharma on 20/01/23.
//

import UIKit

protocol SettingImageOptionDelegate {
    func selectedImageOption(index: Int)
}

class SettingImageOptionTableViewCell: UITableViewCell {

    // MARK: PROPERTIES -
    
    var segementControl: UISegmentedControl?
    var delegate: SettingImageOptionDelegate?
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Choose image size"
        label.font = .systemFont(ofSize: 13, weight: .semibold)
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
        addSubview(titleLabel)
        setupSegmentControl(withItems: ["256 x 256" , "512 x 512", "1024 x 1024"])
    }
    
    func setUpConstraints(){
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10)
        ])
    }
    
    func setupSegmentControl(withItems: [String]){
        segementControl = UISegmentedControl(items: withItems)
        segementControl?.translatesAutoresizingMaskIntoConstraints = false
        
        segementControl?.selectedSegmentIndex = 0
        segementControl?.tintColor = .blue
        
        segementControl?.addTarget(self, action: #selector(segementControlChanged), for: .valueChanged)
        
        addSubview(segementControl!)
        NSLayoutConstraint.activate([
            segementControl!.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            segementControl!.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            segementControl!.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
    }
    
    //MARK:- ACTIONS
    
    @objc func segementControlChanged(sender: UISegmentedControl){
        delegate?.selectedImageOption(index: sender.selectedSegmentIndex)
    }
    
}
