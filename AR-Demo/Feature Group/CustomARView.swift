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
        configurationSetup()
        subscribe2ActionStream()
    }
    
    func configurationSetup() {
        let trackingConfiguration = ARImageTrackingConfiguration()
        
        if let trackedImage = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: Bundle.main) {
            trackingConfiguration.trackingImages = trackedImage
            trackingConfiguration.maximumNumberOfTrackedImages = 1
            
            print("Image tracked!")
        }
        
        session.run(trackingConfiguration)
    }
    
    
    private var cancellables: Set<AnyCancellable> = []
    private static var countEntity: Int = 0
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
                    Self.countEntity = 0
                }
            }
            .store(in: &cancellables)
    }
    
    func placeModel(ofname name: String) {
        let block = MeshResource.generateBox(size: 1.0)
        let material = SimpleMaterial(color: .green, isMetallic: false)
        let greenBlock = ModelEntity(mesh: block, materials: [material])
        
        var realAnchor = AnchorEntity(plane: .horizontal)
        
        
        
//        let node = SCNNode()
        
//        if let imageAnchor = anchor as? ARImageAnchor {
//            
//            let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
//            
//            plane.firstMaterial?.diffuse.contents = UIColor(width: 1.0, alpha: 0.2)
//        }
        
        let imageAnchor = AnchorEntity(.image(group: "AR Resources", name: "mintsmarker"))
        realAnchor = imageAnchor

//        let _ = AnchorEntity(plane: .horizontal)

        
        if let modelEntity = try? Entity.load(named: name){
            realAnchor.addChild(modelEntity)
            Self.countEntity += 1
        } else {
            realAnchor.addChild(greenBlock)
        }
    
        scene.addAnchor(realAnchor)
    }
}
