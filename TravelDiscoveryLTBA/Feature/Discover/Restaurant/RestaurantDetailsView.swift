//
//  RestaurantView.swift
//  TravelDiscoveryLTBA
//
//  Created by oguzhan on 19.05.2024.
//

import SwiftUI
import Kingfisher

private let fontSize = 13.0
private let fontSizeNormal = 16.0
private let paddingHigh = 16.0
private let paddingLow = 8.0
private let paddingLowest = 4.0
private let spacing = 16.0
private let frameSize = 80.0
private let cellFrameSize = 120.0
private let radiusLow = 2.0
private let paddingVertical = 2.0


struct CustomLinearGradient: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black]), startPoint: .center, endPoint: .bottom)
    }
}

struct RestaurantDetailsView: View {
    
    @ObservedObject var restaurantDetailsVM : RestaurantDetailsViewModel
    
    let restaurant: Restaurant
    
    init(restaurant: Restaurant) {
        self.restaurantDetailsVM = .init()
        self.restaurant = restaurant
    }
    
    var body: some View {
        ScrollView {
            
            ZStack(alignment: .bottomLeading){
                Image(restaurant.imageName)
                    .resizable()
                    .scaledToFill()
                
                CustomLinearGradient()
                
                HStack{
                    VStack(alignment: .leading,spacing: ViewSize.spacingLow){
                        Text(restaurant.name)
                            .foregroundStyle(.white)
                            .asText(size:FontSizes.caption3,weight: .bold)
                        
                        HStack{
                            ForEach(0..<5, id: \.self){ num in
                                Image(systemName: "star.fill")
                            }.foregroundStyle(.orange)
                        }
                    }
                    Spacer()
                    NavigationLink {
                        RestaurantPhotosView()
                    } label: {
                        Text("See more photos")
                            .foregroundStyle(.white)
                            .asText(size:FontSizes.caption2,weight: .regular)
                            .frame(width: frameSize)
                            .multilineTextAlignment(.trailing)
                    }
                    
                }.padding()
            }
            
            VStack(alignment: .leading){
                Text("Location & Description")
                    .asText(size: fontSizeNormal ,weight: .bold)
                Text("Tokyo, Japan")
                
                HStack{
                    ForEach(0..<5, id: \.self){ num in
                        Image(systemName: "dollarsign.circle.fill")
                    }.foregroundStyle(.orange)
                }
                Text(restaurantDetailsVM.restaurantDetails?.description ?? "")
                    .padding(.top, paddingLow)
                    .asText(size:FontSizes.caption2,weight: .regular).padding()
                
            }.padding(.top)
                .padding(.horizontal)
            
            HStack{
                Text("Popular Dishes")
                    .asText(size: fontSizeNormal ,weight: .bold)
                Spacer()
            }.padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false){
                HStack(spacing: spacing){
                    ForEach(restaurantDetailsVM.restaurantDetails?.popularDishes ?? [], id: \.self){ dish in
                        DishCellView(dish: dish)
                    }
                }.padding(.horizontal)
                    .padding(.bottom)
            }
            
            
            if let reviews = restaurantDetailsVM.restaurantDetails?.reviews{
                ReviewListView(reviews: reviews)
            }
            
        }.navigationTitle("Restaurant Details")
            .navigationBarTitleDisplayMode(.inline)
            .task {
                await restaurantDetailsVM.onRestaurantDetail()
            }
        
    }
}

#Preview {
    NavigationView {
        RestaurantDetailsView(restaurant: .init(name: "Japan's Finest", imageName: "tapas"))
    }
}

struct DishCellView: View {
    let dish: Dish
    
    var body: some View {
        VStack(alignment: .leading){
            ZStack(alignment: .bottomLeading) {
                KFImage(URL(string: dish.photo))
                    .resizable()
                    .scaledToFill()
                    .cornerRadius(RadiusItems.radius)
                    .overlay(RoundedRectangle(cornerRadius: RadiusItems.radius).stroke( Color.gray))
                    .shadow(radius: radiusLow)
                    .padding(.vertical, paddingVertical)
                
                CustomLinearGradient()
                
                Text(dish.price)
                    .foregroundStyle(.white)
                    .asText(size: fontSize, weight: .bold)
                    .padding(.horizontal, PagePadding.All.low.rawValue)
                    .padding(.bottom, paddingLowest)
                
            }.frame(height: cellFrameSize)
                .cornerRadius(RadiusItems.radius)
            
            
            Text(dish.name)
                .asText(size: FontSizes.caption2, weight: .bold)
            
            Text("\(dish.numPhotos) Photos")
                .foregroundStyle(.gray)
                .asText(size: FontSizes.caption1, weight: .regular)
            
        }
    }
}

struct ReviewListView: View {
    
    let reviews: [Review]
    
    var body: some View {
        
        HStack{
            Text("Customer Reviews")
                .font(.system(size: 16, weight: .bold))
            Spacer()
        }.padding(.horizontal)
        
        ForEach(reviews, id: \.self){ review in
            VStack(alignment: .leading){
                HStack{
                    KFImage(URL(string: review.user.profileImage))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 44)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("\(review.user.firstName)" + "\(review.user.lastName)")
                            .font(.system(size: 14, weight: .bold))
                        
                        HStack(spacing: 4){
                            ForEach(0..<review.rating,id: \.self) {num in
                                Image(systemName: "star.fill")
                                    .foregroundStyle(.orange)
                                
                            }
                            ForEach(0..<5 - review.rating,id: \.self) {num in
                                Image(systemName: "star.fill")
                                    .foregroundStyle(.gray)
                                
                            }
                        }  .font(.system(size: 12))
                    }
                    Spacer()
                    Text("Dec 2020").font(.system(size: 13, weight: .regular))
                }
                Text(review.text)
            }.padding(.top)
                .padding(.horizontal)
        }
    }
}
