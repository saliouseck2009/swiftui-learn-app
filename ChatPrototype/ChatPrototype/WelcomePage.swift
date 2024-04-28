//
//  WelcomePage.swift
//  ChatPrototype
//
//  Created by saliou seck on 16/04/2024.
//

import SwiftUI

struct WelcomePage: View {
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 150, height: 150)
                .foregroundStyle(.tint)
                Image(systemName: "pencil.circle")
                    .font(.system(size: 70))
                    .foregroundStyle(.white)
            }
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .font(.title)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .fontWidth(.expanded)
            .fontDesign(.rounded)
            .padding([.top, ])
            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 1.5)
            Text("Add a description below the title using another text view and a font modifier of your choice")
                .font(.title2)
                .multilineTextAlignment(.leading)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 1.5)
        }
        .border(.orange)
        .padding()
        .border(.green)
    }
}

#Preview {
    WelcomePage()
}
