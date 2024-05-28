//
//  Images.swift
//  TravelDiscoveryLTBA
//
//  Created by oguzhan on 15.05.2024.
//

import Foundation
import SwiftUI

enum Images: String{
    case eiffel = "eiffel_tower"
    case japan = "japan"
    case new_york = "new_york"
}


extension String{
    func images() -> Image{
        return Image(self)
    }
}
