//
//  ImageGenerationViewModel.swift
//  OpenAI
//
//  Created by Dheeraj Kumar Sharma on 15/01/23.
//

import Foundation

class ImageGenerationViewModel {
    
    var openAIWrapper: OpenAIWrapper?
    var numberOfImageToGenerate: Int = 1
    var selectedImageSizeIndex = 0
    var imageSize: ImageSize = ImageSize._256
    
    func getGenerateImageWithText(text: String ,completion: @escaping(ImageModelResponse) -> Void) {
    
        openAIWrapper?.getNetworking().generateImageWithText(text: text, numberOfImages: numberOfImageToGenerate, imageSize: imageSize.rawValue) { response in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                completion(response)
            }
        }
        
    }
    
    func getImageSize() -> ImageSize? {
        switch selectedImageSizeIndex {
            case 0: return ImageSize._256
            case 1: return ImageSize._512
            case 2: return ImageSize._1024
            default: return nil
        }
    }
    
}
