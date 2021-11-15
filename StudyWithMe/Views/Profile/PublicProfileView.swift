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
//            Spacer()
            Text("Check Ins")
//            CheckInList()
//                .environment(\.realmConfiguration, app.currentUser!.configuration(partitionValue: "user=\(state.user?._id ?? "")"))
        }
        .padding()
    }
}

struct PublicProfileView_Previews: PreviewProvider {
    static var previews: some View {
        PublicProfileView(userName: "Pmo")
    }
}
