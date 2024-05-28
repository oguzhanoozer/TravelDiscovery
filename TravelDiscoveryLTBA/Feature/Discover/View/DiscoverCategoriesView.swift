//
//  DiscoverCategoriesView.swift
//  TravelDiscoveryLTBA
//
//  Created by oguzhan on 16.05.2024.
//

import SwiftUI

private let frameSize = 64.0
private let frameRadius = 64.0
private let stackSize = 68.0

struct DiscoverCategoriesView: View {
    var body: some View {
        ScrollView(.horizontal){
            HStack(alignment: .top, spacing: ViewSize.spacingHigh){
                ForEach(Category.categories, id: \.self){category in
                    NavigationLink(
                        destination: NavigationLazyView(CategoryDetailsView(name: category.name)),
                        label: {
                            VStack(spacing: ViewSize.spacingNormal) {
                                Image(systemName: category.image)
                                    .font(.system(size: FontSizes.headline))
                                    .foregroundColor(.orange)
                                    .frame(width: frameSize,height: frameSize)
                                    .background(.white)
                                    .cornerRadius(frameRadius) //.infinity
                                Text(category.name)
                                    .font(.system(size: FontSizes.caption1,weight: .semibold))
                                    .foregroundColor(.white)
                            }.frame(width: stackSize)
                        })
                }
            }.padding(.horizontal)
        }
    }
}


#Preview {
    
    DiscoverCategoriesView()
    
}
