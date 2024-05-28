//
//  Attraction.swift
//  TravelDiscoveryLTBA
//
//  Created by oguzhan on 17.05.2024.
//

import Foundation
import MapKit

struct Attraction: Identifiable{
    let id = UUID().uuidString
    let name: String
    let imageName: String
    let coordinate: CLLocationCoordinate2D
    
    static let attractions : [Attraction] = [
        Attraction(name: "Eiffel Tower", imageName: "eiffel_tower", coordinate: CLLocationCoordinate2D(latitude: 48.8583701, longitude: 2.2919064)),
        Attraction(name: "Louvre Museum", imageName: "eiffel_tower", coordinate: CLLocationCoordinate2D(latitude: 48.8606111, longitude: 2.3350691))
    ]
}
