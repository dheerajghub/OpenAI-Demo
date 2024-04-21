//
//  ImageGenerationController.swift
//  OpenAI
//
//  Created by Dheeraj Kumar Sharma on 14/01/23.
//

import UIKit

class ImageGenerationController: UIViewController {

    // MARK: PROPERTIES -
    
    var openAIWrapper: OpenAIWrapper?
    let viewModel = ImageGenerationViewModel()
    
    let textCardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textColor = .lightGray
        textView.font = .systemFont(ofSize: 30, weight: .semibold)
        textView.textAlignment = .center
        textView.delegate = self
        textView.text = "Type something.."
        return textView
    }()
    
    lazy var generateButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        button.setTitle("Generate Image", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 25
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        button.addTarget(self, action: #selector(generateTapped), for: .touchUpInside)
        button.alpha = 0.3
        button.isEnabled = false
        button.tapFeedback()
        return button
    }()
    
    let loaderView: CustomLoaderView = {
        let view = CustomLoaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.loaderLabel.text = "Generating Image..."
        view.isHidden = true
        return view
    }()
    
    // MARK: - INITIALIZER
    
    init(_openAIWrapper: OpenAIWrapper?) {
        super.init(nibName: nil, bundle: nil)
        self.openAIWrapper = _openAIWrapper
        self.viewModel.openAIWrapper = _openAIWrapper
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: MAIN -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigations()
        setUpViews()
        setUpConstraints()
    }
    
    // MARK: FUNCTIONS -
    
    func setupNavigations(){
        
        //create a new button
        let settingButton: UIButton = UIButton(type: .system)
        settingButton.setImage(UIImage(systemName: "gearshape"), for: .normal)
        settingButton.addTarget(self, action: #selector(settingButtonTapped), for: .touchUpInside)
        settingButton.frame = CGRect(x: 0, y: 0, width: 35, height: 35)

        let barButton = UIBarButtonItem(customView: settingButton)
        self.navigationItem.rightBarButtonItem = barButton
        
    }
    
    func setUpViews(){
        view.backgroundColor = .white
        
        view.addSubview(textCardView)
        textCardView.addSubview(textView)
        
        view.addSubview(generateButton)
        view.addSubview(loaderView)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        viewModel.generateButtonBottomConstraint = NSLayoutConstraint(item: generateButton, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        view.addConstraint(viewModel.generateButtonBottomConstraint!)
        
        viewModel.textCardViewBottomConstraint = NSLayoutConstraint(item: textCardView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        view.addConstraint(viewModel.textCardViewBottomConstraint!)
    }
    
    func setUpConstraints(){
        loaderView.pin(to: view)
        NSLayoutConstraint.activate([
            textCardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            textCardView.bottomAnchor.constraint(equalTo: generateButton.topAnchor),
            textCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            textView.leadingAnchor.constraint(equalTo: textCardView.leadingAnchor, constant: 30),
            textView.trailingAnchor.constraint(equalTo: textCardView.trailingAnchor, constant: -30),
            textView.heightAnchor.constraint(equalToConstant: 50),
            textView.centerYAnchor.constraint(equalTo: textCardView.centerYAnchor),
            
            generateButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            generateButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            generateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            generateButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func resetToDefault(){
        textView.text = ""
        textView.text = "Type something.."
        generateButton.alpha = 0.3
        generateButton.isEnabled = false
    }
    
    // MARK: - ACTIONS
    
    @objc func handleKeyboardNotification(notification: NSNotification){
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
            
            viewModel.textCardViewBottomConstraint?.constant = isKeyboardShowing ? -keyboardHeight : 0
            viewModel.generateButtonBottomConstraint?.constant = isKeyboardShowing ? -(keyboardHeight + 10) : 0
            
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut) {
                self.view.layoutIfNeeded()
            }

        }
    }
    
    @objc func generateTapped(){
        
        if textView.text != "" {
            
            let text = textView.text ?? ""
            textView.endEditing(true)
            
            loaderView.showLoader()
            
            viewModel.getGenerateImageWithText(text: text) { response in
                
                self.loaderView.hideLoader()
                self.resetToDefault()
                
                if response.error == nil {
                    let vc = ImageColletionViewController()
                    vc.imageData = response.data
                    self.navigationController?.pushViewController(vc, animated: true)
                } else {
                    let message = response.error?.message ?? ""
                    Alert.showAlert(self, title: "Error", message: message)
                }
                
            } //: completion end
        } //: condition end
    }
    
    @objc func settingButtonTapped(){
        // open settings
        let vc = SettingViewController(_viewModel: viewModel)
        vc.navigationItem.title = "Settings"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ImageGenerationController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        
        if textView.text == "" || textView.text == "Type something.." {
            generateButton.alpha = 0.3
            generateButton.isEnabled = false
        } else {
            generateButton.alpha = 1
            generateButton.isEnabled = true
        }
        
        let size = CGSize(width: textView.frame.width, height: textCardView.frame.height)
        let estimatedHeight = textView.sizeThatFits(size)
        
        textView.constraints.forEach { constraint in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedHeight.height
            }
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Type something.." {
            textView.text = ""
        }
    }
    
}

