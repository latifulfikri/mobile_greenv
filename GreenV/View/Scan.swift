//
//  Scan.swift
//  GreenV
//
//  Created by Fikri Yuwi on 3/20/23.
//

import SwiftUI
import RealityKit


struct Scan: View {
    @State public var correct:Bool = false
    @State public var wrong:Bool = false
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                ScanBurger(correct: $correct, wrong: $wrong).edgesIgnoringSafeArea(.all)
                if correct {
                    HStack {
                        Image(systemName: "cursorarrow.click.2")
                            .padding(.leading,24)
                            .font(.largeTitle)
                            .foregroundColor(Color("green-primary"))
                        VStack(alignment: .leading) {
                            Text("Click on object")
                                .fontWeight(.black)
                                .foregroundColor(Color("text-primary"))
                            Text("To check if you scan the right card")
                        }.padding(24)
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 26)
                            .fill(
                                Color.white
                            ).frame(height: 96)
                    )
                    .padding(.top,96)
                }
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
            .ignoresSafeArea(.all)
        }
    }
    
}

struct ScanBurger: UIViewRepresentable {
    @Binding var correct:Bool
    @Binding var wrong:Bool
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        
        // Load the "Box" scene from the "Experience" Reality File
        if let boxAnchor = try? Experience.loadBox() {
            arView.scene.anchors.append(boxAnchor)
            self.correct = true
        } else {
            self.correct = false
        }
        
        let leafAnchor = try! Leaf.loadBox()
        
        // Add the box anchor to the scene
        
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
