//
//  ContentView.swift
//  AR-Demo
//
//  Created by synapse on 12/6/25.
//

import SwiftUI

struct ContentView: View {
    @State private var modelName: [String] = [
        "slide",
        "toy_biplane_realistic",
        "LunarRover_English"
    ]
    
    var body: some View {
        CustomARViewRepresentable()
            .ignoresSafeArea()
            .overlay(alignment: .bottom) {
                ScrollView(.horizontal) {
                    HStack {
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
