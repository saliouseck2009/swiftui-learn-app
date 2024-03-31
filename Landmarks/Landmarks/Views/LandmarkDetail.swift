//
//  LandmarkDetail.swift
//  Landmarks
//
//  Created by saliou seck on 17/02/2024.
//

import SwiftUI

struct LandmarkDetail: View {
    var landmark : Landmark
    var body: some View {
        ScrollView {
            MapView(coordinate: landmark.locationCoordinate).frame(height: 300)
            CircleImage(image: landmark.image)
                .offset(y: -130)
                .padding(.bottom,-130)
            VStack(alignment: .leading) {
                Text(landmark.name)
                    .font(.title)
                HStack {
                    Text(landmark.park)
                        .font(.subheadline)
                    Spacer()
                    Text(landmark.state)
                        .font(.subheadline)
                }
                .font(.subheadline)
                                .foregroundStyle(.secondary)
                Divider()
                Text("About \(landmark.name)")
                                    .font(.title2)
                Text(landmark.description)
            }.padding()
            Spacer()
        }
        .navigationTitle(landmark.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    LandmarkDetail(landmark: landmarks[0])
}
