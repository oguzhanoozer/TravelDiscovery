//
//  DestinationDetailsViewModel.swift
//  TravelDiscoveryLTBA
//
//  Created by oguzhan on 19.05.2024.
//

import Foundation

@MainActor
class DestinationDetailsViewModel: ObservableObject{
    
    @Published var destinationDetails: DestinationDetails?
    
    private let networkManager = NetworkManager.networkManager
    
    init() {}
    
    func onDestinationDetail(name: String) async{
        do {
            self.destinationDetails = try await onDestinationDetail(name: name)
        } catch let jsonError{
            print("Decoding failed for RestaurantDetails:", jsonError)
        }
    }
}

extension DestinationDetailsViewModel: DestinationDetailCase{
    fileprivate func onDestinationDetail(name: String) async throws-> DestinationDetails?{
        let response = try await networkManager.fetchData(path: .destination, method: .get, type: DestinationDetails.self, id: nil, name: name)
        return response
    }
}

private protocol DestinationDetailCase{
    func onDestinationDetail(name: String)async throws-> DestinationDetails?
}
