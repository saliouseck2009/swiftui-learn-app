//
//  ContentView.swift
//  SwiftDataProject
//
//  Created by saliou seck on 02/04/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var users : [User]
    @State var path = [User]()
    var body: some View {
        NavigationStack(path: $path){
            List(users) { user in
                NavigationLink(value :user) {
                    Text(user.name)
                }
            }
            .navigationTitle("Users")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: User.self) { user in
                AddUser(user: user)
            }.toolbar{
                Button("add User", systemImage: "plus"){
                    let user = User(name: "", city: "", joinDate: .now)
                    modelContext.insert(user)
                    path = [user]
                    
                }
            }

        }
    }
}

#Preview {
    ContentView()
}


@Model
class User {
    var name : String
    var city : String
    var joinDate : Date
    init(name: String, city: String, joinDate: Date) {
        self.name = name
        self.city = city
        self.joinDate = joinDate
    }
}
