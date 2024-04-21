//
//  TextCompletionModel.swift
//  OpenAI
//
//  Created by Dheeraj Kumar Sharma on 28/01/23.
//

import Foundation

// Completion Body

struct CompletionModelBody: Encodable {
    
    let messages: [PromptMessageModel]
    let model: String?
    let max_tokens: Int?
    let temperature: Double?
    let top_p: Int?
    let n: Int?
    let stream: Bool?
    
    init(messages: [PromptMessageModel],
         model: String? = "gpt-3.5-turbo",
         max_tokens: Int? = 100,
         temperature: Double? = 0,
         top_p: Int? = 1,
         n: Int? = 1,
         stream: Bool? = false) {
        self.messages = messages
        self.model = model
        self.max_tokens = max_tokens
        self.temperature = temperature
        self.top_p = top_p
        self.n = n
        self.stream = stream
    }
    
}

struct PromptMessageModel: Codable {
    let role: String
    let content: String
    
    init(role: String, content: String) {
        self.role = role
        self.content = content
    }
}


// Completion Response

struct CompletionModelResponse: Codable {
    let id: String?
    let object: String?
    let created: Double?
    let model: String?
    let choices: [CompletionChoices]?
    let usage: UsageData?
    let error: ErrorData?
}

struct CompletionChoices: Codable {
    let message: PromptMessageModel?
    let index: Int?
    let finish_reason: String?
}

struct UsageData: Codable {
    let prompt_tokens: Int?
    let completion_tokens: Int?
    let total_tokens: Int?
}




// Custom Model

struct CustomChatModel {
    var message: String
    var isAI: Bool
    var isLoading: Bool
}

let chatDummy = [
    CustomChatModel(message: "Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.", isAI: false, isLoading: false),
    CustomChatModel(message: "But also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.", isAI: true, isLoading: false),
    CustomChatModel(message: "This is demo question", isAI: false, isLoading: false),
    CustomChatModel(message: "", isAI: true, isLoading: true)
]
