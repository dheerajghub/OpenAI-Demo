//
//  OpenAIConfiguration.swift
//  OpenAI
//
//  Created by Dheeraj Kumar Sharma on 15/01/23.
//

import Foundation

public struct OpenAIConfiguration {
    
    public var apiKey: String
    
    public init(_apiKey: String) {
        self.apiKey = _apiKey
    }
    
    var getAuthToken: String {
        return "Bearer \(apiKey)"
    }
    
}
