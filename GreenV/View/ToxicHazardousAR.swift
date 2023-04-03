//
//  SwiftUIView.swift
//  GreenV
//
//  Created by Fikri Yuwi on 3/24/23.
//

import SwiftUI
import RealityKit

struct ToxicHazardousAR: View {
    @Environment(\.dismiss) private var dismiss
    
    @State public var correct:Bool = false
    @State public var wrong:Bool = false

    @State private var battery:Bool = false
    @State private var gas:Bool = false
    @State private var med:Bool = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .center) {
                ScanToxicHazardous(correct: $correct, wrong: $wrong, battery: $battery, gas: $gas, med: $med).edgesIgnoringSafeArea(.all)
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
                                Text("Yeay! this trash belong to toxic and hazardous trash")
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
                                Text("Oh no! this trash is not belong to toxic and hazardous trash")
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
                if ( battery && gas ) && med {
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

struct ScanToxicHazardous: UIViewRepresentable {
    
    @Binding var correct:Bool
    @Binding var wrong:Bool
    
    @Binding var battery:Bool
    @Binding var gas:Bool
    @Binding var med:Bool
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        if let thAnchor = try? TrashCollection.loadToxichazardousCollection() {
            
            arView.addCoaching()
            arView.scene.anchors.append(thAnchor)
            thAnchor.actions.wrongClicked.onAction = wrongModal(_:)
            thAnchor.actions.correctClicked.onAction = correctModal(_:)
            thAnchor.actions.clearClicked.onAction = clearClicked(_:)
            
            thAnchor.actions.batteryClicked.onAction = batteryClicked(_:)
            thAnchor.actions.gasClicked.onAction = gasClicked(_:)
            thAnchor.actions.medClicked.onAction = medClicked(_:)
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
    
    func batteryClicked(_ entity: Entity?) {
        battery = true
    }
    
    func gasClicked(_ entity: Entity?) {
        gas = true
    }
    
    func medClicked(_ entity: Entity?) {
        med = true
    }
    
}


struct ToxicHazardousAR_Previews: PreviewProvider {
    static var previews: some View {
        ToxicHazardousAR()
    }
}
