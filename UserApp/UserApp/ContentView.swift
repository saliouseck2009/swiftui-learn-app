//
//  ContentView.swift
//  UserApp
//
//  Created by saliou seck on 14/04/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var users : [User]
    var body: some View {
        NavigationStack{
            List(users, id: \User.id){user in
                NavigationLink {
                    Text("detail name: \(user.name)")
                }label: {
                    Text(user.name)
                }
                
            }.task {
                await loadData()
            }
        }
    }
    
    func loadData() async{
        guard users.isEmpty else {return}
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else{
            return
        }
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let (data,_) = try await URLSession.shared.data(from: url)
            if let decodedData = try? decoder.decode([User].self, from: data){
                for user in decodedData {
                    modelContext.insert(user)
                }
            } else {return }
             
        }catch{
            print(error)
        }
    }
}

#Preview {
    ContentView()
}
