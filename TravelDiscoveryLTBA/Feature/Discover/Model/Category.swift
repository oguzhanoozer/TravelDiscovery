//
//  Category.swift
//  TravelDiscoveryLTBA
//
//  Created by oguzhan on 15.05.2024.
//

import Foundation

struct Category: Hashable{
    let name: String
    let image: String
    
    static let categories: [Category] = [
        Category(name: "Art", image: "paintpalette.fill"),
        Category(name: "Sports", image: "sportscourt.fill"),
        Category(name: "Live Events", image: "music.mic"),
        Category(name: "Food", image: "music.mic"),
        Category(name: "History", image: "music.mic"),
    ]
}
