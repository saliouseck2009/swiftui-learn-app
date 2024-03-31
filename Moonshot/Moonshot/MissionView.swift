//
//  MissionView.swift
//  Moonshot
//
//  Created by saliou seck on 14/03/2024.
//

import SwiftUI

struct CrewMember {
    let role: String
    let astronaut: Astronaut
}

struct MissionView: View {
    
    let crew: [CrewMember]
    let mission: Mission
    @Binding var path : NavigationPath
    var body: some View {
        ScrollView{
            VStack{
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .containerRelativeFrame(.horizontal){ width, axis in
                            width * 0.6
                            
                    }.padding(.top)
                    
                    Text(mission.launchDate?.formatted(date: .long, time: .omitted) ?? "N/A")
                }
        
                
                VStack(alignment: .leading){
                    Rectangle()
                        .frame(height: 2)
                        .foregroundStyle(.lightBackground)
                        .padding(.vertical)
                    Text("Mission Highlights")
                        .font(.title.bold())
                        .padding(.bottom,5 )
                    Text(mission.description)
                    Rectangle()
                        .frame(height: 2)
                        .foregroundStyle(.lightBackground)
                        .padding(.vertical)
                    
                    Text("Crew")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                    
                }
                .padding(.horizontal)
                AstronautListView(crew: crew, path: $path)
                
            }
            .padding(.bottom)
        }
        .navigationTitle(mission.displayName)
               .navigationBarTitleDisplayMode(.inline)
               .background(.darkBackground)
    }
    
    init(mission: Mission, astronauts: [String: Astronaut], path: Binding<NavigationPath>) {
        _path = path
        self.mission = mission
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }
}


//#Preview {
//    let missions: [Mission] = Bundle.main.decode("missions.json")
//    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
//    @State var path : NavigationPath
//        return MissionView(mission: missions[0], astronauts: astronauts, path: path)
//            .preferredColorScheme(.dark)
//}
