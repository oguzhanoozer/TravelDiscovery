//
//  PopularRestaurantsView.swift
//  TravelDiscoveryLTBA
//
//  Created by oguzhan on 16.05.2024.
//

import SwiftUI

private let frameSize = 60.0
private let stackFrameSize = 240.0

struct PopularRestaurantsView: View {
    var body: some View {
        VStack{
            HStack{
                Text(LocaleKeys.Discover.popularPlacesToEat.rawValue.locale())
                    .asText(size: FontSizes.caption2,weight: .semibold)
                
                Spacer()
                
                Text(LocaleKeys.Discover.seeAll.rawValue.locale())
                    .asText(size: FontSizes.caption1,weight: .semibold)
                
            }.padding(.horizontal)
                .padding(.top)
            
            ScrollView(.horizontal){
                HStack(spacing: ViewSize.spacingNormal){
                    ForEach(Restaurant.restaurants, id:\.self){restaurant in
                        NavigationLink {
                            RestaurantDetailsView(restaurant: restaurant)
                        } label: {
                            RestaurantTile(restaurant: restaurant)
                                .foregroundStyle(Color(.label))
                        }
                }.padding(.horizontal)
            }
        }
    }
}

struct RestaurantTile: View {
    
    let restaurant: Restaurant
    
        var body: some View {
            HStack(spacing: PagePadding.All.normal.rawValue){
                Image(restaurant.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: frameSize, height: frameSize)
                    .clipped()
                    .cornerRadius(RadiusItems.radius)
                    .padding(.leading, PagePadding.All.low.rawValue)
                    .padding(.vertical, PagePadding.Vertical.low.rawValue)
                
                VStack(alignment: .leading, spacing: PagePadding.All.low.rawValue) {
                    HStack{
                        Text(restaurant.name)
                        Spacer()
                        Button(action: {} , label: {
                            Image(systemName: "ellipsis")
                                .foregroundColor(.gray)
                        })
                    }
                    
                    HStack{
                        Image(systemName: "star.fill")
                        Text("4.7 • Sushi • $$")
                    }
                    
                    Text("Tokyo, Japan" )
                    
                }.font(.system(size: FontSizes.caption1,weight: .semibold))
                
                Spacer()
                
            }.frame(width: stackFrameSize)
                .asTile()
                .padding(.bottom)
            }
        }
    }
    
#Preview {
    DiscoverView()
}
