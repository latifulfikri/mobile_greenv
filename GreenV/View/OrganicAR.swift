//
//  Scan.swift
//  GreenV
//
//  Created by Fikri Yuwi on 3/20/23.
//

import SwiftUI
import RealityKit
import ARKit

extension ARView: ARCoachingOverlayViewDelegate {
    func addCoaching() {
        let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.delegate = self
        #if !targetEnvironment(simulator)
        coachingOverlay.session = self.session
        #endif
        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        coachingOverlay.goal = .horizontalPlane
        self.addSubview(coachingOverlay)
    }

    public func coachingOverlayViewDidDeactivate(_ coachingOverlayView: ARCoachingOverlayView) {
        print("did deactivate")
    }
}

struct OrganicAR: View {
    @Environment(\.dismiss) private var dismiss
    
    @State public var correct:Bool = false
    @State public var wrong:Bool = false
    
    @State private var leaf:Bool = false
    @State private var burger:Bool = false
    @State private var paperbag:Bool = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .center) {
                ScanOrganic(correct: $correct, wrong: $wrong, leaf: $leaf, burger: $burger, paperbag: $paperbag).edgesIgnoringSafeArea(.all)
                if correct {
                    VStack {
                        HStack {
                            Image(systemName: "checkmark.seal.fill")
                                .padding(.leading,24)
                                .font(.largeTitle)
                                .foregroundColor(Color("green-primary"))
                            VStack(alignment: .leading) {
                                Text("Corrrect!")
                                    .fontWeight(.black)
                                    .foregroundColor(Color("text-primary"))
                                Text("Yeay! this trash belong to organic trash")
                            }.padding(24)
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 26)
                                .fill(
                                    Color.white
                                )
                        )
                    }
                    .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .top)
                    .padding(.vertical,24)
                    .padding(.horizontal,24)
                }
                if wrong {
                    VStack {
                        HStack {
                            Image(systemName: "x.circle.fill")
                                .padding(.leading,24)
                                .font(.largeTitle)
                                .foregroundColor(Color("red-primary"))
                            VStack(alignment: .leading) {
                                Text("Wrong!")
                                    .fontWeight(.black)
                                    .foregroundColor(Color("text-primary"))
                                Text("Oh no! this trash is not belong to organic trash")
                            }.padding(24)
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 26)
                                .fill(
                                    Color.white
                                )
                        )
                    }
                    .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .top)
                    .padding(.vertical,24)
                    .padding(.horizontal,24)
                }
                VStack {
                    Spacer()
                    Button {
                        
//                        arView.session.pause()
//                        arView.removeFromSuperview()
//
//                        arView.session.run(arView.session.configuration!,options: [.resetSceneReconstruction])
                        
                        dismiss()
                        
//                        scene.organicTrashBin?.stopAllAudio()
//                        scene.organicTrashBin?.stopAllAnimations()
//
//                        completion = {
//                            $0?.stopAllAudio()
//                            $0?.stopAllAnimations()
//                        }                        
                        
//                        arView.scene.removeAnchor(scene)
                        
                        
                        
//                        scene.actions.stopMusic.onAction = completion
                        
                        print("stop music")
                    }label: {
                        Text("go back")
                            .bold()
                            .padding(.horizontal,40)
                            .padding(.vertical,14)
                            .foregroundColor(.white)
                            .background {
                                Capsule().fill(Color("text-theme"))
                            }
                        }
                }
                if ( leaf && burger ) && paperbag {
                    VStack {
                        VStack {
                            Image(systemName: "checkmark.seal.fill")
                                .font(.largeTitle)
                                .foregroundColor(Color("green-primary"))
                            VStack(alignment: .center) {
                                Text("You did it!")
                                    .font(.title)
                                    .fontWeight(.black)
                                    .foregroundColor(Color("text-primary"))
                                Text("Your trash-sorting skills are truly top-notch, and you should be proud of yourself for taking care of our planet like a true eco-warrior! ")
                                    .multilineTextAlignment(.center)
                            }.padding(.vertical,24)
                            Button {
                                dismiss()
                            }label: {
                                Text("Try another trash bin")
                                    .bold()
                                    .padding(.horizontal,40)
                                    .padding(.vertical,14)
                                    .foregroundColor(.white)
                                    .background {
                                        Capsule().fill(Color("text-theme"))
                                    }
                            }
                        }
                        .padding(24)
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 26)
                                .fill(
                                    Color.white
                                )
                        )
                    }
                    .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .center)
                    .padding(.vertical,24)
                    .padding(.horizontal,24)
                }
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
//                    .padding(.bottom,42)
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
            .ignoresSafeArea(.all)
            .toolbar(.hidden)
    }
    
}

struct ScanOrganic: UIViewRepresentable {
    
    @Binding var correct:Bool
    @Binding var wrong:Bool
    
    @Binding var leaf:Bool
    @Binding var burger:Bool
    @Binding var paperbag:Bool
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        if let scene = try? TrashCollection.loadOrganicCollection() {
            arView.addCoaching()
            arView.scene.anchors.append(scene)
            scene.actions.wrongClicked.onAction = wrongModal(_:)
            scene.actions.correctClicked.onAction = correctModal(_:)
            scene.actions.clearClicked.onAction = clearClicked(_:)
            
            scene.actions.leafClicked.onAction = leafClicked(_:)
            scene.actions.burgerClicked.onAction = burgerClicked(_:)
            scene.actions.paperbagClicked.onAction = paperbagClicked(_:)
        }
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {

    }
    
    func correctModal(_ entity: Entity?) {
        correct = true
        wrong = false
    }
    
    func wrongModal(_ entity: Entity?) {
        wrong = true
        correct = false
    }
    
    func clearClicked(_ entity: Entity?) {
        correct = false
        wrong = false
    }
    
    func leafClicked(_ entity: Entity?) {
        leaf = true
    }
    
    func paperbagClicked(_ entity: Entity?) {
        paperbag = true
    }
    
    func burgerClicked(_ entity: Entity?) {
        burger = true
    }
    
}

struct Scan_Previews: PreviewProvider {
    static var previews: some View {
        OrganicAR()
    }
}
