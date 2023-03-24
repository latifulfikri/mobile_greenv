//
//  ContentView.swift
//  GreenV
//
//  Created by Fikri Yuwi on 3/20/23.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    @State public var page:String = "intro"
    
    var body: some View {
        
        if page == "intro" {
            IntroView()
        }
        
        if page == "home" {
            Home()
        }
        
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
