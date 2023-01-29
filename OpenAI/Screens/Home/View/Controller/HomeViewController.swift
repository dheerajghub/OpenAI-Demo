//
//  HomeViewController.swift
//  OpenAI
//
//  Created by Dheeraj Kumar Sharma on 15/01/23.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: PROPERTIES -
    
    var openAIWrapper: OpenAIWrapper?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        return tableView
    }()
    
    // MARK: - INITIALIZER
    
    init(_openAIWrapper: OpenAIWrapper?) {
        super.init(nibName: nil, bundle: nil)
        self.openAIWrapper = _openAIWrapper
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
    
    func setupNavigations(){
        
    }
    
    func setUpViews(){
        view.backgroundColor = .white
        view.addSubview(tableView)
    }
    
    func setUpConstraints(){
        tableView.pin(to: view)
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeModelData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId")
        
        var content = cell?.defaultContentConfiguration()

        let data = homeModelData[indexPath.row]
        
        // Configure content.
        content?.image = UIImage(systemName: "\(data.iconImage)")
        content?.text = data.openAIsModelName

        // Customize appearance.
        content?.imageProperties.tintColor = .darkGray

        cell?.contentConfiguration = content
        cell?.selectionStyle = .none
        
        cell?.accessoryType = .disclosureIndicator
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = homeModelData[indexPath.row]
        
        switch data.modelType {
        case .imageGeneration:
            
            let controller = ImageGenerationController(_openAIWrapper: self.openAIWrapper)
            controller.title = data.openAIsModelName
            self.navigationController?.pushViewController(controller, animated: true)
            
        case .textCompletion:
            
            let controller = ChatViewController(_openAIWrapper: self.openAIWrapper)
            controller.title = data.openAIsModelName
            self.navigationController?.pushViewController(controller, animated: true)
            
            break
        case .codeCompletion:
            break
        case .modelList:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
