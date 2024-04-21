//
//  AppLaunchController.swift
//  OpenAI
//
//  Created by Dheeraj Kumar Sharma on 15/01/23.
//

import UIKit

class AppLaunchController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // creating configurations
        let apiKey = "\(KeyConstant.apiSecret)" // <replace you api secret here>
        OpenAIWrapper.getInstance().createConfiguration(apiKey: apiKey)
        
        // launching home view controller
        let openAIWrapperInstance = OpenAIWrapper.getInstance()
        let vc = HomeViewController(_openAIWrapper: openAIWrapperInstance)
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        
        self.present(navVC, animated: false)
        
    }

}
