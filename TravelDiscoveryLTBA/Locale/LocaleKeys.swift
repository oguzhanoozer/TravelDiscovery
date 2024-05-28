//
//  LocaleKeys.swift
//  TravelDiscoveryLTBA
//
//  Created by oguzhan on 15.05.2024.
//

import Foundation
import SwiftUI

enum LocaleKeys{
    
    enum Discover: String{
        case discover
        case seeAll
        case popularDestination
        case popularPlacesToEat
        case trendingCreators
    }
    
}

extension String{
    func locale() -> LocalizedStringKey{
        return LocalizedStringKey(self)
    }
}
