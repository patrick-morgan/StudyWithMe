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
    let day = Date().dayOfWeek()!
    
    var body: some View {
        print(location)
        
        return ScrollView {
//            MapView(coordinate: location.locationCoordinates, name: location.name)
//                .ignoresSafeArea(edges: .top)
//                .frame(height: 300)
//            
//            CircleImage(image: location.image)
//                .offset(y: -130)
//                .padding(.bottom, -130)
            
            VStack(alignment: .leading) {
                HStack {
                    Text(location.name)
                        .font(.title)
                }

                HStack {
                    Text(location.address)
                    Spacer()
//                    Text(location.state)
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                
//                Text(location.locationHours!.sunday)
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

extension Date {
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).lowercased()
    }
}

struct LocationDetail_Previews: PreviewProvider {
    static var previews: some View {
        Realm.bootstrap()
        
        return LocationDetail(location: .sample)
            .environmentObject(AppState.sample)
    }
}
