//
//  ContentView.swift
//  Moonshot
//
//  Created by saliou seck on 12/03/2024.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    @State var path = NavigationPath()
    
    @State var showGrid = true
    var body: some View {
        
        NavigationStack(path: $path){
            Group{
                if(showGrid) { 
                    GridView(astronauts: astronauts, missions: missions,path: $path)
                }else{
                    ListView(astronauts: astronauts, missions: missions, path: $path)
                }
                
            }.navigationTitle("Moonshot")
                .background(.darkBackground)
                .preferredColorScheme(.dark)
                .toolbar{
                    Button("Toggle View"){
                        showGrid.toggle()
                    }
                }
        }
        
    }
}

struct GridView: View {
    let astronauts: [String: Astronaut]
    let missions: [Mission]
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    @Binding var path : NavigationPath
    var body: some View{
        
        ScrollView {
            LazyVGrid(columns: columns){
                ForEach(missions){ mission in
                    Button( ) {
                        path.append(mission)
                    } label: {
                        VStack {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding()
                    
                            VStack {
                                Text(mission.displayName)
                                    .font(.headline)
                                    .foregroundStyle(.white)
                                Text(mission.formattedLaunchDate)
                                    .font(.caption)
                                    .foregroundStyle(.white.opacity(0.5))
                            }
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(.lightBackground)
                        }
                    }.clipShape(.rect(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.lightBackground)
                        )
                }
            }.padding([.horizontal, .bottom])
        }
        .navigationDestination(for: Mission.self) { mission in
            MissionView(mission: mission, astronauts: astronauts, path: $path)
        }
    }
}

struct ListView: View {
    let astronauts: [String: Astronaut]
    let missions: [Mission]
    @Binding var path : NavigationPath
    var body: some View{
        List {
            ForEach(missions){ mission in
                Button {
                    path.append(mission)
                } label: {
                    VStack {
                        HStack {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                            Spacer()
                    
                            VStack {
                                Text(mission.displayName)
                                    .font(.headline)
                                    .foregroundStyle(.white)
                                Text(mission.formattedLaunchDate)
                                    .font(.caption)
                                    .foregroundStyle(.white.opacity(0.5))
                            }
                            
                        }.padding()
                        
                    }.clipShape(.rect(cornerRadius: 10))
                }.listRowBackground(Color.darkBackground)
                   
            }
        }
        .listStyle(.plain)
        .navigationDestination(for: Mission.self) { mission in
            MissionView(mission: mission, astronauts: astronauts, path: $path)
        }
        
    }
        
}


#Preview {
    ContentView()
}
