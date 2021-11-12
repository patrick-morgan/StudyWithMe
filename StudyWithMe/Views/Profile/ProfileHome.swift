//
//  ProfileHome.swift
//  StudyWithMe
//
//  Created by Patrick Morgan on 10/26/21.
//

import SwiftUI
import RealmSwift

struct ProfileHome: View {
    @EnvironmentObject var state: AppState
    @Environment(\.realm) var userRealm
    @ObservedResults(User.self) var users
        
    var body: some View {
        print(users)
        
        return VStack(alignment: .leading) {
            HStack {
                UserAvatarView(
                    photo: state.user?.userPreferences?.profilePhoto
                )

                Text(state.user!.firstName)
                Text(state.user!.lastName)
            }
//            Spacer()
            Text("Check Ins")
            CheckInList()
                .environment(\.realmConfiguration, app.currentUser!.configuration(partitionValue: "user=\(state.user?._id ?? "")"))
        }
        .padding()
    }
}

struct ProfileHome_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHome()
    }
}
