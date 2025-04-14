//
//  Menu.swift
//  Group_Project
//
//  Created by Hammad Shaikh on 2025-03-26.
//
//  This class provides static methods to retrieve menu items from the API.
//  Principal author: Hammad Shaikh

class Menu{
    /// Retrieves the complete menu data from the API
    /// - Returns: A nested dictionary containing all menu categories and items
    static func getMenu() -> [String: [String: [String: [String: Any]]]]?{
        return APIManager.fetchStaticAPIDataSync(from: "https://swiftbites.shaikhcloud.com/api/menu")
    }
    
    /// Retrieves snack items from the menu
    /// - Returns: A dictionary of snack items
    static func getSnacks() -> [String: [String: Any]]?{
        return getMenu()?["data"]?["snacks"]
    }
    
    /// Retrieves food items from the menu
    /// - Returns: A dictionary of food items
    static func getFood() -> [String: [String: Any]]?{
        return getMenu()?["data"]?["food"]
    }
    
    /// Retrieves drink items from the menu
    /// - Returns: A dictionary of drink items
    static func getDrinks() -> [String: [String: Any]]?{
        return getMenu()?["data"]?["drinks"]
    }
}
