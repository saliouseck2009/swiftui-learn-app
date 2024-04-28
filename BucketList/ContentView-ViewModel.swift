//
//  ContentView-ViewModel.swift
//  BucketList
//
//  Created by saliou seck on 21/04/2024.
//

import Foundation
import CoreLocation
import LocalAuthentication
import MapKit
import _MapKit_SwiftUI


extension ContentView {
    @Observable
    class ViewModel{
        
        private (set) var locations : [Location]
          var selectedPlace: Location?
        var startPosition = MapCameraPosition.region(
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 14.7, longitude: -17.4),
                span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5)
            ))
        let savePath = URL.documentsDirectory.appending(path: "SavedPlaces")
        var isUnlocked = false
        var mapStyle = MapStyle.standard
        var showAlert = false
        var authErrorMessage = ""
        
        var styles: [String] = ["standard", "hybrid"]
        var selectedStyle = "standard"
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = []
            }
        }
        
        func switchMapStyle(){
            if(selectedStyle == "standard"){
                mapStyle = .standard
            }else{
                mapStyle = .hybrid
            }
        }
        
        func addLocation(at point: CLLocationCoordinate2D){
            let location = Location(id: UUID(), name: "new Position", description: "", latitude: point.latitude, longitude: point.longitude)
            locations.append(location)
            save()
        }
        
        func updateLocation(location: Location){
            guard let selectedPlace else {return}
            if let index = locations.firstIndex(of: selectedPlace ){
                locations[index] = location
                save()
            }
        }
        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data.")
            }
        }
        
        func authenticate() {
            let context = LAContext()
            var error: NSError?

            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Please authenticate yourself to unlock your places."

                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in

                    if success {
                        self.isUnlocked = true
                    } else {
                       // self.authErrorMessage = authenticationError?.localizedDescription ?? "Authentication failed! Try again"
                       // self.showAlert = true
                    }
                }
            } else {
                self.authErrorMessage = "no biometrics available "
                self.showAlert = true
            }
        }
        
    }
}
