//
//  TextCompletionViewModel.swift
//  OpenAI
//
//  Created by Dheeraj Kumar Sharma on 28/01/23.
//

import UIKit

class TextCompletionViewModel {
    
    var openAIWrapper: OpenAIWrapper?
    var chatMessages: [CustomChatModel] = []
    
    var messageTextContainerBottomConstraint: NSLayoutConstraint?
    var messageTextContainerViewHeightConstraint: NSLayoutConstraint?
    
    func sendPrompt(text: String, completion: @escaping(_ response: CompletionModelResponse) -> ()){
        
        //: 1 send that prompt message to the OpenAI apis and get response
        
        openAIWrapper?.getNetworking().textCompletion(text: text, completionHandler: { response in
            
            if response.error == nil {
                
                guard let choices = response.choices
                else { return }
                
                let firstChoice = choices[0]
                var aiMessage = firstChoice.message?.content ?? ""
                aiMessage = aiMessage.replacingOccurrences(of: "\n", with: "")
                
                let aiResponse = CustomChatModel(message: aiMessage, isAI: true, isLoading: false)

                // remove last loader message
                self.chatMessages.remove(at: self.chatMessages.count - 1)
                self.chatMessages.append(aiResponse)
                completion(response)
                
            } else {
                // remove last loader message
                self.chatMessages.remove(at: self.chatMessages.count - 1)
                completion(response)
            }
            
        })
        
    }
    
}

