//
//  ThumbNailView.swift
//  StudyWithMe
//
//  Created by Patrick Morgan on 10/12/21.
//

import SwiftUI

struct ThumbNailView: View {
    let photo: Photo?
    private let compressionQuality: CGFloat = 0.8
    
    var body: some View {
        VStack {
            if let photo = photo {
                if photo.thumbNail != nil || photo.picture != nil {
                    if let photo = photo.thumbNail {
                        ThumbNail(imageData: photo)
                    } else {
                        if let photo = photo.picture {
                            ThumbNail(imageData: photo)
                        } else {
                            ThumbNail(imageData: UIImage().jpegData(compressionQuality: compressionQuality)!)
                        }
                    }
                }
            }
        }
    }
}

struct ThumbNailView_Previews: PreviewProvider {
    static var previews: some View {
        AppearancePreviews(
            Group {
                ThumbNailView(photo: .sample)
                ThumbNailView(photo: nil)
            }
        )
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
