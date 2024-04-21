//
//  ChatViewController.swift
//  OpenAI
//
//  Created by Dheeraj Kumar Sharma on 24/01/23.
//

import UIKit

class ChatViewController: UIViewController {

    // MARK: - PROPERTIES
    
    var openAIWrapper: OpenAIWrapper?
    let viewModel = TextCompletionViewModel()
    
    lazy var messageTextContainerView: CustomChatMessageView = {
        let view = CustomChatMessageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.messageTextView.delegate = self
        view.sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        return view
    }()
    
    lazy var chatTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(YourTextTableViewCell.self, forCellReuseIdentifier: "YourTextTableViewCell")
        tableView.register(AIGeneratedTableViewCell.self, forCellReuseIdentifier: "AIGeneratedTableViewCell")
        tableView.separatorColor = .lightGray.withAlphaComponent(0.5)
        tableView.backgroundColor = .clear
        return tableView
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
    
    // MARK: - MAIN
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        hideKeyboardWhenTappedAround()
    }
    
    // MARK: - FUNCTIONS
    
    func setupViews(){
        view.backgroundColor = .white
        view.addSubview(chatTableView)
        view.addSubview(messageTextContainerView)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        viewModel.messageTextContainerBottomConstraint = NSLayoutConstraint(item: messageTextContainerView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        view.addConstraint(viewModel.messageTextContainerBottomConstraint!)
        
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            messageTextContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            messageTextContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            messageTextContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            chatTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            chatTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            chatTableView.bottomAnchor.constraint(equalTo: messageTextContainerView.topAnchor),
            chatTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
        
        viewModel.messageTextContainerViewHeightConstraint = messageTextContainerView.heightAnchor.constraint(equalToConstant: 50)
        viewModel.messageTextContainerViewHeightConstraint?.isActive = true
    }
    
    func insertPromptToTableView(prompt: String){
        
        //:1 Get next two index for inserting the data
        let firstIndex = self.viewModel.chatMessages.count
        let secondIndex = firstIndex + 1
        
        //:2 Get two index path for inserting the data
        let firstIndexPath = IndexPath(row: firstIndex, section: 0)
        let secondIndexPath = IndexPath(row: secondIndex, section: 0)
        
        //:3 Insert data to the message array
        let promptMessage = [
            CustomChatModel(message: prompt, isAI: false, isLoading: false),
            CustomChatModel(message: "", isAI: true, isLoading: true)
        ]
        
        self.viewModel.chatMessages.append(contentsOf: promptMessage)
        
        self.chatTableView.beginUpdates()
        chatTableView.insertRows(at: [firstIndexPath , secondIndexPath], with: .bottom)
        self.chatTableView.endUpdates()
        
        // get last index path
        let lastIndex = viewModel.chatMessages.count - 1
        chatTableView.scrollToRow(at: IndexPath(row: lastIndex, section: 0), at: .bottom, animated: true)
        
    }
    
    // MARK: - ACTIONS
    
    @objc func handleKeyboardNotification(notification: NSNotification){
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
            
            viewModel.messageTextContainerBottomConstraint?.constant = isKeyboardShowing ? -keyboardHeight : 0
            
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut) {
                self.view.layoutIfNeeded()
            }
            
        }
    }
    
    @objc func sendButtonTapped(){
        let text = messageTextContainerView.messageTextView.text ?? ""
        
        if text.isEmpty {
            Alert.showAlert(self, title: "Error", message: "Cannot request empty response")
            return
        }
        
        insertPromptToTableView(prompt: text)
        
        // waiting for response loader
        messageTextContainerView.waitingForResponseLoader.isHidden = false
        
        viewModel.sendPrompt(text: text) { response in
            if response.error != nil {
                let errorMessage = response.error?.message ?? ""
                Alert.showAlert(self, title: "Error", message: errorMessage)
            }
            self.messageTextContainerView.waitingForResponseLoader.isHidden = true
            self.chatTableView.reloadData()
        }
        
        messageTextContainerView.messageTextView.text = ""
        textViewDidChange(messageTextContainerView.messageTextView)
        
    }
    
}

extension ChatViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        
        let sendButton = messageTextContainerView.sendButton
        let messageTextView = messageTextContainerView.messageTextView
        
        if textView.text == "" || textView.text == "Type something.." {
            sendButton.alpha = 0.3
            sendButton.isEnabled = false
        } else {
            sendButton.alpha = 1
            sendButton.isEnabled = true
        }
        
        let size = CGSize(width: messageTextView.frame.width, height: messageTextContainerView.frame.height)
        let estimatedHeight = textView.sizeThatFits(size)
        
        if estimatedHeight.height > 45 {
            if estimatedHeight.height > 100 {
                viewModel.messageTextContainerViewHeightConstraint?.constant = 100
            } else {
                viewModel.messageTextContainerViewHeightConstraint?.constant = estimatedHeight.height + 10
            }
        } else {
            viewModel.messageTextContainerViewHeightConstraint?.constant = 50
        }
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Type something.." {
            textView.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "Type something.."
        }
    }
    
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.chatMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if !viewModel.chatMessages[indexPath.row].isAI {
            let cell = tableView.dequeueReusableCell(withIdentifier: "YourTextTableViewCell", for: indexPath) as! YourTextTableViewCell
            cell.selectionStyle = .none
            cell.yourTextLabel.text = viewModel.chatMessages[indexPath.row].message
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "AIGeneratedTableViewCell", for: indexPath) as! AIGeneratedTableViewCell
        cell.selectionStyle = .none
        cell.messageData = viewModel.chatMessages[indexPath.row]
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if viewModel.chatMessages[indexPath.row].isAI && viewModel.chatMessages[indexPath.row].isLoading {
            return 60
        }
        return tableView.estimatedRowHeight
    }
    
}
