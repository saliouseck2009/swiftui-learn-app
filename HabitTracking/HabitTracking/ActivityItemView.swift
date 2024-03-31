//
//  ActivityItemView.swift
//  HabitTracking
//
//  Created by saliou seck on 23/03/2024.
//

import SwiftUI

struct ActivityItemView: View {
    var activity : ActivityItem
    var body: some View {
        HStack(){
            VStack(alignment: .leading) {
                Text(activity.name)
                    .font(.title3)
                Text(activity.description)
                    .font(.subheadline)
                    .foregroundStyle(.gray)
            }
            Spacer()
            Image(systemName: "checkmark.circle.fill")
                .font(.title)
                .foregroundStyle(.yellow)
                
        }
            .frame(maxWidth: .infinity, alignment: .leading)
        .padding( 16)
        .border(width: 10, edges: [.leading], color: .yellow)
        .background(.gray.opacity(0.3))
        .cornerRadius(10)
    }
            
        
        
    
}

extension View {
    func border(width: CGFloat, edges: [Edge], color: Color) -> some View {
        overlay(EdgeBorder(width: width, edges: edges).foregroundColor(color))
    }
}

struct EdgeBorder: Shape {
    var width: CGFloat
    var edges: [Edge]

    func path(in rect: CGRect) -> Path {
        edges.map { edge -> Path in
            switch edge {
            case .top: return Path(.init(x: rect.minX, y: rect.minY, width: rect.width, height: width))
            case .bottom: return Path(.init(x: rect.minX, y: rect.maxY - width, width: rect.width, height: width))
            case .leading: return Path(.init(x: rect.minX, y: rect.minY, width: width, height: rect.height))
            case .trailing: return Path(.init(x: rect.maxX - width, y: rect.minY, width: width, height: rect.height))
            }
        }.reduce(into: Path()) { $0.addPath($1) }
    }
}

#Preview {
    ActivityItemView(activity: Activity.dummyActivity)
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
