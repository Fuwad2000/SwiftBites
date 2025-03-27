//
//  APIManager.swift
//  Group_Project
//
//  Created by Hammad Shaikh on 2025-03-26.
//

import Foundation

class APIManager {
    static func fetchStaticAPIDataSync(from urlString: String) -> [String: [String: [String: [String: Any]]]]? {
        // Create a URL
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let semaphore = DispatchSemaphore(value: 0)
        
        var resultDictionary: [String: [String: [String: [String: Any]]]]?

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in

            if let error = error {
                print("Error: \(error.localizedDescription)")
                semaphore.signal()
                return
            }
            
            guard let data = data else {
                print("No data received")
                semaphore.signal()
                return
            }
            
            do {

                if let jsonResult = try JSONSerialization.jsonObject(with: data, options: []) as? [String: [String: [String: [String: Any]]]] {
                    resultDictionary = jsonResult
                }
            } catch {
                print("JSON parsing error: \(error.localizedDescription)")
            }
            
            semaphore.signal()
        }
        
        task.resume()
        
        _ = semaphore.wait(timeout: .now() + 10)
        
        return resultDictionary
    }
}
