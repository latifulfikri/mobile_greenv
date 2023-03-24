//
//  Intro.swift
//  GreenV
//
//  Created by Fikri Yuwi on 3/22/23.
//

import SwiftUI

struct Intro: Identifiable {
    var id: String = UUID().uuidString
    var imageName: String
    var title: String
    var desc: String
}

var intros: [Intro] = [
    .init(imageName: "intro-camera", title: "Camera access", desc: "Allow this apps to access your phone camera"),
    .init(imageName: "intro-floor", title: "Surface", desc: "Make sure you have a surface as a floor or table"),
    .init(imageName: "intro-trashbin", title: "Select trash bin", desc: "Select trash bin and scan the card collection according to the selected trash bin"),
    .init(imageName: "intro-collection", title: "Click on object", desc: "Click the object that belongs to the selected trash bin"),
]
