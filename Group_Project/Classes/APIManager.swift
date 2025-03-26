//
//  APIManager.swift
//  Group_Project
//
//  Created by Hammad Shaikh on 2025-03-26.
//

import Foundation

class APIManager {
    static func fetchStaticAPIDataSync(from urlString: String) -> [String: Any]? {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let semaphore = DispatchSemaphore(value: 0)

        var resultDictionary: [String: Any]?

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
                // Parse JSON
                if let jsonResult = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
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
    static func fetchMenu() -> [String: Any]? {
        guard let url = URL(string: "https://swiftbites.shaikhcloud.com/api/menu") else {
            print("Invalid URL")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let semaphore = DispatchSemaphore(value: 0)

        var resultDictionary: [String: Any]?

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
                // Parse JSON
                if let jsonResult = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
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
    static func fetchDrinks() -> [String: Any]? {
        guard let url = URL(string: "https://swiftbites.shaikhcloud.com/api/menu") else {
            print("Invalid URL")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let semaphore = DispatchSemaphore(value: 0)

        var resultDictionary: [String: Any]?

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
                // Parse JSON
                if let jsonResult = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
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
    static func fetchSnacks() -> [String: Any]? {
        guard let url = URL(string: "https://swiftbites.shaikhcloud.com/api/snacks") else {
            print("Invalid URL")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let semaphore = DispatchSemaphore(value: 0)

        var resultDictionary: [String: Any]?

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
                // Parse JSON
                if let jsonResult = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
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
