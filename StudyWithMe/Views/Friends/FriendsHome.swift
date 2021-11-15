//
//  FriendsHome.swift
//  StudyWithMe
//
//  Created by Patrick Morgan on 10/26/21.
//

import SwiftUI
import RealmSwift

struct FriendsHome: View {
    @EnvironmentObject var state: AppState
    @Environment(\.realm) var userRealm
    @ObservedResults(User.self) var users
    
    var body: some View {
        VStack {
            SearchView()
                .environment(\.realmConfiguration, app.currentUser!.configuration(partitionValue: "all-users=all-the-users"))
            if let friends = users[0].friends {
                if friends.count == 0 {
                    Text("No friends :(")
                } else {
                    List {
                        ForEach(friends) { _ in
                            Text("hi")
    //                        NavigationLink(
    //                            destination: CheckInLocationDetail(locationId: checkIn.locationId)
    //                                .environment(\.realmConfiguration, app.currentUser!.configuration(partitionValue: "location=all-the-users"))
    //                        ) {
    //                            CheckInRow(locationId: checkIn.locationId)
    //                                .environment(\.realmConfiguration, app.currentUser!.configuration(partitionValue: "location=all-the-users"))
    //                        }
                        }
                    }
                }
            } else {
                Text("im a bloke")
            }
       }
    }
}

struct FriendsHome_Previews: PreviewProvider {
    static var previews: some View {
        FriendsHome()
    }
}
