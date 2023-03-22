//
//  Scan.swift
//  GreenV
//
//  Created by Fikri Yuwi on 3/20/23.
//

import SwiftUI
import RealityKit


struct Scan: View {
    var body: some View {
        ScanBurger().edgesIgnoringSafeArea(.all)
    }
}

struct ScanBurger: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        // Load the "Box" scene from the "Experience" Reality File
        let boxAnchor = try! Experience.loadBox()
        
        let leafAnchor = try! Leaf.loadBox()
        
        // Add the box anchor to the scene
        arView.scene.anchors.append(boxAnchor)
        arView.scene.anchors.append(leafAnchor)
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

struct Scan_Previews: PreviewProvider {
    static var previews: some View {
        Scan()
    }
}
