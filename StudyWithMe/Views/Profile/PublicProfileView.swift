//
//  PublicProfileView.swift
//  StudyWithMe
//
//  Created by Patrick Morgan on 11/15/21.
//

import SwiftUI
import RealmSwift

struct PublicProfileView: View {
    @EnvironmentObject var state: AppState
    @Environment(\.realm) var userRealm
    @ObservedResults(PublicUser.self) var publicUsers
    
    var userName: String
    
    var publicUser: PublicUser? {
        publicUsers.filter("userName = %@", userName).first
    }
    
    var body: some View {        
        return VStack(alignment: .leading) {
            HStack {
                UserAvatarView(
                    photo: publicUser!.profilePhoto
                )

                Text(publicUser!.firstName)
                Text(publicUser!.lastName)
            }
            HStack {
                FriendButton(friendId: publicUser!._id)
                    .environment(\.realmConfiguration, app.currentUser!.configuration(partitionValue: "user=\(state.user?._id ?? "")"))
            }
//            Spacer()
            Text("Check Ins")
            if let checkIns = publicUser!.checkIns {
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
        .padding()
    }
}

struct PublicProfileView_Previews: PreviewProvider {
    static var previews: some View {
        PublicProfileView(userName: "Pmo")
    }
}
