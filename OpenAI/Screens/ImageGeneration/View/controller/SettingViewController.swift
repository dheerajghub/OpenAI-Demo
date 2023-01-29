//
//  SettingViewController.swift
//  OpenAI
//
//  Created by Dheeraj Kumar Sharma on 19/01/23.
//

import UIKit

class SettingViewController: UIViewController {

    // MARK: PROPERTIES -
    
    var viewModel: ImageGenerationViewModel?
    
    lazy var settingOptionTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SettingImageOptionTableViewCell.self, forCellReuseIdentifier: "SettingImageOptionTableViewCell")
        tableView.register(SettingCounterTableViewCell.self, forCellReuseIdentifier: "SettingCounterTableViewCell")
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    // MARK: - INITIALIZER
    
    init(_viewModel: ImageGenerationViewModel?) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = _viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: MAIN -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setUpConstraints()
    }
    
    // MARK: FUNCTIONS -
    
    func setUpViews(){
        view.backgroundColor = .white
        view.addSubview(settingOptionTableView)
    }
    
    func setUpConstraints(){
        settingOptionTableView.pin(to: view)
    }

}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingImageOptionTableViewCell", for: indexPath) as! SettingImageOptionTableViewCell
            cell.selectionStyle = .none
            cell.contentView.isUserInteractionEnabled = false
            cell.segementControl?.selectedSegmentIndex = viewModel?.selectedImageSizeIndex ?? 0
            cell.delegate = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCounterTableViewCell", for: indexPath) as! SettingCounterTableViewCell
            cell.selectionStyle = .none
            cell.count = self.viewModel?.numberOfImageToGenerate ?? 1
            cell.numberOfImage = { count in
                self.viewModel?.numberOfImageToGenerate = count
            }
            cell.contentView.isUserInteractionEnabled = false
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 85
        } else {
            return 60
        }
    }
    
}

extension SettingViewController: SettingImageOptionDelegate {
    
    func selectedImageOption(index: Int) {
        self.viewModel?.selectedImageSizeIndex = index
    }
    
}
