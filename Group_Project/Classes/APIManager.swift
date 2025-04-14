//
//  APIManager.swift
//  Group_Project
//
//  Created by Hammad Shaikh on 2025-03-26.
//
//  This class provides methods for making API requests and handling responses.
//  Principal author: Hammad Shaikh

import Foundation

class APIManager {
    /// Fetches menu data from the API synchronously
    /// - Parameter urlString: The URL string from which to fetch data
    /// - Returns: A nested dictionary containing the structured menu data, or nil if the request fails
    static func fetchStaticAPIDataSync(from urlString: String) -> [String: [String: [String: [String: Any]]]]? {
        // Create a URL
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // Create a semaphore to make the asynchronous request synchronous
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
                // Parse the JSON data into a nested dictionary structure
                if let jsonResult = try JSONSerialization.jsonObject(with: data, options: []) as? [String: [String: [String: [String: Any]]]] {
                    resultDictionary = jsonResult
                }
            } catch {
                print("JSON parsing error: \(error.localizedDescription)")
            }
            
            semaphore.signal()
        }
        
        task.resume()
        
        // Wait for the network request to complete with a timeout
        _ = semaphore.wait(timeout: .now() + 10)
        
        return resultDictionary
    }
}
