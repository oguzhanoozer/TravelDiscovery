//
//  CategoryDetailsView.swift
//  TravelDiscoveryLTBA
//
//  Created by oguzhan on 16.05.2024.
//

import SwiftUI
import Kingfisher
import SDWebImageSwiftUI

private let fontSize = 64.0
private let radiusSize = 8.0
private let spacing = 12.0
private let duration = 0.5


struct CategoryDetailsView: View {
    
    private let name: String
    @ObservedObject var categoryViewModel: CategoryDetailsViewModel
    
    init(name: String){
        self.name = name
        self.categoryViewModel = .init()
    }
    
    var body: some View {
        ZStack{
            if categoryViewModel.isLoading {
                VStack {
                    ActivityIndicatorView()
                    Text("Loading")
                        .foregroundColor(.white)
                        .asText(size: FontSizes.caption1,weight: .semibold)
                }.padding()
                    .background(Color.black)
                    .cornerRadius(radiusSize)
                
            }else{
                ZStack {
                    
                    if !categoryViewModel.errorMessage.isEmpty {
                        VStack(spacing: spacing){
                            Image(systemName: "xmark.octagon.fill")
                                .asText(size: fontSize,weight: .semibold)
                                .foregroundColor(.red)
                            Text(categoryViewModel.errorMessage)
                        }
                    }
                    
                    ScrollView{
                        ForEach(categoryViewModel.places, id: \.self){ place in
                            VStack(alignment: .leading ,spacing: 0){                             
                                WebImage(url: URL(string: place.thumbnail))
                                    .resizable()
                                    .indicator(.activity)
                                    .transition(.fade(duration: duration))
                                    .scaledToFill()
                                    
                                Text(place.name)
                                    .asText(size: FontSizes.caption1,weight: .semibold)
                                    .foregroundColor(.black)
                                    .padding()
                            }.asTile()
                                .padding()
                        }
                    }
                }
            }
            
        }.navigationTitle(name)
            .navigationBarTitleDisplayMode(.inline)
            .task {
                await categoryViewModel.onCategoryDetail(name: name)
        }
    }
}

#Preview {
    NavigationView {
        CategoryDetailsView(name: "art")
    }
}
