//
//  ARManager.swift
//  AR-Demo
//
//  Created by synapse on 12/6/25.
//

import Combine

class ARManager {
    static let shared = ARManager()
    private init() { }
    
    var actionStream = PassthroughSubject<ARActions, Never>()
}
