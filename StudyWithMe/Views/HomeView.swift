//
//  Home.swift
//  StudyWithMe
//
//  Created by Patrick Morgan on 9/23/21.
//

import SwiftUI
import RealmSwift

struct HomeView: View {
    @EnvironmentObject var state: AppState
    @Environment(\.realm) var userRealm
//    @ObservedResults(Location.self) var locations
    
//    let locations = userRealm.objects(Location.self)
    
    var body: some View {
        VStack {
            Text("Where to study today?")
            LocationList()
                .environment(\.realmConfiguration, app.currentUser!.configuration(partitionValue: "location=all-the-users"))
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
