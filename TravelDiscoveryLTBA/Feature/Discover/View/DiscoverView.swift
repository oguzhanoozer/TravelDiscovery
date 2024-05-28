//
//  DashboardView.swift
//  TravelDiscoveryLTBA
//
//  Created by oguzhan on 15.05.2024.
//

import SwiftUI

private let paddingLow = 16.0
private let paddingHigh = 32.0
private let radiusSize = 16.0
private let offsetSize = 500.0

extension Color{
    static let discoverBackgroundColor = Color(.init(white: 0.95, alpha: 1))
    static let discoverStackColor = Color(.init(white: 0.95, alpha: 0.3))
}

struct DiscoverView: View {
    
    init(){
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
    }
    
    var body: some View {
        NavigationView{
            
            ZStack{
                
                LinearGradient(gradient: Gradient(colors: [.orange, .orange]),
                               startPoint: .top, endPoint: .center)
                .ignoresSafeArea()
                
                Color.discoverBackgroundColor
                    .offset(y: offsetSize)
                
                ScrollView{
                    
                    HStack{
                        Image(systemName: "magnifyingglass")
                        Text("Where do you want to go?")
                        Spacer()
                    }.asText(size:FontSizes.caption1,weight: .semibold)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.discoverStackColor)
                        .cornerRadius(RadiusItems.radiusNormal)
                        .padding(paddingLow)
                    
                    DiscoverCategoriesView()
                    VStack {
                        PopularDestinationsView()
                        PopularRestaurantsView()
                        TrendingCreatorsView()
                    }.background(Color.discoverBackgroundColor)
                        .cornerRadius(radiusSize)
                        .padding(.top, paddingHigh)
                }
            }
            
            .navigationTitle(LocaleKeys.Discover.discover.rawValue.locale())
        }
    }
}


#Preview {
    DiscoverView()
}
