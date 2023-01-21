//
//  ImageModel.swift
//  OpenAI
//
//  Created by Dheeraj Kumar Sharma on 14/01/23.
//

import Foundation

/// Image Body

struct ImageModelBody: Codable {
    let prompt: String
    let n: Int?
    let size: String?
    let response_format: String?
    
    init(prompt: String, n: Int? = 1, size: String? = "256x256", response_format: String? = "url") {
        self.prompt = prompt
        self.n = n
        self.size = size
        self.response_format = response_format
    }
}


/// Image Response

struct ImageModelResponse: Codable {
    let created: Double?
    let data: [ImageData]?
    let error: ErrorData?
}

struct ImageData: Codable {
    let url: String?
}

struct ErrorData: Codable {
    let message: String?
}


/// Image Size Enum

enum ImageSize: String {
    case _256 = "256x256"
    case _512 = "512x512"
    case _1024 = "1024x1024"
}
