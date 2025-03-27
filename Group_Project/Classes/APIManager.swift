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
        
        // Create URL request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // Create a semaphore to wait for the response
        let semaphore = DispatchSemaphore(value: 0)
        
        // Variable to store the result
        var resultDictionary: [String: [String: [String: [String: Any]]]]?
        
        // Create data task
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // Check for errors
            if let error = error {
                print("Error: \(error.localizedDescription)")
                semaphore.signal()
                return
            }
            
            // Ensure we have data
            guard let data = data else {
                print("No data received")
                semaphore.signal()
                return
            }
            
            do {
                // Parse JSON
                if let jsonResult = try JSONSerialization.jsonObject(with: data, options: []) as? [String: [String: [String: [String: Any]]]] {
                    resultDictionary = jsonResult
                }
            } catch {
                print("JSON parsing error: \(error.localizedDescription)")
            }
            
            // Signal that we're done
            semaphore.signal()
        }
        
        // Start the task
        task.resume()
        
        // Wait for the task to complete (with a timeout)
        _ = semaphore.wait(timeout: .now() + 10)
        
        return resultDictionary
    }
}
