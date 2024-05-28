//
//  DiscoverViewModel.swift
//  TravelDiscoveryLTBA
//
//  Created by oguzhan on 16.05.2024.
//

//import Foundation

//class CategoryDetailsViewModel: ObservableObject{
//
//    @Published var isLoading = true
//    @Published var places = [Place]()
//    @Published var errorMessage = ""
//
//    init(name: String ) {
//
//        let urlString = "https://travel.letsbuildthatapp.com/travel_discovery/category?name=\(name.lowercased())"
//            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
//
//        guard let url = URL(string: urlString) else {
//                self.isLoading = false
//                return
//            }
//
//        URLSession.shared.dataTask(with: url) { data, response, error in
//
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
//
//                if let statusCode = (response as? HTTPURLResponse)?.statusCode,
//                   statusCode >= 400 {
//                    self.isLoading = false
//                    self.errorMessage = "Bad Status: \(statusCode)"
//                    return
//                }
//
//                guard let data = data else { return }
//
//                do{
//                    self.places = try JSONDecoder().decode([Place].self, from: data)
//                }catch{
//                    print("Failed to decode JSON:" + error.localizedDescription)
//                    self.errorMessage = error.localizedDescription
//                }
//                self.isLoading = false
//            }
//        }.resume()
//
//    }
//}


import Foundation

@MainActor
class CategoryDetailsViewModel: ObservableObject{
    
    @Published var isLoading = true
    @Published var places = [Place]()
    @Published var errorMessage = ""
    
    private let networkManager = NetworkManager.networkManager
    
    init() {}
    
    func onCategoryDetail(name: String) async{
        
        do {
            self.places = try await onCategoryPlaces(name: name)
        } catch let jsonError{
            self.errorMessage = jsonError.localizedDescription
            print("Decoding failed for RestaurantDetails:", jsonError.asAFError?.responseCode ?? 0 )
            
            if let statusCode = jsonError.asAFError?.responseCode,
               statusCode >= 400 {
                self.errorMessage = "Bad Status: \(statusCode)"
            }
        }
        self.isLoading = false
    }
}

extension CategoryDetailsViewModel: CategoryDetailCase{
    fileprivate func onCategoryPlaces(name: String) async throws-> [Place]{
        let response = try await networkManager.fetchDataForTest(path: .category, method: .get, type: [Place].self, id: nil, name: name) ?? []
        return response
    }
}

private protocol CategoryDetailCase{
    func onCategoryPlaces(name: String)async throws-> [Place]
}

