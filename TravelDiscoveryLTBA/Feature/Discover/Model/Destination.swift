//
//  Destination.swift
//  TravelDiscoveryLTBA
//
//  Created by oguzhan on 15.05.2024.
//

import Foundation

struct Destination: Hashable{
    let name: String
    let country: String
    let image: String
    let latitude: Double
    let longtitude: Double
    
    static let destinations : [Destination] = [
        Destination(name: "Paris", country: "France", image: Images.eiffel.rawValue,latitude: 48.8584345, longtitude: 2.0352526),
        Destination(name: "Tokyo", country: "Japan", image: Images.japan.rawValue,latitude: 35.7339283, longtitude: 139.5642381),
        Destination(name: "New York", country: "US", image: Images.new_york.rawValue,latitude: 40.6973709, longtitude: -74.1444838),
    ]
}
