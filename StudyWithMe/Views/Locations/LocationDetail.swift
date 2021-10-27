//
//  LocationDetail.swift
//  StudyWithMe
//
//  Created by Patrick Morgan on 10/27/21.
//

import SwiftUI
import RealmSwift

struct LocationDetail: View {
    @EnvironmentObject var state: AppState
    var location: Location
    
    var body: some View {
        ScrollView {
//            MapView(coordinate: location.locationCoordinates)
//                .ignoresSafeArea(edges: .top)
//                .frame(height: 300)
            
            CircleImage(photoData: location.photo!.picture!, failure: Image(systemName: "multiply.circle"))
                .offset(y: -130)
                .padding(.bottom, -130)
            
            VStack(alignment: .leading) {
                HStack {
                    Text(location.name)
                        .font(.title)
                }
//                .padding()

                HStack {
                    Text(location.address)
                    Spacer()
//                    Text(location.state)
                }
                .font(.subheadline)
                .foregroundColor(.secondary)

//                Divider()

//                Text("About \(landmark.name)")
                    .font(.title2)
//                Text(landmark.description)
            }
            .padding()
        }
    }
}

struct LocationDetail_Previews: PreviewProvider {
    static var previews: some View {
        Realm.bootstrap()
        
        return LocationDetail(location: .sample)
            .environmentObject(AppState.sample)
    }
}
