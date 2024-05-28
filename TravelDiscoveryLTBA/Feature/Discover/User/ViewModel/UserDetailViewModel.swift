//
//  UserDetailViewModel.swift
//  TravelDiscoveryLTBA
//
//  Created by oguzhan on 20.05.2024.
//

import Foundation

@MainActor
class UserDetailViewModel: ObservableObject{
    
    @Published var userDetails: UserDetails?
    
    private let networkManager = NetworkManager.networkManager
    
    init() {}
    
    func onUserDetail(userId: Int)async{
        do {
            self.userDetails = try await onUserDetail(userId: userId)
        } catch let jsonError{
            print("Decoding failed for UserDetails:", jsonError.asAFError?.responseCode ?? 0)
        }
    }
}

extension UserDetailViewModel: UserDetailCase{
    fileprivate func onUserDetail(userId: Int) async throws-> UserDetails?{
        let response = try await networkManager.fetchData(path: .user, method: .get, type: UserDetails.self, id: userId,name: nil)
        return response
    }
}

private protocol UserDetailCase{
    func onUserDetail(userId: Int)async throws-> UserDetails?
}
