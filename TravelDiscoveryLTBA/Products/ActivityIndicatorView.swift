//
//  ActivityIndicator.swift
//  TravelDiscoveryLTBA
//
//  Created by oguzhan on 16.05.2024.
//

import Foundation
import SwiftUI

struct ActivityIndicatorView: UIViewRepresentable{
   
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let aiv = UIActivityIndicatorView(style: .large)
        aiv.startAnimating()
        aiv.color = .white
        return aiv
    }
    
    typealias UIViewType = UIActivityIndicatorView
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        
    }
    
}
