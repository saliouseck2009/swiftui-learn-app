//
//  EditView-ViewModel.swift
//  BucketList
//
//  Created by saliou seck on 22/04/2024.
//

import Foundation

extension EditView{
    @Observable
    class ViewModel{
        var name: String
        var description: String
        var loadingState = LoadingState.loading
        var pages = [Page]()
        var location: Location
        
        init(location: Location) {
            self.name = location.name
            self.description = location.description
            self.location = location
        }
        
        func updatePageState(state: LoadingState){
            self.loadingState = state
        }
        func getPages(pages: [Page]){
            self.pages = pages
        }
        
        func fetchNearbyPlaces() async {
            let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.latitude)%7C\(location.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
            guard let url = URL(string: urlString) else {
                print("Bad url \(urlString)")
                return
            }
            
            do {
                let(data,_) = try await URLSession.shared.data(from: url)
                let items = try JSONDecoder().decode(Result.self, from: data)
                self.getPages(pages:items.query.pages.values.sorted())
                self.updatePageState(state: .loaded)
                
            }catch {
                self.updatePageState(state: .failed)
            }
                    
        }
    }
}
