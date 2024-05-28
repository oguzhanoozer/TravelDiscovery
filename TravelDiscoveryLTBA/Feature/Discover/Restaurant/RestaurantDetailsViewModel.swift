//
//  RestaurantDetailsViewModel.swift
//  TravelDiscoveryLTBA
//
//  Created by oguzhan on 19.05.2024.
//

import Foundation

@MainActor
class RestaurantDetailsViewModel: ObservableObject{
    
    @Published var restaurantDetails: RestaurantDetails?
    
    private let networkManager = NetworkManager.networkManager
    
    init() {}
    
    func onRestaurantDetail() async{
        do {
            let restaurantId = 0
            self.restaurantDetails = try await onRestaurantDetail(restaurantId: restaurantId)
        } catch let jsonError{
            print("Decoding failed for RestaurantDetails:", jsonError)
        }
    }
}

extension RestaurantDetailsViewModel: RestaurantDetailCase{
    fileprivate func onRestaurantDetail(restaurantId: Int) async throws-> RestaurantDetails?{
        let response = try await networkManager.fetchData(path: .restaurant, method: .get, type: RestaurantDetails.self, id: restaurantId, name: nil)
        return response
    }
}

private protocol RestaurantDetailCase{
    func onRestaurantDetail(restaurantId: Int)async throws-> RestaurantDetails?
}
