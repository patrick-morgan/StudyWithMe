//
//  LocationHome.swift
//  StudyWithMe
//
//  Created by Patrick Morgan on 10/26/21.
//

import SwiftUI
import RealmSwift

struct LocationHome: View {
    @EnvironmentObject var state: AppState
    @Environment(\.realm) var userRealm
//    @ObservedResults(Location.self) var locations
    
//    let locations = userRealm.objects(Location.self)
    
    var body: some View {
        VStack {
            Text("Where to study today?")
            LocationList()
                .environmentObject(state)
                .environment(\.realmConfiguration, app.currentUser!.configuration(partitionValue: "location=all-the-users"))
//                .environment(\.realmConfiguration, app.currentUser!.configuration(partitionValue: "all-users=all-the-users"))

        }
    }
}

struct LocationHome_Previews: PreviewProvider {
    static var previews: some View {
        Realm.bootstrap()
        
        return LocationHome()
            .environmentObject(AppState.sample)
    }
}
