//
//  Networking.swift
//  OpenAI
//
//  Created by Dheeraj Kumar Sharma on 14/01/23.
//

import Foundation

public class Networking: NSObject {
    
    public var httpUtility: HttpUtility
    public var configuration: OpenAIConfiguration
    
    public init(_httpUtility: HttpUtility, _configuration: OpenAIConfiguration) {
        self.httpUtility = _httpUtility
        self.configuration = _configuration
    }
    
    func generateImageWithText(text: String, numberOfImages: Int, imageSize: String, completionHandler: @escaping(ImageModelResponse) -> Void){
        
        let createImageURL = URL(string: Endpoint.createImage)
        let request = ImageModelBody(prompt: text, n: numberOfImages, size: imageSize)
        
        do {
            let encodeRequest = try JSONEncoder().encode(request)
            httpUtility.postApiData(requestURL: createImageURL!, requestBody: encodeRequest, resultType: ImageModelResponse.self) { result in
                
                DispatchQueue.main.async {
                    completionHandler(result)
                }
                
            }
            
        } catch let error {
            debugPrint("error while encoding = \(error.localizedDescription)")
        }
        
        
    }
    
    func textCompletion(text: String, completionHandler: @escaping(CompletionModelResponse) -> Void) {
        
        let completionURL = URL(string: Endpoint.completion)
        
        let messages = [
            PromptMessageModel(role: "system", content: "You are an assitant of the app named openAI demo, and you will assist users only within the scope of tech"),
            PromptMessageModel(role: "user", content: "\(text)"),
        ]
        let request = CompletionModelBody(messages: messages)
        
        do {
            let encodeRequest = try JSONEncoder().encode(request)
            httpUtility.postApiData(requestURL: completionURL!, requestBody: encodeRequest, resultType: CompletionModelResponse.self) { result in
                
                DispatchQueue.main.async {
                    completionHandler(result)
                }
                
            }
        } catch let error {
            debugPrint("error while encoding = \(error.localizedDescription)")
        }
        
    }
    
}
