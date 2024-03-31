//
//  ContentView.swift
//  Navigation
//
//  Created by saliou seck on 16/03/2024.
//

import SwiftUI



struct SecondPage : View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        Text("You are in Second page")
        Button("Go Back") {
            dismiss()
        }
    
        
    }
}

struct ContentView: View {
    @State private var showingSheet = false
    @State var path = [Int]()
    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 16) {
                NavigationLink("with Nav Dest", value: "from fist page 1")
                    .navigationDestination(for: String.self) { args in
                            VStack{
                                Text("You are in detail page")
                                Text("Here is the arg: \(args)")
                            }
                            
                        }
                Button("Go to Second Path "){
                    path.append(1)
                }
               
                Button("Go to next page"){
                    showingSheet = true
                }
                    .sheet(isPresented: $showingSheet, content: {
                        SecondPage()
                    })
            
            }
            .navigationDestination(for: Int.self, destination: { arg in
                VStack{
                    Text("Second page with path")
                        .foregroundStyle(.primary)
                        .font(.caption.bold())
                }
            })
            .navigationTitle("First Page")
                
        }
    }
}

#Preview {
    ContentView()
}


