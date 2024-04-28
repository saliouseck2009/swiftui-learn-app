//
//  ContentView.swift
//  Instafilter
//
//  Created by saliou seck on 13/04/2024.
//

import SwiftUI
import PhotosUI
import CoreImage
import CoreImage.CIFilterBuiltins
import StoreKit


struct ContentView: View {
    @State private var processedImage: Image?
    @State private var filterIntensity = 0.5
    @State private var filterRadius = 0.0
    @State private var filterScale = 0.0
    @State private var selectedItem: PhotosPickerItem?
    @State private var showingFilters = false
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    @AppStorage("filterCount") var filterCount = 0
    @Environment(\.requestReview) var requestReview

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                PhotosPicker(selection: $selectedItem){
                    if let processedImage {
                        processedImage
                            .resizable()
                            .scaledToFit()
                    } else {
                        ContentUnavailableView("No Picture", systemImage: "photo.badge.plus", description: Text("Tap to import a photo"))
                    }
                }
                .buttonStyle(.plain)
                .onChange(of: selectedItem, loadImage)
                Spacer()

                VStack {
                    HStack {
                        Text("Intensity")
                        Slider(value: $filterIntensity)
                            .onChange(of: filterIntensity, applyProcessing)
                    }
                    HStack {
                        Text("Raduis")
                        Slider(value: $filterRadius, in: 0...1000)
                            .onChange(of: filterRadius, applyProcessing)
                    }
                    HStack {
                        Text("Scale")
                        Slider(value: $filterScale, in: 1...50)
                            .onChange(of: filterScale, applyProcessing )
                    }
                

                    HStack {
                        Button("Change Filter", action: changeFilter)
                        
                        Spacer()
                        
                        if let processedImage {
                            ShareLink(item: processedImage, preview: SharePreview("InstantFilter Image", image:processedImage))
                        }
                    }
                }.disabled(processedImage == nil)
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
            .confirmationDialog("Select a filter", isPresented: $showingFilters) {
                Button("Crystallize") { setFilter(CIFilter.crystallize()) }
                Button("Edges") { setFilter(CIFilter.edges()) }
                Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
                Button("Pixellate") { setFilter(CIFilter.pixellate()) }
                Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
                Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
                Button("Vignette") { setFilter(CIFilter.vignette()) }
                Button("gloom"){ setFilter(CIFilter.gloom())}//intensity
                Button("bokeh"){setFilter(CIFilter.bokehBlur())}//intensity
                
                Button("Cancel", role: .cancel) { }
               
            }
        }
    }
    func changeFilter() {
        showingFilters = true
    }
    func loadImage() {
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else { return }
            guard let inputImage = UIImage(data: imageData) else { return }

            let beginImage = CIImage(image: inputImage)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            applyProcessing()
        }
    }
    @MainActor func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
        filterCount += 1

        if filterCount >= 20 {
            requestReview()
        }
    }
    func applyProcessing(){
        let inputKeys = currentFilter.inputKeys

        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterRadius * 200, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterScale * 10, forKey: kCIInputScaleKey) }
        guard let outputImage = currentFilter.outputImage else { return }
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }

        let uiImage = UIImage(cgImage: cgImage)
        processedImage = Image(uiImage: uiImage)
    }
}

#Preview {
    ContentView()
}
