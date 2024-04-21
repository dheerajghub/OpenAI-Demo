//
//  ImageCollectionViewCell.swift
//  OpenAI
//
//  Created by Dheeraj Kumar Sharma on 21/01/23.
//

import UIKit
import Kingfisher

class ImageCollectionViewCell: UICollectionViewCell {
    
    // MARK: PROPERTIES -
    
    var imageURL: String? {
        didSet {
            guard let imageURL = imageURL else {
                return
            }

            if let url = URL(string: imageURL) {
                imageView.kf.indicatorType = .activity
                imageView.kf.setImage(with: url)
            }
            
        }
    }
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
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
        backgroundColor = .clear
        addSubview(imageView)
    }
    
    func setUpConstraints(){
        imageView.pin(to: self)
    }
    
}
