//
//  ContentView.swift
//  AR-Demo
//
//  Created by synapse on 12/6/25.
//

import SwiftUI

struct ContentView: View {
    @State private var modelName: [String] = [
        "drummer",
        "biplane_realistic",
        "hummingbird_anim",
        "LunarRover_English.reality"
    ]
    
    var body: some View {
        let columns = [
            GridItem(.adaptive(minimum: 80), spacing: 12)
        ]
        CustomARViewRepresentable()
            .ignoresSafeArea()
            .overlay(alignment: .bottom) {
                ScrollView(.horizontal) {
                    LazyVGrid(columns: columns, spacing: 12) {
                        Button {
                            ARManager.shared.actionStream.send(.removeAllAnchors)
                        } label: { 
                            Image(systemName: "trash")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .padding()
                                .background(.regularMaterial)
                                .cornerRadius(16)
                        }
                        ForEach(modelName, id: \.self) { model in
                            Button {
                                ARManager.shared.actionStream.send(.placeModel(name: model))
                            } label: {
                                Text(model.components(separatedBy: "_").first ?? model)
                                    .frame(width: 50, height: 40)
                                    .padding()
                                    .background(.regularMaterial)
                                    .cornerRadius(16)
                            }
                        }
                    }
                    .padding()
                }
            }
    }
}

#Preview {
    ContentView()
}
