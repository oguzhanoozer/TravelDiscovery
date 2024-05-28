//
//  TextModifier.swift
//  TravelDiscoveryLTBA
//
//  Created by oguzhan on 28.05.2024.
//

import Foundation
import SwiftUI

extension View{
    func asText(size: Double, weight: Font.Weight) -> some View{
        modifier(TextModifier(size: size,weight: weight))
    }
}

struct TextModifier: ViewModifier {
    let size: Double
    let weight: Font.Weight
    
    func body(content: Content) -> some View {
        return
            content.font(.system(size: size, weight: weight))
    }
}
