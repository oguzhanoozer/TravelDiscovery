//
//  PopularDestinationsView.swift
//  TravelDiscoveryLTBA
//
//  Created by oguzhan on 16.05.2024.
//

import SwiftUI
import MapKit

private let frameSize = 100.0
private let frameMapSize = 80.0

private let paddingLow = 4.0
private let radiusLow = 4.0

extension Color{
    static let textColor = Color(.init(white:0, alpha: 0.5))
}

struct PopularDestinationsView: View {
    var body: some View {
        VStack{
            HStack{
                Text(LocaleKeys.Discover.popularDestination.rawValue.locale()).asText(size:  FontSizes.caption2,weight: .semibold)
                Spacer()
                Text(LocaleKeys.Discover.seeAll.rawValue.locale()).asText(size: FontSizes.caption1,weight: .semibold)
            }.padding(.top)
            
            ScrollView(.horizontal){
                HStack(spacing: ViewSize.spacingNormal){
                    ForEach(Destination.destinations, id:\.self){destination in
                        NavigationLink(
                            destination: NavigationLazyView(PopularDestinationDetailsView(destination: destination)),
                            label: {
                                PopularDestinationTile(destination: destination)
                                    .foregroundColor(.black)
                                    .padding(.bottom)
                            })
                    }
                }
            }
        }.padding(.horizontal)
    }
}

struct PopularDestinationTile: View {
    
    let destination: Destination
    
    var body: some View {
        VStack(alignment: .leading,spacing: 0){
            
            Image(destination.image)
                .resizable()
                .scaledToFill()
                .frame(width: frameSize, height: frameSize)
                .cornerRadius(RadiusItems.radius)
                .padding(.horizontal, PagePadding.Horizontal.low.rawValue)
                .padding(.vertical,PagePadding.Vertical.low.rawValue)
            
            Text(destination.name)
                .asText(size: FontSizes.caption1,weight: .semibold)
                .padding(.horizontal,PagePadding.Horizontal.high.rawValue)
            
            Text(destination.country).asText(size: FontSizes.caption1,weight: .semibold)
                .padding(.horizontal,PagePadding.Horizontal.high.rawValue)
                .padding(.bottom,PagePadding.All.normal.rawValue)
            
        }  /* .frame(width: 125)*/
        .asTile()
    }
}

struct CustomMapAnnotationView: View {
    let attraction: Attraction
    
    var body: some View {
        VStack {
            Image(attraction.imageName)
                .resizable()
                .frame(width: frameMapSize, height: frameMapSize)
                .cornerRadius(RadiusItems.radius)
            Text(attraction.name)
                .asText(size: FontSizes.caption1,weight: .semibold)
                .padding(.horizontal, PagePadding.All.low.rawValue)
                .padding(.vertical, paddingLow)
                .background(LinearGradient(colors: [.red,.blue], startPoint: .leading, endPoint: .trailing))
                .foregroundStyle(.white)
                .cornerRadius(radiusLow)
                .overlay(RoundedRectangle(cornerRadius: radiusLow).stroke(Color.textColor))
        }.shadow(radius: RadiusItems.radius)
    }
}

#Preview {
    PopularDestinationsView()
    
}
