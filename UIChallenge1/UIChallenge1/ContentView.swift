//
//  ContentView.swift
//  UIChallenge1
//
//  Created by saliou seck on 25/03/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Image(.lake)
                .resizable()
                .scaledToFit()
            HStack{
                VStack(alignment: .leading) {
                    Text("Hello, Lake Campground!")
                    Text("Dakar , Sénégal")
                }
                Spacer()
                HStack{
                    Image(systemName: "star.fill" )
                        .foregroundStyle(.orange)
                    Text("41")
                }
            }.padding()
            HStack{
                Spacer()
                VStack{
                    Image(systemName: "phone.fill")
                        .imageScale(.large)
                    Text("CALL")
                        .padding(4)
                }
                Spacer()
                VStack{
                    Image(systemName: "location.fill")
                        .imageScale(.large)
                    Text("ROUTE")
                        .padding(4)
                }
                Spacer()
                VStack{
                    Image(systemName: "square.and.arrow.up.fill")
                        .imageScale(.large)
                    Text("SHARE")
                        .padding(4)
                }
                
                Spacer()
                
            }
            .foregroundStyle(.blue)
            .padding()
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum")
                .font(.body)
                .padding()
            Spacer()
        }
    }
}

#Preview {
    ContentView()
}
