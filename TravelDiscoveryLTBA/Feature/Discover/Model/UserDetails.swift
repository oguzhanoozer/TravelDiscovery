//
//  UserDetails.swift
//  TravelDiscoveryLTBA
//
//  Created by oguzhan on 20.05.2024.
//

import Foundation

struct UserDetails: Codable{
    let username, firstName, lastName, profileImage: String
    let followers, following: Int
    let posts: [Post]
}

struct Post: Codable, Hashable{
    let title, imageUrl, views: String
    let hashtags : [String]
}
