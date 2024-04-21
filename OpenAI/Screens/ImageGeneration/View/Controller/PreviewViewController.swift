//
//  PreviewViewController.swift
//  OpenAI
//
//  Created by Dheeraj Kumar Sharma on 14/01/23.
//

import UIKit
import Kingfisher

class PreviewViewController: UIViewController {

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setUpConstraints()
    }
    
    // MARK: FUNCTIONS -
    
    func setUpViews(){
        view.backgroundColor = .black
        view.addSubview(imageView)
    }
    
    func setUpConstraints(){
        imageView.pin(to: view)
    }
    
}
