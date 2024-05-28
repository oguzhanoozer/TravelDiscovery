//
//  NavigationLazyView.swift
//  TravelDiscoveryLTBA
//
//  Created by oguzhan on 19.05.2024.
//

import SwiftUI

struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}
