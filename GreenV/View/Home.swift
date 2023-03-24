//
//  Home.swift
//  GreenV
//
//  Created by Fikri Yuwi on 3/22/23.
//

import SwiftUI

struct Home: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ZStack{
                Color("background").ignoresSafeArea(.all)
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
                        PageTitle(title: "Select a\nTrash Bin")
                            .padding(.top,32)
                        Text("Can you identify the correct trash can in our menu below? Let's put your skills to the test and see if you can pick the right one!")
                            .padding(.horizontal,32)
                            .padding(.bottom,16)
                        VStack(alignment: .leading) {
                            MainButton(text: "Organic", des: OrganicAR(),color: "green", image: "trashbin-organic")
                            MainButton(text: "Anorganic", des: AnorganicAR(),color: "yellow", image: "trashbin-anorganic")
                            MainButton(text: "Toxic and Hazardous", des: ToxicHazardousAR(),color: "red", image: "trashbin-th")
                        }
                        HStack {
                            Button {
                                presentationMode.wrappedValue.dismiss()
                            }label: {
                                Text("Back to tutorial")
                                    .bold()
                                    .padding(.horizontal,40)
                                    .padding(.vertical,14)
                                    .foregroundColor(.white)
                                    .background {
                                        Capsule().fill(Color("text-theme"))
                                    }
                            }
                        }.frame(maxWidth: .infinity, alignment: .center)
                            .padding(.all,32)
                    }
                }
            }
        }
        .toolbar(.hidden)
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
            Text(title).font(.title).foregroundColor(Color("text-theme"))
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

func MainButton(text:String,des:some View,color:String,image:String)->some View {
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
                        Image(image)
                            .resizable()
                            .frame(width: 92,height: 92)
                            .padding(.leading,16)
                        Text(text).font(.title3.bold())
                            .foregroundColor(Color(color+"-primary"))
                            .multilineTextAlignment(.leading)
                        Spacer()
                        RoundedRectangle(cornerRadius: 24)
                            .frame(width: 64,height: 64).padding(16)
                            .overlay(
                                Image(systemName: "play.fill").foregroundColor(Color(color+"-primary"))
                            )
                            .foregroundColor(Color(color+"-secondary"))
                    }
                }
            }
        ).padding(.horizontal,24)
    }
}
