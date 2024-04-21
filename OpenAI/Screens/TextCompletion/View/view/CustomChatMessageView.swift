//
//  CustomChatMessageView.swift
//  OpenAI
//
//  Created by Dheeraj Kumar Sharma on 24/01/23.
//

import UIKit

class CustomChatMessageView: UIView {

    // MARK: - PROPERTIES
    
    let waitingForResponseLoader: WaitingForResponseLoader = {
        let view = WaitingForResponseLoader()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    let messageTextCoverView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let messageTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textColor = .black
        textView.font = .systemFont(ofSize: 16, weight: .regular)
        textView.text = "Type something.."
        textView.backgroundColor = .clear
        return textView
    }()
    
    let sendButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "ic_send")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.imageView?.tintColor = .black
        button.tapFeedback()
        return button
    }()
    
    // MARK: - MAIN
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - FUNCTIONS
    
    func setupViews(){
        backgroundColor = .lightGray.withAlphaComponent(0.2)
        addSubview(messageTextCoverView)
        messageTextCoverView.addSubview(messageTextView)
        addSubview(sendButton)
        addSubview(waitingForResponseLoader)
    }
    
    func setupConstraints(){
        waitingForResponseLoader.pin(to: self)
        NSLayoutConstraint.activate([
            sendButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            sendButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            sendButton.widthAnchor.constraint(equalToConstant: 50),
            sendButton.heightAnchor.constraint(equalToConstant: 50),
            
            messageTextCoverView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            messageTextCoverView.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -5),
            messageTextCoverView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            messageTextCoverView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            
            messageTextView.leadingAnchor.constraint(equalTo: messageTextCoverView.leadingAnchor),
            messageTextView.trailingAnchor.constraint(equalTo: messageTextCoverView.trailingAnchor),
            messageTextView.bottomAnchor.constraint(equalTo: messageTextCoverView.bottomAnchor),
            messageTextView.topAnchor.constraint(equalTo: messageTextCoverView.topAnchor)
        ])
    }

}
