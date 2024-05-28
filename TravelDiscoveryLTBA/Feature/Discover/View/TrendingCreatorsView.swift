//
//  TrendingCreatorsView.swift
//  TravelDiscoveryLTBA
//
//  Created by oguzhan on 16.05.2024.
//

import SwiftUI

private let frameSize = 60.0

struct ShadowModifier: ViewModifier {
    func body(content: Content) -> some View {
        return
            content.shadow(color: .gray, radius: 4,x: 0.0, y: 2)
    }
}

struct TrendingCreatorsView: View {
    var body: some View {
        VStack{
            HStack{
                Text(LocaleKeys.Discover.trendingCreators.rawValue.locale())
                    .asText(size: FontSizes.caption2,weight: .semibold)
                    Spacer()
                Text(LocaleKeys.Discover.seeAll.rawValue.locale())
                    .asText(size: FontSizes.caption1,weight: .semibold)
            }
            .padding(.top)
            
            ScrollView(.horizontal){
                HStack(alignment: .top,spacing: ViewSize.spacingMedium){
                    ForEach(User.users, id:\.self){ user in
                        NavigationLink {
                            NavigationLazyView(UserDetailView(user: user))
                        } label: {
                            DiscoverUserdView(user: user)
                        }

                    }
                }
            }
        }.padding(.horizontal)
    }
}


struct DiscoverUserdView: View {
    let user: User
    
    var body: some View {
        VStack{
            Image(user.image)
                .resizable()
                .scaledToFill()
                .frame(width: frameSize, height: frameSize)
                .cornerRadius(.infinity)
            Text(user.name)
                .asText(size: FontSizes.body1,weight: .semibold)
                .multilineTextAlignment(.center)
                .foregroundStyle(Color(.label))
        }.frame(width: frameSize)
            .modifier(ShadowModifier())
            .padding(.bottom)
    }
}

#Preview {
    TrendingCreatorsView()
}
