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
    
}
