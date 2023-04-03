//
//  AnorganicAR.swift
//  GreenV
//
//  Created by Fikri Yuwi on 3/24/23.
//

import SwiftUI
import RealityKit

struct AnorganicAR: View {
    @Environment(\.dismiss) private var dismiss
    
    @State public var correct:Bool = false
    @State public var wrong:Bool = false
    
    @State private var tube:Bool = false
    @State private var pipet:Bool = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .center) {
                ScanAnorganic(correct: $correct, wrong: $wrong,tube: $tube, pipet: $pipet).edgesIgnoringSafeArea(.all)
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
                                Text("Yeay! this trash belong to anorganic trash")
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
                                Text("Oh no! this trash is not belong to anorganic trash")
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
                        dismiss()
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
                if pipet && tube {
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

struct ScanAnorganic: UIViewRepresentable {
    
    @Binding var correct:Bool
    @Binding var wrong:Bool
    
    @Binding var tube:Bool
    @Binding var pipet:Bool
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        if let anorganicAnchor = try? TrashCollection.loadAnorganicCollection() {
            
            arView.addCoaching()
            arView.scene.anchors.append(anorganicAnchor)
            anorganicAnchor.actions.wrongClicked.onAction = wrongModal(_:)
            anorganicAnchor.actions.correctClicked.onAction = correctModal(_:)
            anorganicAnchor.actions.clearClicked.onAction = clearClicked(_:)
            
            anorganicAnchor.actions.pipetClicked.onAction = pipetClicked(_:)
            anorganicAnchor.actions.tubeClicked.onAction = tubeClicked(_:)
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
    
    func tubeClicked(_ entity: Entity?) {
        tube = true
    }
    
    func pipetClicked(_ entity: Entity?) {
        pipet = true
    }
    
}


struct AnorganicAR_Previews: PreviewProvider {
    static var previews: some View {
        AnorganicAR()
    }
}
