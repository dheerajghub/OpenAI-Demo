//
//  HttpUtility.swift
//  OpenAI
//
//  Created by Dheeraj Kumar Sharma on 14/01/23.
//

import Foundation

public struct HttpUtility {
    
    func getApiData<T: Codable>(requestURL: URL, resultType: T.Type, completionHandler: @escaping(_ result: T) -> Void){
        
        URLSession.shared.dataTask(with: requestURL) { (responseData, httpUrlResponse, error) in
            if (error == nil && responseData != nil && responseData?.count != 0){
                // parse the responseData here
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(T.self, from: responseData!)
                    _ = completionHandler(result)
                } catch let error {
                    debugPrint("error occur while decoding = \(error.localizedDescription)")
                }
            }
        }.resume()
        
    }
    
    func postApiData<T: Codable>(requestURL: URL, requestBody: Data, resultType: T.Type, completionHandler: @escaping(_ result: T) -> Void){
        
        var urlRequest = URLRequest(url: requestURL)
        urlRequest.httpMethod = "post"
        urlRequest.httpBody = requestBody
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        urlRequest.addValue("\(OpenAIWrapper.getInstance().getAuthToken())", forHTTPHeaderField: "Authorization")
        
        
        URLSession.shared.dataTask(with: urlRequest) { (responseData, httpUrlResponse, error) in
            if (error == nil && responseData != nil && responseData?.count != 0){
                
                print(String(data: responseData!, encoding: .utf8)!)
                
                // parse the responseData here
                do {
                    let result = try JSONDecoder().decode(T.self, from: responseData!)
                    
                    DispatchQueue.main.async {
                        completionHandler(result)
                    }
                    
                } catch let error {
                    debugPrint("error occur while decoding = \(error.localizedDescription)")
                }
            }
        }.resume()
        
    }
    
}
