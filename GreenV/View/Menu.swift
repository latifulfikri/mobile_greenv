//
//  Menu.swift
//  GreenV
//
//  Created by Fikri Yuwi on 3/21/23.
//

import SwiftUI

struct Menu: View {
    var body: some View {
        NavigationView {
            ZStack{
                Color("background").ignoresSafeArea(.all)
                ScrollView(showsIndicators: false) {
                    VStack {
                        PageTitle(title: "Select\nTrash Bin")
                        VStack(alignment: .leading) {
                            MenuButton(text: "Organic", des: Scan(),priColor:Color("green-primary"),secColor: Color("green-secondary"))
                            MenuButton(text: "Anorganic", des: Scan(),priColor:Color("yellow-primary"),secColor: Color("yellow-secondary"))
                            MenuButton(text: "Toxic and Hazardus", des: Scan(),priColor:Color("red-primary"),secColor: Color("red-secondary"))
                        }.padding(24)
                    }
                }
            }
        }
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}

func MenuButton(text:String,des:some View, priColor:Color,secColor:Color)->some View {
    VStack {
        NavigationLink(
            destination: des,
            label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 26)
                        .fill(
                            Color.white
                        ).frame(height: 96)
                    HStack {
                        Text(text).font(.title.bold()).padding(.leading,32).foregroundColor(priColor)
                        Spacer()
                        RoundedRectangle(cornerRadius: 24)
                            .frame(width: 64,height: 64).padding(16)
                            .overlay(
                                Image(systemName: "play.fill").foregroundColor(priColor)
                            )
                            .foregroundColor(secColor)
                    }
                }
            }
        )
    }
}
