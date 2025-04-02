//
//  CameraSelector.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 1/4/25.
//

import SwiftUI
import PhotosUI

struct CameraSelector: View {
    @Binding var photoSelection: PhotosPickerItem?
    var image: Image
    static let cameraIcon: String = "camera.viewfinder"
    
    var body: some View {
        HStack(spacing: 20) {
            image
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(.black)
                )
            
            PhotosPicker(selection: $photoSelection, matching: .images, photoLibrary: .shared()) {
                Label(LocalizedStringKey("choose_a_photo"), systemImage: "photo.on.rectangle.angled")
                    .foregroundStyle(.black)
            }
        }
    }
}


#Preview {
    CameraSelector(photoSelection: .constant(nil), image: Image(systemName: "photo.on.rectangle.angled"))
}
