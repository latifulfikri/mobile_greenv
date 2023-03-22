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
    .init(imageName: "intro-card", title: "Get card", desc: "You can contact owner to get card collection"),
    .init(imageName: "intro-camera", title: "Allow camera access", desc: "Allow this apps to access your phone camera"),
    .init(imageName: "intro-trashbin", title: "Select trash bin", desc: "Select trash bin and scan the card collection according to the selected trash bin")
]
