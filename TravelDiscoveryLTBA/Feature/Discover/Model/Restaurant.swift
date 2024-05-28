//
//  Restaurant.swift
//  TravelDiscoveryLTBA
//
//  Created by oguzhan on 15.05.2024.
//

import Foundation

struct Restaurant: Hashable{
    let name: String
    let imageName: String
    
    static let restaurants: [Restaurant] = [
        .init(name: "Japan's Finest Taps", imageName: "tapas"),
        .init(name: "Bar & Grill", imageName: "bar_grill")
    ]
}
