//
//  ThumbNail.swift
//  StudyWithMe
//
//  Created by Patrick Morgan on 10/12/21.
//

import SwiftUI

struct ThumbNail: View {
    let imageData: Data
    
    var body: some View {
        Image(uiImage: (UIImage(data: imageData) ?? UIImage()))
        .resizable()
        .aspectRatio(contentMode: .fit)
    }
}

struct ThumbNail_Previews: PreviewProvider {
    static var previews: some View {
        AppearancePreviews(
            ThumbNail(imageData: (UIImage(named: "mugShotThumb") ?? UIImage()).jpegData(compressionQuality: 0.8)!)
        )
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
