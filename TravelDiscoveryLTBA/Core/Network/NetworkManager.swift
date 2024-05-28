//
//  NetworkManager.swift
//  TravelDiscoveryLTBA
//
//  Created by oguzhan on 27.05.2024.
//

import Foundation
import Alamofire

struct NetworkConfig{
    let baseUrl: String
}

protocol INetworkManager{
    func fetchDataForTest<T: Codable>(path: NetworkPath, method: HTTPMethod, type: T.Type, id: Int?, name: String?)async throws-> T?
    func fetchData<T: Codable>(path: NetworkPath, method: HTTPMethod, type: T.Type, id: Int?, name: String?) async throws -> T?
    var config : NetworkConfig { get set }
}

extension NetworkManager{
    static let networkManager: INetworkManager = NetworkManager(config: NetworkConfig(baseUrl: NetworkPath.baseUrl))
}

class NetworkManager: INetworkManager{
    
    internal var config: NetworkConfig
    
    init(config: NetworkConfig) {
        self.config = config
    }
    
    func fetchData<T: Codable>(path: NetworkPath, method: HTTPMethod, type: T.Type, id: Int?, name: String?) async throws -> T? {
        
        try await withCheckedThrowingContinuation { continuation in
            var parameters: Parameters = [:]
            
            if id != nil {
                parameters["id"] = id
            }
            
            if name != nil {
                parameters["name"] = name!.lowercased()
            }
            
            AF.request("\(config.baseUrl)\(path.rawValue)", method: method, parameters: parameters, encoding: URLEncoding.default)
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case let .success(data):
                        continuation.resume(returning: data)
                    case let .failure(error):
                        continuation.resume(throwing: error)
                    }
                }
        }
    }
    
    
    func fetchDataForTest<T: Codable>(path: NetworkPath,method: HTTPMethod,type: T.Type, id: Int? = nil, name: String? = nil) async throws-> T? {
        
        var parameters: Parameters = [:]
        
        if id != nil {
            parameters["id"] = id
        }
        
        if name != nil {
            parameters["name"] = name!.lowercased()
        }
        
        let dataRequest = await  AF.request("\(config.baseUrl)\(path.rawValue)", method: method,parameters: parameters,encoding: URLEncoding.default)
            .validate()
            .serializingDecodable(T.self).result
        
        switch dataRequest {
        case let .success(data):
            return data
        case let .failure(error):
            throw error
        }
    
        //
        //  let result = await dataRequest.response
        //
        //  guard let value = result.value else{
        //  print("ERROR: \(String(describing: result.error))")
        //       return nil
        //  }
        //  return value
    }
}


enum NetworkPath: String{
    case user = "travel_discovery/user"
    case restaurant = "travel_discovery/restaurant"
    case destination = "travel_discovery/destination"
    case category = "travel_discovery/category"
    
    static let baseUrl: String = "https://travel.letsbuildthatapp.com/"
}
