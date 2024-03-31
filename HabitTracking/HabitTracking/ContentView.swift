//
//  ContentView.swift
//  HabitTracking
//
//  Created by saliou seck on 23/03/2024.
//

import SwiftUI

struct ActivityItem : Identifiable, Codable {
    var id = UUID()
    let name: String
    let description: String
    
    init(name: String, description: String, color: Color) {
            self.name = name
            self.description = description
    }
    
}

@Observable
class Activity {
    static var dummyActivity = ActivityItem(name: "Prier", description: "prière du fajar", color: Color.green)
    var activities = [ActivityItem]() {
        didSet{
            if let encoded = try? JSONEncoder().encode(activities){
                UserDefaults.standard.set(encoded, forKey:"activities")
            }
        }
    }
    init() {
        if let data = UserDefaults.standard.data(forKey: "activities"){
            if let decoded = try? JSONDecoder().decode([ActivityItem].self, from: data){
                activities = decoded
                return
            }
        }
        
        self.activities = []
    }
}

struct ContentView: View {
    @State private var activity = Activity()
    @State var showSheet = false
    var body: some View {
        NavigationStack{
            List{
                ForEach(activity.activities){ activity in
                    ActivityItemView(activity: activity)
                        .listRowSeparator(.hidden)
                }
            }
            .toolbar(content: {
                Button{
                    showSheet = true
                }label: {
                    Image(systemName: "plus")
                }.sheet(isPresented: $showSheet, content: {
                    AddActivityView(activity: activity)
                })
            })
           
            
            .navigationTitle("Activity")
        }
        
    }
}




#Preview {
    ContentView()
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
