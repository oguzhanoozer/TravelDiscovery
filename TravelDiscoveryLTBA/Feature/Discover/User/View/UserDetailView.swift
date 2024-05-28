//
//  UserDetailView.swift
//  TravelDiscoveryLTBA
//
//  Created by oguzhan on 19.05.2024.
//

import SwiftUI
import Kingfisher

private let fontSize = 10.0
private let imageFrameSize = 60.0
private let imageFrameHeightLow = 44.0
private let imageFrameHeightNormal = 200.0
private let radiusLow = 20.0
private let radius = 100.0
private let spacerHeight = 12.0
private let whiteFeaturedColor = Color(white: 0.8)
private let paddingLow = 4.0
private let spacerFrameWidth = 0.5


struct UserShadowModifier: ViewModifier {
    func body(content: Content) -> some View {
        return
            content.shadow(color: whiteFeaturedColor, radius: 5, x: 0, y: 4)
    }
}

struct UserDetailView: View {
    let user: User
    
    @ObservedObject var userDetailVM: UserDetailViewModel
    
    init(user: User){
        self.user = user
        self.userDetailVM = .init()
    }
    
    var body: some View{
        ScrollView{
            VStack(spacing: ViewSize.spacingMedium){
                Image(user.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: imageFrameSize)
                    .clipShape(Circle())
                    .shadow(radius: RadiusItems.radiusNormal)
                    .padding(.horizontal)
                    .padding(.top)
                
                Text("\(self.userDetailVM.userDetails?.firstName ?? "") \(self.userDetailVM.userDetails?.lastName ?? "") ")
                    .asText(size: FontSizes.caption3, weight: .semibold)
                
                HStack{
                    Text("@\(self.userDetailVM.userDetails?.username ?? "")")
                    Image(systemName: "hand.thumbsup.fill")
                        .asText(size: fontSize, weight: .semibold)
                    Text("54321")
                }
                .asText(size: FontSizes.caption1, weight: .regular)
                
                Text("Youteber, Vlogger, Traveler Creator")
                    .asText(size: FontSizes.caption2, weight: .regular)
                    .foregroundStyle(Color(.lightGray))
                
                HStack(spacing: ViewSize.spacingMedium){
                    VStack{
                        Text("\(self.userDetailVM.userDetails?.followers ?? 0)")
                            .asText(size: FontSizes.caption1, weight: .semibold)
                        Text("Followers")
                            .asText(size: fontSize, weight: .regular)
                    }
                    
                    Spacer()
                        .frame(width: spacerFrameWidth, height: spacerHeight)
                        .background(Color(.lightGray))
                    
                    VStack{
                        Text("\(self.userDetailVM.userDetails?.following ?? 0)")
                            .asText(size: FontSizes.caption1, weight: .semibold)
                        Text("Following")
                            .asText(size: fontSize, weight: .regular)
                    }
                }
                
                HStack(spacing: ViewSize.spacingMedium ){
                    Button(action: {
                        
                    }, label: {
                        HStack{
                            Spacer()
                            Text("Follow")
                            
                                .foregroundStyle(.white)
                            Spacer()
                        }.padding(.vertical, PagePadding.All.normal.rawValue)
                            .background(Color.orange)
                            .cornerRadius(radius)
                    })
                    
                    Button(action: {
                        
                    }, label: {
                        HStack{
                            Spacer()
                            Text("Contact")
                                .foregroundStyle(.black)
                            Spacer()
                        }.padding(.vertical, PagePadding.All.normal.rawValue)
                            .background(whiteFeaturedColor)
                            .cornerRadius(radius)
                    })
                }.asText(size: FontSizes.caption1, weight: .semibold)
                
                ForEach(userDetailVM.userDetails?.posts ??  [], id: \.self) { post in
                    PostView(post: post, user: user)
                }
                
            }.padding(.horizontal)
        }.navigationTitle(user.name)
            .navigationBarTitleDisplayMode(.inline)
            .task {
                await userDetailVM.onUserDetail(userId: user.id)
            }
    }
    
    struct PostView: View {
        
        let post: Post
        let user: User
        
        var body: some View {
            VStack(alignment: .leading){
                KFImage(URL(string: post.imageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(height: imageFrameHeightNormal)
                    .clipped()
                
                HStack{
                    Image(user.image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: imageFrameHeightLow)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading){
                        
                        Text(post.title)
                            .asText(size: FontSizes.caption2, weight: .semibold)
                        
                        Text("\(post.views) views")
                            .asText(size: FontSizes.caption1, weight: .regular)
                            .foregroundStyle(.gray)
                        
                    }.padding(.horizontal, PagePadding.All.normal.rawValue)
                }
                
                HashtagsView(hashtags: post.hashtags)
                
            }
            .background(.white)
            .cornerRadius(RadiusItems.radiusHigh)
            .modifier(UserShadowModifier())
        }
    }
    
    struct HashtagsView: View {
        let hashtags: [String]
        
        var body: some View {
            ScrollView(.horizontal,showsIndicators: false) {
                HStack
                {
                    ForEach(hashtags, id: \.self){ hashtag in
                        Text("#\(hashtag)")
                            .foregroundStyle(.blue)
                            .asText(size: FontSizes.caption1, weight: .semibold)
                            .padding(.horizontal, PagePadding.All.high.rawValue)
                            .padding(.vertical, paddingLow)
                            .background(whiteFeaturedColor)
                            .cornerRadius(radiusLow)
                    }
                }.padding(.bottom)
                    .padding(.horizontal, PagePadding.All.high.rawValue)
            }
        }
    }
    
    
    #Preview {
        NavigationView {
            UserDetailView(user: User.users.first!)
        }
    }
}
