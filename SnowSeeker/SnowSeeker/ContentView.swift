//
//  ContentView.swift
//  SnowSeeker
//
//  Created by saliou seck on 05/05/2024.
//

import SwiftUI

enum TriType {
    case defaultTri, alphabetical, country
}

struct ContentView: View {
    var resorts: [Resort] = Bundle.main.decode("resorts.json")
    @State private var searchText = ""
    @State private var favorites = Favorites()
    @State private var selectedItem = TriType.defaultTri
    var filteredResorts : [Resort] {
        if searchText.isEmpty {
            return resorts
        }else{
            return resorts.filter{
                $0.name.localizedStandardContains(searchText)
            }
        }
    }
    var sortedList : [Resort] {
        if(selectedItem == TriType.country){
            let sortedlist = filteredResorts.sorted { r1, r2 in
                return r1.country > r2.country
            }
            return sortedlist
        }else if (selectedItem == TriType.alphabetical){
            let sortedlist = filteredResorts.sorted { r1, r2 in
                return r1.name < r2.name
            }
            return sortedlist
        }else{
            let sortedlist = filteredResorts.sorted { r1, r2 in
                return r1.id > r2.id
            }
            return sortedlist
        }
    }
        var body: some View {
            
            NavigationSplitView {
                Picker("Trie", selection: $selectedItem){
                   Text("Default").tag(TriType.defaultTri)
                    Text("By country").tag(TriType.country)
                    Text("alpha").tag(TriType.alphabetical)
                }.pickerStyle(.segmented)
                List(sortedList) { resort in
                    NavigationLink(value: resort) {
                        HStack {
                            Image(resort.country)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 40, height: 25)
                                .clipShape(
                                    .rect(cornerRadius: 5)
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(.black, lineWidth: 1)
                                )

                            VStack(alignment: .leading) {
                                Text(resort.name)
                                    .font(.headline)
                                Text("\(resort.runs) runs")
                                    .foregroundStyle(.secondary)
                            }
                            if favorites.contains(resort) {
                                Spacer()
                                Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a favorite resort")
                                    .foregroundStyle(.red)
                            }
                        }
                    }
                    
                }
                
                .navigationTitle("Resorts")
                .navigationDestination(for: Resort.self) { resort in
                    ResortView(resort: resort)
                }
                .searchable(text: $searchText, prompt: "Search for a resort")
                
            } detail: {
                WelcomeView()
            }
            .environment(favorites)
        }
}

#Preview {
    ContentView()
}


struct WelcomeView: View {
    var body: some View {
        VStack {
            Text("Welcome to SnowSeeker!")
                .font(.largeTitle)

            Text("Please select a resort from the left-hand menu; swipe from the left edge to show it.")
                .foregroundStyle(.secondary)
        }
    }
}
