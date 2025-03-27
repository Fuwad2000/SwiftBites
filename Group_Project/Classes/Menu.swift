//
//  Menu.swift
//  Group_Project
//
//  Created by Hammad Shaikh on 2025-03-26.
//

class Menu{
    static func getMenu() -> [String: [String: [String: [String: Any]]]]?{
        return APIManager.fetchStaticAPIDataSync(from: "https://swiftbites.shaikhcloud.com/api/menu")
    }
    static func getSnacks() -> [String: [String: Any]]?{
        return getMenu()?["data"]?["snacks"]
    }
    static func getFood() -> [String: [String: Any]]?{
        return getMenu()?["data"]?["food"]
    }
    static func getDrinks() -> [String: [String: Any]]?{
        return getMenu()?["data"]?["drinks"]
    }
}
