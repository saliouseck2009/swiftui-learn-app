//
//  UserDetailView.swift
//  ChallengeHttpData
//
//  Created by saliou seck on 12/04/2024.
//

import SwiftUI

struct UserDetailView: View {
    let user : User
    var body: some View {
        ScrollView {
                   VStack(alignment: .leading, spacing: 16) {
//                        Text("User Details")
//                            .font(.title)
//                            .bold()
//                            .padding(.bottom, 8)
                        
                        UserInfoRow(label: "Name", value: user.name)
                        UserInfoRow(label: "Email", value: user.email)
                        UserInfoRow(label: "Age", value: "\(user.age)")
                        UserInfoRow(label: "Company", value: user.company)
                        UserInfoRow(label: "Address", value: user.address)
                        UserInfoRow(label: "About", value: user.about)

                        Divider()
                        
                        Text("Registered")
                            .font(.title2)
                            .bold()
                            .padding(.top, 16)
                        
                        Text(formattedDate(from: user.registered))
                            .padding(.bottom, 16)
                        
                        Text("Tags")
                            .font(.title2)
                            .bold()
                        
                        TagsView(tags: user.tags)

                        Divider()
                        
                        Text("Friends")
                            .font(.title2)
                            .bold()
                            .padding(.top, 16)
                        
                        ForEach(user.friends) { friend in
                            Text("\(friend.name)")
                        }
                    }
                    .padding()
                }
        .navigationTitle("User Details")
    }
    private func formattedDate(from date: Date) -> String {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            formatter.timeStyle = .medium
            return formatter.string(from: date)
        }
}


struct UserInfoRow: View {
    let label: String
    let value: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.headline)
                .foregroundColor(.gray)
            Text(value)
                .font(.body)
        }
    }
}

struct TagsView: View {
    let tags: [String]

    var body: some View {
        ScrollView([.horizontal], showsIndicators: false) {
            HStack(alignment: .top, spacing: 8) {
                ForEach(tags, id: \.self) { tag in
                    Text(tag)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 8)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
        }
       
    }
}

#Preview {
    UserDetailView(user: SampleUser().user)
}
