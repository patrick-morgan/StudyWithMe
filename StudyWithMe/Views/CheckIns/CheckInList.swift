//
//  CheckInList.swift
//  StudyWithMe
//
//  Created by Patrick Morgan on 11/11/21.
//

import SwiftUI
import RealmSwift

struct CheckInList: View {
    @EnvironmentObject var state: AppState
    @Environment(\.realm) var userRealm
    @ObservedResults(User.self) var users
    
    var body: some View {
        VStack {
            if let checkIns = users[0].checkIns {
                List {
                    ForEach(checkIns) { checkIn in
                        NavigationLink(
                            destination: CheckInLocationDetail(locationId: checkIn.locationId)
                                .environment(\.realmConfiguration, app.currentUser!.configuration(partitionValue: "location=all-the-users"))
                        ) {
                            CheckInRow(locationId: checkIn.locationId)
                                .environment(\.realmConfiguration, app.currentUser!.configuration(partitionValue: "location=all-the-users"))                        }
                    }
                }
            }
        }
    }
}

struct CheckInList_Previews: PreviewProvider {
    static var previews: some View {
        CheckInList()
    }
}
