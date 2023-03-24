//
//  IntroView.swift
//  GreenV
//
//  Created by Fikri Yuwi on 3/22/23.
//

import SwiftUI

struct IntroView: View {
    @State var showWalkThroughScreen:Bool = false
    @State var currentStep:Int = 0
    var body: some View {
        NavigationView {
            ZStack {
                Color("background").ignoresSafeArea(.all)
                introScreen()
                walkThroughScreen()
                navbar()
            }
            .animation(.interactiveSpring(response: 1.1, dampingFraction: 0.85,blendDuration: 0.85), value: showWalkThroughScreen)
        }
    }
//    walk through screen
    @ViewBuilder
    func walkThroughScreen()->some View {
        let isLast = currentStep == intros.count - 1
        GeometryReader {
            let size = $0.size
            
            ZStack {
//                Color("text-theme").ignoresSafeArea(.all)
                ForEach(intros.indices, id:\.self) {
                    index in
                    screenView(size: size, id: index)
                }
                VStack {
                    Spacer()
                    if isLast {
                        NavigationLink(destination: Home()) {
                            Text("Get started")
                                .bold()
                                .padding(.horizontal,40)
                                .padding(.vertical,14)
                                .foregroundColor(.white)
                                .background {
                                    Capsule().fill(Color("text-theme"))
                                }
                        }
                        .scaleEffect(isLast ? 1 : 0)
                    }
                    if !isLast {
                        Image(systemName: "chevron.right")
                            .padding(.all,24)
                            .foregroundColor(.white)
                            .background {
                                Circle().fill(Color("text-theme"))
                            }
                            .onTapGesture {
                                if !isLast {
                                    currentStep += 1
                                }
                            }
                            .scaleEffect(isLast ? 0 : 1)
                    }
                }
                .frame(maxWidth: .infinity,maxHeight: .infinity)
                .padding(.bottom,16)
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .offset(y:showWalkThroughScreen ? 0 : size.height)
            .animation(.interactiveSpring(response: 0.5, dampingFraction: 0.8, blendDuration: 1), value: isLast)
        }
    }
    
    @ViewBuilder
    func screenView(size:CGSize,id:Int)->some View {
        let index = currentStep > (intros.count - 1) ? (intros.count - 1) : id
        let introItem = intros[index]
        VStack(spacing: 10) {
            Spacer()
            Image(introItem.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: size.width / 3*2, height: size.height / 3,alignment: .center)
                .offset(x: -size.width * CGFloat(currentStep - id))
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5), value: currentStep)
            Spacer()
            VStack(alignment: .center) {
                Text(introItem.title).font(.largeTitle.weight(.black)).foregroundColor(Color("text-theme")
                ).lineSpacing(0)
                    .padding(.bottom,4)
                .multilineTextAlignment(.center)
                Text(introItem.desc)
                    .multilineTextAlignment(.center)
                    .padding(.bottom,16)
            }
            .padding(.horizontal,42)
            .offset(x: -size.width * CGFloat(currentStep - id))
            .animation(.interactiveSpring(response: 0.5, dampingFraction: 0.8, blendDuration: 0.5), value: currentStep)
            Spacer()
        }
    }
    
//    navbar
    @ViewBuilder
    func navbar()->some View {
        let isLast = currentStep == intros.count - 1
        HStack {
            Button {
                if currentStep > 0 {
                    currentStep -= 1
                } else {
                    showWalkThroughScreen.toggle()
                }
            }label: {
                Image(systemName: "chevron.left")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(Color("text-theme"))
            }
            Spacer()
            if !isLast {
                NavigationLink(
                    destination: Home(),
                    label: {
                        Text("skip")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(Color("text-theme"))
                    }
                )
                .scaleEffect(isLast ? 0 : 1)
            }
        }
        .padding(32)
        .frame(maxHeight: .infinity,alignment: .top)
        .offset(y:showWalkThroughScreen ? 0 : -200)
        .animation(.interactiveSpring(response: 0.5, dampingFraction: 0.8, blendDuration: 0.5), value: currentStep)
    }
    
//    introscreen
    @ViewBuilder
    func introScreen()->some View {
        GeometryReader {
            let size = $0.size
            
            VStack(spacing: 10) {
                Image("intro-card")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: size.width / 3*2, height: size.height / 2,alignment: .center)
                    .padding(.top,75)
                Spacer()
                VStack(alignment: .center) {
                    Text("Welcome").font(.largeTitle.weight(.black)).foregroundColor(Color("text-theme")
                    ).lineSpacing(0)
                        .padding(.bottom,4)
                    Text("Welcome to Green V. Let's see how can you sort the trash correctly")
                        .multilineTextAlignment(.center)
                        .padding(.bottom,16)
                    Button {
                        showWalkThroughScreen.toggle()
                    }label: {
                        Text("Get started")
                            .bold()
                            .padding(.horizontal,40)
                            .padding(.vertical,14)
                            .foregroundColor(.white)
                            .background {
                                Capsule().fill(Color("text-theme"))
                        }
                    }
                }
                .padding(.horizontal,42)
                .padding(.bottom,56)
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
//            moving up
            .offset(y: showWalkThroughScreen ? -size.height : 0)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(.all)
    }

}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
    }
}
