//
//  LocationList.swift
//  StudyWithMe
//
//  Created by Patrick Morgan on 10/21/21.
//

import SwiftUI
import RealmSwift

struct LocationList: View {
    @EnvironmentObject var state: AppState
    @ObservedResults(Location.self) var locations
    
    var body: some View {
        print(locations)
        return NavigationView {
            List {
                ForEach(locations) { location in
                    NavigationLink(
                        destination: LocationDetail(location: location)
                            .environment(\.realmConfiguration, app.currentUser!.configuration(partitionValue: "user=\(state.user?._id ?? "")"))
                    ) {
                        LocationRow(location: location)
                    }
                }
            }
            .navigationTitle("Study Spots")
        }
    }
}

struct LocationListView_Previews: PreviewProvider {
    static var previews: some View {
        Realm.bootstrap()
        
        return LocationList()
            .environmentObject(AppState.sample)
    }
}
