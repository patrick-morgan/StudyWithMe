//
//  CircleImage.swift
//  StudyWithMe
//
//  Created by Patrick Morgan on 10/27/21.
//

import SwiftUI

struct CircleImage: View {
    var photoData: Data
    var failure: Image

    var body: some View {
        getImage()
            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            .overlay(Circle().stroke(Color.white, lineWidth: 4))
            .shadow(radius: 7)
    }
    private func getImage() -> Image {
        if let image = UIImage(data: photoData) {
            return Image(uiImage: image)
        } else {
            return failure
        }
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage(photoData: Photo.shinolaPhoto.picture!, failure: Image(systemName: "multiply.circle"))
    }
}
