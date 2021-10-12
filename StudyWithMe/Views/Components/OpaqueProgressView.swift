//
//  OpaqueProgressView.swift
//  StudyWithMe
//
//  Created by Patrick Morgan on 10/12/21.
//

import SwiftUI

struct OpaqueProgressView: View {
    var message: String?
    
    private enum Dimensions {
        static let padding: CGFloat = 100
        static let bgColor = Color("Clear")
        static let cornerRadius: CGFloat = 16
    }
    
    init() {
        message = nil
    }
    
    init(_ message: String?) {
        self.message = message
    }
    
    var body: some View {
        VStack {
            if let message = message {
                ProgressView(message)
            } else {
                ProgressView()
            }
        }
        .padding(Dimensions.padding)
        .background(RoundedRectangle(cornerRadius: Dimensions.cornerRadius))
    }
}

struct OpaquePreviewView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Group {
                ZStack {
                    VStack {
                        Text("Background Text")
                            .padding(150)
                            .background(Color.blue)
                    }
                    OpaqueProgressView()
                }
                ZStack {
                    VStack {
                        Text("Background Text")
                            .padding(150)
                            .background(Color.blue)
                    }
                    OpaqueProgressView("Some Text")
                }
            }
        }
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
