//
//  ChatViewController.swift
//  OpenAI
//
//  Created by Dheeraj Kumar Sharma on 24/01/23.
//

import UIKit

class ChatViewController: UIViewController {

    // MARK: - PROPERTIES
    
    var messageTextContainerBottomConstraint: NSLayoutConstraint?
    var messageTextContainerViewHeightConstraint: NSLayoutConstraint?
    
    lazy var messageTextContainerView: CustomChatMessageView = {
        let view = CustomChatMessageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blue
        view.messageTextView.delegate = self
        return view
    }()
    
    // MARK: - MAIN
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    // MARK: - FUNCTIONS
    
    func setupViews(){
        view.backgroundColor = .white
        view.addSubview(messageTextContainerView)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        messageTextContainerBottomConstraint = NSLayoutConstraint(item: messageTextContainerView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        view.addConstraint(messageTextContainerBottomConstraint!)
        
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            messageTextContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            messageTextContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            messageTextContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        messageTextContainerViewHeightConstraint = messageTextContainerView.heightAnchor.constraint(equalToConstant: 50)
        messageTextContainerViewHeightConstraint?.isActive = true
    }
    
    // MARK: - ACTIONS
    
    @objc func handleKeyboardNotification(notification: NSNotification){
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
            
            messageTextContainerBottomConstraint?.constant = isKeyboardShowing ? -keyboardHeight : 0
            
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut) {
                self.view.layoutIfNeeded()
            }
            
        }
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
        
        let size = CGSize(width: textView.frame.width - 10, height: messageTextContainerView.frame.height)
        let estimatedHeight = textView.sizeThatFits(size)
        
        if estimatedHeight.height > 45 {
            messageTextContainerViewHeightConstraint?.constant = estimatedHeight.height + 10
        } else {
            messageTextContainerViewHeightConstraint?.constant = 50
        }
        
    }
    
}
