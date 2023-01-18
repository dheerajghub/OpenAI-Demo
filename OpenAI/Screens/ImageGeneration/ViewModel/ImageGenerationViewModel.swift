//
//  ImageGenerationViewModel.swift
//  OpenAI
//
//  Created by Dheeraj Kumar Sharma on 15/01/23.
//

import Foundation

class ImageGenerationViewModel {
    
    var openAIWrapper: OpenAIWrapper?
    
    func getGenerateImageWithText(text: String, completion: @escaping(ImageModelResponse) -> Void) {
    
        openAIWrapper?.getNetworking().generateImageWithText(text: text) { response in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                completion(response)
            }
        }
        
    }
    
}
