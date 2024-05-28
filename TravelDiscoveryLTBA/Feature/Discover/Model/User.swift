//
//  User.swift
//  TravelDiscoveryLTBA
//
//  Created by oguzhan on 15.05.2024.
//

import Foundation

struct User: Hashable{
    let id: Int
    let name: String
    let image: String
    
    static let users: [User] = [
        .init(id: 0, name: "Amy Adams", image: "amy"),
        .init(id: 1, name: "Billy", image: "billy"),
        .init(id: 2, name: "Sam Smith", image: "sam"),
    ]
}
