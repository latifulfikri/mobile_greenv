//
//  Home.swift
//  GreenV
//
//  Created by Fikri Yuwi on 3/22/23.
//

import SwiftUI

struct Home: View {
    var body: some View {
        NavigationView {
            ZStack{
                Color("background").ignoresSafeArea(.all)
                ScrollView(showsIndicators: false) {
                    VStack {
                        PageTitle(title: "Select a\nTrash Bin")
                        VStack(alignment: .leading) {
                            MainButton(text: "Organic", des: Scan())
                        }
                    }
                }
            }
        }
        .navigationBarHidden(true)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

func PageTitle(title:String)->some View{
    HStack {
        VStack(alignment: .leading) {
            Text(title).font(.largeTitle).foregroundColor(Color("text-theme"))
                .fontWeight(.black)
        }
    }.frame(maxWidth: .infinity,alignment: .leading)
        .padding(24)
}

func HowToPoint(num:Int,text:String)-> some View{
    HStack(alignment: .top) {
        ZStack(alignment: .center) {
            Circle().frame(width: 32,height: 32).foregroundColor(.white)
            Text(num.codingKey.stringValue)
        }
        VStack(alignment: .leading) {
            Text(text)
        }.padding(.leading,16)
    }.padding(.bottom,16)
}

func MainButton(text:String,des:some View)->some View {
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
                        Text(text).font(.title.bold()).padding(.leading,32)
                        Spacer()
                        RoundedRectangle(cornerRadius: 24)
                            .frame(width: 64,height: 64).padding(16)
                            .overlay(
                                Image(systemName: "play.fill").foregroundColor(Color.white)
                            )
                    }
                }
            }
        ).padding(.horizontal,24)
    }
}
