//
//  HomeModel.swift
//  OpenAI
//
//  Created by Dheeraj Kumar Sharma on 15/01/23.
//

import Foundation
import UIKit

enum ModelTypes {
    case imageGeneration
    case textCompletion
    case codeCompletion
    case modelList
}

struct HomeModel {
    let openAIsModelName: String
    let iconImage: String
    let modelType: ModelTypes
}

let homeModelData = [
    HomeModel(openAIsModelName: "Model", iconImage: "doc.text", modelType: .modelList),
    HomeModel(openAIsModelName: "Image Generation", iconImage: "photo", modelType: .imageGeneration),
    HomeModel(openAIsModelName: "Text Completion", iconImage: "text.bubble", modelType: .textCompletion),
    HomeModel(openAIsModelName: "Code Completion", iconImage: "chevron.left.forwardslash.chevron.right", modelType: .codeCompletion)
]
