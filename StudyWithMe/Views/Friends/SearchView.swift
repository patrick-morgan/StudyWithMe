//
//  SearchView.swift
//  StudyWithMe
//
//  Created by Patrick Morgan on 11/15/21.
//

import SwiftUI
import RealmSwift

struct SearchView: View {
    @EnvironmentObject var state: AppState
    @Environment(\.realm) var publicRealm
    @ObservedResults(PublicUser.self) var publicUsers
    
    @State private var name = ""
    @State private var members = [String]()
    @State private var candidateUser = ""
    @State private var candidateUsers = [String]()
    
    @State private var isShowingPublicProfileView = false
    
    private var memberList: [String] {
        candidateUser == ""
            ? publicUsers.compactMap {
                state.user?.userPreferences?.userName != $0.userName && !members.contains($0.userName)
                    ? $0.userName
                    : nil }
            : candidateUsers
    }

    var body: some View {
        print(state.user!.userPreferences!.userName)
        print(publicUsers)
        
        let searchBinding = Binding<String>(
            get: { candidateUser },
            set: {
                candidateUser = $0
                searchUsers()
            }
        )
        return VStack {
            SearchBar(searchText: searchBinding)
            List {
                ForEach(memberList, id: \.self) { candidateUser in
                    VStack {
                        NavigationLink(destination: PublicProfileView(userName: candidateUser).environment(\.realmConfiguration, app.currentUser!.configuration(partitionValue: "all-users=all-the-users")), isActive: $isShowingPublicProfileView) { EmptyView() }
                        Button(action: { isShowingPublicProfileView = true }) {
                            HStack {
                                Text(candidateUser)
                                Spacer()
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func searchUsers() {
        var candidatePublicUsers: Results<PublicUser>
        if candidateUser == "" {
            candidatePublicUsers = publicUsers
        } else {
            let predicate = NSPredicate(format: "userName CONTAINS[cd] %@", candidateUser)
            candidatePublicUsers = publicUsers.filter(predicate).filter("userName != %@", state.user!.userPreferences!.userName)
        }
        candidateUsers = []
        candidatePublicUsers.forEach { publicUser in
            candidateUsers.append(publicUser.userName)
        }
    }
    
    private func addFriend(_ newFriend: String) {
        
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        Realm.bootstrap()

        return SearchView()
            .environmentObject(AppState.sample)
    }
}
