//
//  CheckInLocationDetail.swift
//  StudyWithMe
//
//  Created by Patrick Morgan on 11/11/21.
//

import SwiftUI

import SwiftUI
import RealmSwift

struct CheckInLocationDetail: View {
    @EnvironmentObject var state: AppState
    @Environment(\.realm) var userRealm
    var locationId: String
    @ObservedResults(Location.self) var locations
    
    var location: Location? {
        locations.filter("_id = %@", locationId).first
    }
    
    let day = Date().dayOfWeek()!
        
    var body: some View {
        print(location ?? "nothing")
        
        return ScrollView {
//            MapView(coordinate: location.locationCoordinates, name: location.name)
//                .ignoresSafeArea(edges: .top)
//                .frame(height: 300)
//
            CircleImage(image: location!.image)
                .offset(y: -130)
                .padding(.bottom, -130)
            
            VStack(alignment: .leading) {
                HStack {
                    Text(location!.name)
                        .font(.title)
                }

                HStack {
                    Text(location!.address)
                    Spacer()
//                    Text(location.state)
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                
//                Text(location.locationHours!.sunday)
                CheckInButton(locationId: locationId)
                    .environment(\.realmConfiguration, app.currentUser!.configuration(partitionValue: "user=\(state.user?._id ?? "")"))

//                Button("Check In")
                Text(day)

//                Text(location.locationHours!.getHoursToday(today: day))

//                Divider()

//                Text("About \(landmark.name)")
                    .font(.title2)
//                Text(landmark.description)
            }
            .padding()
        }
    }
}

// extension Date {
//    func dayOfWeek() -> String? {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "EEEE"
//        return dateFormatter.string(from: self).lowercased()
//    }
// }

struct CheckInLocationDetail_Previews: PreviewProvider {
    static var previews: some View {
        Realm.bootstrap()
        
        return CheckInLocationDetail(locationId: "61848d1ff624ec20e0127e16")
            .environmentObject(AppState.sample)
    }
}
