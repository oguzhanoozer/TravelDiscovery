//
//  RestaurantDetails.swift
//  TravelDiscoveryLTBA
//
//  Created by oguzhan on 19.05.2024.
//

import Foundation

struct RestaurantDetails: Codable{
    let description: String
    let popularDishes: [Dish]
    let photos: [String]
    let reviews: [Review]
}

struct Review: Codable, Hashable{
    let user: ReviewUser
    let rating: Int
    let text: String
}

struct ReviewUser: Codable, Hashable{
    let id: Int
    let userName: String
    let firstName: String
    let lastName: String
    let profileImage: String
    
    enum CodingKeys: String, CodingKey {
            case id
            case userName = "username"
            case firstName
            case lastName
            case profileImage
        }
}

struct Dish: Codable, Hashable{
    let name: String
    let price: String
    let photo: String
    let numPhotos: Int
}
