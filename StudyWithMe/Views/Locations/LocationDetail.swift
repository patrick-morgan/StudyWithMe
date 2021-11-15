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
    @Environment(\.realm) var userRealm
    @State var tapped: Bool = false
    var location: Location
    let day = Date().dayOfWeek()!.lowercased()
    
    var done: () -> Void = { }
    
    var body: some View {
//        print(location)
        
        return ScrollView {
//            MapView(coordinate: location.locationCoordinates, name: location.name)
//                .ignoresSafeArea(edges: .top)
//                .frame(height: 300)
//            
            CircleImage(image: location.image)
                .offset(y: -130)
                .padding(.bottom, -130)
            
            VStack(alignment: .leading) {
                HStack {
                    Text(location.name)
                        .font(.title)
                }

                HStack {
                    Text(location.address)
                    Spacer()
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                
                Text(location.locationHours!.getHoursToday(today: day))

                if tapped {
                    Button("Checked In") {}
                        .disabled(true)
                } else {
                    Button(action: saveCheckIn) {
                        Text("Check In")
                    }
                }

//                Divider()

//                Text("About \(landmark.name)")
//                    .font(.title2)
//                Text(landmark.description)
            }
            .padding()
        }
    }
    
    private func saveCheckIn() {
        tapped = true
        let checkIn = CheckIn()
        checkIn.locationId = location._id
        state.shouldIndicateActivity = true

        do {
            try userRealm.write {
                state.user?.checkIns.append(checkIn)
//                print("appended checkin")
//                userRealm.delete(checkIn)
//                print("removed checkIn")
            }
        } catch {
            state.error = "Unable to add checkIn to user realm"
            state.shouldIndicateActivity = false
            return
        }
        state.shouldIndicateActivity = false
        done()
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
