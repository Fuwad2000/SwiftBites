//
//  Menu.swift
//  Group_Project
//
//  Created by Hammad Shaikh on 2025-03-26.
//

class Menu{
    static func getMenu() -> [String: Any]?{
        return APIManager.fetchStaticAPIDataSync(from: "https://swiftbites.shaikhcloud.com/api/menu")
    }
    static func getSnacks() -> [String: Any]?{
        return APIManager.fetchStaticAPIDataSync(from: "https://swiftbites.shaikhcloud.com/api/snacks")
    }
    static func getFood() -> [String: Any]?{
        return APIManager.fetchStaticAPIDataSync(from: "https://swiftbites.shaikhcloud.com/api/food")
    }
    static func getDrinks() -> [String: Any]?{
        return APIManager.fetchStaticAPIDataSync(from: "https://swiftbites.shaikhcloud.com/api/drinks")
    }
}
