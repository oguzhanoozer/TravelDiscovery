//
//  TileModifier.swift
//  TravelDiscoveryLTBA
//
//  Created by oguzhan on 16.05.2024.
//

import Foundation
import SwiftUI

extension View{
    func asTile() -> some View{
        modifier(TileModifier())
    }
}


struct TileModifier: ViewModifier{
    
    func body(content: Content) -> some View {
        content.background(.white)
            .cornerRadius(RadiusItems.radius)
            .shadow(color: .init(.sRGB, white: 0.8, opacity: 1),
                    radius: 4, x: 0.0, y: 2)
    }
    
}
