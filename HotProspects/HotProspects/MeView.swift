//
//  MeView.swift
//  HotProspects
//
//  Created by saliou seck on 25/04/2024.
//

import SwiftUI
import CoreImage.CIFilterBuiltins
import UserNotifications

struct MeView: View {
    @AppStorage("name") private var name = "name"
    @AppStorage("emailAddress") private var emailAddress = "you@yoursite.sn"
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    @State private var qrCode = UIImage()

    var body: some View {
        NavigationStack {
            Image(systemName: "person.circle").font(.system(size: 100))
            Image(uiImage: generateQRCode(from: "\(name) : \(emailAddress)"))
                .interpolation(.none)
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .contextMenu {
                       let image = generateQRCode(from: "\(name) : \(emailAddress)")

                       ShareLink(item: Image(uiImage: image).interpolation(.none), preview: SharePreview("My QR Code", image: Image(uiImage: qrCode)))
                }
                .overlay(
                      RoundedRectangle(cornerRadius: 10)
                .stroke(.black)
                )
                .padding(24)
            Form {
                Section("Name"){
                    TextField("Name", text: $name)
                        .textContentType(.name)
                        .font(.title2)
                }
                Section("Email"){
                    TextField("Email address", text: $emailAddress)
                        .textContentType(.emailAddress)
                        .font(.title2)
                }
                
                    
                    
            }
            .navigationTitle("My profile")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: updateCode)
            .onChange(of: name, updateCode)
            .onChange(of: emailAddress, updateCode)
           
        }
    }
    func generateQRCode(from string: String) -> UIImage {
        filter.message = Data(string.utf8)

        if let outputImage = filter.outputImage {
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }

        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    
    func updateCode() {
        print("\(name) : \(emailAddress)")
        qrCode = generateQRCode(from: "\(name) : \(emailAddress)")
    }
}

#Preview {
    MeView()
}

