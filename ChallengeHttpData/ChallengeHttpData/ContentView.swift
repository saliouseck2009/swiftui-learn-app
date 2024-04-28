//
//  ContentView.swift
//  ChallengeHttpData
//
//  Created by saliou seck on 12/04/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query var users : [User]
    @Environment(\.modelContext) var modelContext
    var body: some View {
        NavigationStack{
            List(users){ user in
                NavigationLink{
                    UserDetailView(user: user)
                }label: {
                    HStack( ){
                        Text(user.name)
                        Spacer()
                        Text(user.isActive.description)
                    }
                }
            }
            .task {
                print("application launched")
                await loadData()
            }.navigationTitle("Users")
        }
    }
    
    func loadData() async {
        guard users.isEmpty else {
            print("data already load")
            return
        }
        print("Start load data")
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid Url")
            return
        }
        print("url is :  \(url.description)")
        do {
            let(data,_) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
            //decoder.dateDecodingStrategy = .formatted(formatter)
            //decoder.dateDecodingStrategy = .iso8601
            let decodedData = try decoder.decode([User].self, from: data)
            print("Data successfully decoded")
            for user in decodedData {
                modelContext.insert(user)
            }
            print("Data successfully inserted")
           
        }catch{
            print(error)
            print("error occured")
        }
        
    }
}



#Preview {
    ContentView()
}
