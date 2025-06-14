//
//  CustomARViewRepresentable.swift
//  AR-Demo
//
//  Created by synapse on 12/6/25.
//

import SwiftUI

struct CustomARViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> CustomARView {
        return CustomARView()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) { }
}
