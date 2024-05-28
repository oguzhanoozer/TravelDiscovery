//
//  PopularDestinationDetailView.swift
//  TravelDiscoveryLTBA
//
//  Created by oguzhan on 18.05.2024.
//

import SwiftUI
import MapKit

private let paddingLow = 2.0
private let frameHeight = 300.0
private let photoFrameHeight = 350.0
private let latitudeDelta = 0.4
private let longtitudeDelta = 0.4


struct PopularDestinationDetailsView: View {
    
    @ObservedObject var destinationVM : DestinationDetailsViewModel
    let destination: Destination
    
    @State var region: MKCoordinateRegion
    @State var isShowAttractions = true
    
    init(destination: Destination){
        self.destination = destination
        self._region = State(initialValue: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: destination.latitude, longitude: destination.longtitude), 
                                                              span: .init(latitudeDelta: latitudeDelta, longitudeDelta: longtitudeDelta)))
        
        destinationVM = .init()
}
    
    var body: some View {
        ScrollView{
            
            if let photos = destinationVM.destinationDetails?.photos {
                DestinationHeaderContainer(imageUrlStrings:  photos)
                    .frame(height: photoFrameHeight)
            }
            
            VStack(alignment: .leading) {
                Text(destination.name)
                    .asText(size: FontSizes.caption3,weight: .bold)
                Text(destination.country)
                HStack{
                    ForEach(0..<5, id: \.self){ num in
                        Image(systemName: "star.fill")
                            .foregroundStyle(.orange)
                    }
                }.padding(.top, paddingLow)
                
                Text(destinationVM.destinationDetails?.description ?? "")
                    .padding(.top, PagePadding.All.low.rawValue)
                    .asText(size: FontSizes.caption3,weight: .semibold)

                HStack{
                    Text("Location")
                        .asText(size: FontSizes.caption3,weight: .semibold)

                    Spacer()
                    
                    Button(action: {
                        isShowAttractions.toggle()
                    }, label: {
                        Text("\(isShowAttractions ? "Hide" : "Show") Attraction")
                            .asText(size: FontSizes.caption2,weight: .semibold)
                    })
                    
                    Toggle("", isOn: $isShowAttractions).labelsHidden()
                }
            }
            .padding(.horizontal)
            
            Map(initialPosition: .region(region)){
                ForEach(isShowAttractions ? Attraction.attractions : []){attraction in
                    Annotation(attraction.name, coordinate: attraction.coordinate) {
                        CustomMapAnnotationView(attraction: attraction)
                    }.annotationTitles(.hidden)
                }
            }.frame(height: frameHeight).mapStyle(.standard)
            
        }.navigationTitle(destination.name)
            .navigationBarTitleDisplayMode(.inline)
            .task {
                await destinationVM.onDestinationDetail(name: destination.name)
            }
    }

}

#Preview {
    PopularDestinationDetailsView(destination: Destination(name: "Paris", country: "France", image: "eiffel_tower",latitude: 48.8584345, longtitude: 2.0352526))
}
