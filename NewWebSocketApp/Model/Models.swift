//
//  Models.swift
//  NewWebSocketApp
//
//  Created by Bender on 20.05.2024.
//

struct Item {
    let available: Int
    let average: Int
    let game: String
    let image: String
    let itemId: Int
    let marketName: String
    let name: String
    let price: Int
    let searchName: String
    let steamPrice: Int
    
    init?(json: [String: Any]) {
        guard
            let available = json["available"] as? Int,
            let average = json["average"] as? Int,
            let game = json["game"] as? String,
            let image = json["image"] as? String,
            let itemId = json["item_id"] as? Int,
            let marketName = json["market_name"] as? String,
            let name = json["name"] as? String,
            let price = json["price"] as? Int,
            let searchName = json["search_name"] as? String,
            let steamPrice = json["steam_price"] as? Int
        else {
            return nil
        }
        
        self.available = available
        self.average = average
        self.game = game
        self.image = image
        self.itemId = itemId
        self.marketName = marketName
        self.name = name
        self.price = price
        self.searchName = searchName
        self.steamPrice = steamPrice
    }
}
