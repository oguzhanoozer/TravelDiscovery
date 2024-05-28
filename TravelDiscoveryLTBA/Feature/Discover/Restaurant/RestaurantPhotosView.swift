//
//  RestaurantPhotosView.swift
//  TravelDiscoveryLTBA
//
//  Created by oguzhan on 19.05.2024.
//

import SwiftUI
import Kingfisher

private let fontSizeLow = 22.0
private let fontSize = 32.0
private let horizontalPaddingLow = 2.0
private let horizontalPadding = 8.0

struct RestaurantPhotosView: View {
    
    @State var gridViewMode = "grid"
    @State var shouldShowFullScreenModal = false
    @State var selectedPhotoIndex = 0
    
    init(){
        
        // this changes every UISegmentedControl in your app
        UISegmentedControl.appearance().backgroundColor = .black
        UISegmentedControl.appearance().selectedSegmentTintColor = .orange
        
        let titleTextAttribute = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UISegmentedControl.appearance().setTitleTextAttributes(titleTextAttribute, for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes(titleTextAttribute, for: .normal)
        
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            ScrollView{
                
                Picker("TEST", selection: $gridViewMode) {
                    Text("Grid").tag("grid")
                    Text("List").tag("list")
                }.pickerStyle(SegmentedPickerStyle())
                    .padding()
            
                Spacer()
                    .fullScreenCover(isPresented: $shouldShowFullScreenModal, content: {
                        ZStack(alignment: .topLeading){
                            Color.black.ignoresSafeArea()
                            
                            RestarurantCarouselView(imageUrlStrings: photosUrlStrings,selectedIndex: selectedPhotoIndex)
                            
                            Button(action: {
                                shouldShowFullScreenModal.toggle()
                            }, label: {
                                Image(systemName: "xmark")
                                    .asText(size: fontSize, weight: .bold)
                                    .foregroundStyle(.white)
                                    .padding()
                            })
                        }
                    }).opacity(shouldShowFullScreenModal ? 1 : 0)
                
                if gridViewMode == "grid" {
                    LazyVGrid(columns: [
                        GridItem(.adaptive(minimum: geometry.size.width / 3 - 4, maximum: 300),spacing: ViewSize.spacingLowest)
                        
                    ], spacing: ViewSize.spacingLow, content: {
                        
                        ForEach(photosUrlStrings, id: \.self){ photo in
                            
                            Button(action: {
                                self.selectedPhotoIndex = photosUrlStrings.firstIndex(of: photo) ?? 0
                                shouldShowFullScreenModal.toggle()
                            }, label: {
                                KFImage(URL(string: photo))
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: geometry.size.width / 3 - 3,height: geometry.size.width / 3)
                                    .clipped()
                            })
                             
                        }
                    }).padding(.horizontal, horizontalPaddingLow)
                }
                
                else {
                    ForEach(photosUrlStrings, id: \.self){ photo in
                        VStack(alignment: .leading, spacing: ViewSize.spacingNormal) {
                            KFImage(URL(string: photo))
                                .resizable()
                            .scaledToFill()
                            
                            HStack{
                                Image(systemName: "heart")
                                Image(systemName: "bubble.right")
                                Image(systemName: "paperlane")
                                Spacer()
                                Image(systemName: "bookmark")
                            }.padding(.horizontal, horizontalPadding)
                                .font(.system(size: fontSizeLow))
                            
                            Text("Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries.")
                                .font(.system(size: FontSizes.caption2))
                                .padding(.horizontal, horizontalPadding)
                        
                            Text("Posted on 11/4/20").font(.system(size: FontSizes.caption2))
                                .padding(.horizontal, horizontalPadding)
                                .font(.system(size: FontSizes.caption2))
                                .foregroundStyle(.gray)
                            
                            
                        }.padding(.bottom)
                    }
                }
            }
        }.navigationTitle("All Photos").navigationBarTitleDisplayMode(.inline)
    }
    
    let photosUrlStrings = [
        "https://letsbuildthatapp-videos.s3.us-west-2.amazonaws.com/e2f3f5d4-5993-4536-9d8d-b505d7986a5c",
        "https://letsbuildthatapp-videos.s3.us-west-2.amazonaws.com/a4d85eff-4c79-4141-a0d6-761cca48eae1",
        "https://letsbuildthatapp-videos.s3.us-west-2.amazonaws.com/20a6783b-3de7-4e58-9e22-bcc6a43b6df6",
        "https://letsbuildthatapp-videos.s3.us-west-2.amazonaws.com/0d1d2e79-2f10-4cfd-82da-a1c2ab3638d2",
        "https://letsbuildthatapp-videos.s3.us-west-2.amazonaws.com/3923d237-3931-44e5-836f-5de40ec04b31",
        "https://letsbuildthatapp-videos.s3.us-west-2.amazonaws.com/254c0418-2b55-4a2b-b530-a31a9799c7d5",
        "https://letsbuildthatapp-videos.s3.us-west-2.amazonaws.com/fa20d064-b6d7-4df9-8f44-0f25f6ee5a19",
        "https://letsbuildthatapp-videos.s3.us-west-2.amazonaws.com/a441d22b-5324-4444-8ddf-22b99128838c",
        "https://letsbuildthatapp-videos.s3.us-west-2.amazonaws.com/6b5d013b-dc3b-4e5e-93d9-ec932f42aead",
        "https://letsbuildthatapp-videos.s3.us-west-2.amazonaws.com/a6de1d65-8fa3-4674-a6ce-a207b8f86b15",
        "https://letsbuildthatapp-videos.s3.us-west-2.amazonaws.com/5c6bc68c-a8a1-42ac-ab3a-947927826807",
        "https://letsbuildthatapp-videos.s3.us-west-2.amazonaws.com/a5e83c0c-c815-4129-bfd4-17e73fa1da78",
        "https://letsbuildthatapp-videos.s3.us-west-2.amazonaws.com/f6ee5fb7-b21b-42c1-b1d8-a455742d0247",
        "https://letsbuildthatapp-videos.s3.us-west-2.amazonaws.com/c22e8d9e-10f2-4559-8c81-375491295e84",
        "https://letsbuildthatapp-videos.s3.us-west-2.amazonaws.com/3a352f87-3dc1-4fa7-affe-fb12fa8691fe",
        "https://letsbuildthatapp-videos.s3.us-west-2.amazonaws.com/8ca76521-1f52-4043-8b86-d2a573342daf",
        "https://letsbuildthatapp-videos.s3.us-west-2.amazonaws.com/73f69749-f986-46ac-9b8b-d7b1d42bddc5"
    ]
}

#Preview {
    NavigationView{
        RestaurantPhotosView()
    }
    //    .toolbarRole(.navigationStack)
}
