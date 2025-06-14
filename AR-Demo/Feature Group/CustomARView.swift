//
//  CustomARView.swift
//  AR-Demo
//
//  Created by synapse on 12/6/25.
//

import ARKit
import RealityKit
import SwiftUI
import Combine

class CustomARView: ARView {
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
    }
    
    dynamic required init?(coder decoder: NSCoder) {
        fatalError("init (coder) has not been implemented.")
    }
    
    convenience init() {
        self.init(frame: UIScreen.main.bounds)
        
        subscribe2ActionStream()
    }
    
    func configurationSetup() {
        let configuration = ARWorldTrackingConfiguration()
        session.run(configuration)
    }
    
    private var cancellables: Set<AnyCancellable> = []
    
//    Combine 机制 订阅按钮的消息
    func subscribe2ActionStream() {
        ARManager.shared
            .actionStream
            .sink{ [weak self] action in
                switch action {
                case .placeModel(let name):
                    self?.placeModel(ofname: name)
                case .removeAllAnchors:
                    self?.scene.anchors.removeAll()
                }
            }
            .store(in: &cancellables)
    }
    
    func placeModel(ofname name: String) {
        let block = MeshResource.generateBox(size: 1.0)
        let material = SimpleMaterial(color: .green, isMetallic: false)
        let greenBlock = ModelEntity(mesh: block, materials: [material])
        
        let planeAnchor = AnchorEntity(plane: .horizontal)

        
        if let slideEntity = try? Entity.load(named: name){
            planeAnchor.addChild(slideEntity)
        } else {
            planeAnchor.addChild(greenBlock)
        }
    
        scene.addAnchor(planeAnchor)
    }
}
