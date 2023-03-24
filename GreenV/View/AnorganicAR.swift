//
//  AnorganicAR.swift
//  GreenV
//
//  Created by Fikri Yuwi on 3/24/23.
//

import SwiftUI
import RealityKit

struct AnorganicAR: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State public var correct:Bool = false
    @State public var wrong:Bool = false
    @State public var stop:Bool = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                ScanAnorganic(correct: $correct, wrong: $wrong,stop: $stop).edgesIgnoringSafeArea(.all)
                if correct {
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
                            ).frame(height: 96)
                    )
                    .padding(.top,96)
                }
                if wrong {
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
                            ).frame(height: 96)
                    )
                    .padding(.top,96)
                }
                VStack {
                    Spacer()
                    Button {
                        stop = true
                        presentationMode.wrappedValue.dismiss()
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
    @Binding var stop:Bool
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        if let anorganicAnchor = try? TrashCollection.loadAnorganicCollection() {
            
            arView.scene.anchors.append(anorganicAnchor)
            anorganicAnchor.actions.wrongClicked.onAction = wrongModal(_:)
            anorganicAnchor.actions.correctClicked.onAction = correctModal(_:)
            anorganicAnchor.actions.clearClicked.onAction = clearClicked(_:)
        }
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
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
    
}


struct AnorganicAR_Previews: PreviewProvider {
    static var previews: some View {
        AnorganicAR()
    }
}
