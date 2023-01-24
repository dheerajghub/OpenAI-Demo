//
//  CustomChatMessageView.swift
//  OpenAI
//
//  Created by Dheeraj Kumar Sharma on 24/01/23.
//

import UIKit

class CustomChatMessageView: UIView {

    // MARK: - PROPERTIES
    
    let messageTextCoverView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()
    
    let messageTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textColor = .black
        textView.font = .systemFont(ofSize: 15, weight: .regular)
        textView.text = "Type something.."
        return textView
    }()
    
    let sendButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Send", for: .normal)
        button.backgroundColor = .red
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
        addSubview(messageTextCoverView)
        messageTextCoverView.addSubview(messageTextView)
        addSubview(sendButton)
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            sendButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            sendButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            sendButton.widthAnchor.constraint(equalToConstant: 80),
            sendButton.heightAnchor.constraint(equalToConstant: 35),
            
            messageTextCoverView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            messageTextCoverView.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: 5),
            messageTextCoverView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            messageTextCoverView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            
            messageTextView.leadingAnchor.constraint(equalTo: messageTextCoverView.leadingAnchor, constant: 5),
            messageTextView.trailingAnchor.constraint(equalTo: messageTextCoverView.trailingAnchor, constant: -5),
            messageTextView.bottomAnchor.constraint(equalTo: messageTextCoverView.bottomAnchor),
            messageTextView.topAnchor.constraint(equalTo: messageTextCoverView.topAnchor)
        ])
    }

}
