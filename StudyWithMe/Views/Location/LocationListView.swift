//
//  LocationListView.swift
//  StudyWithMe
//
//  Created by Patrick Morgan on 10/21/21.
//

import SwiftUI
import RealmSwift

struct LocationListView: View {
    @EnvironmentObject var state: AppState

    @Environment(\.realm) var realm
    
    @ObservedResults(Location.self) var locations
    @ObservedResults(PublicUser.self) var publicUsers
//    @ObservedResults(User.self) var users
    
    @State private var userName = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(userName)
//            Text(users[0].firstName)

//            Text(publicUsers)
            ForEach(locations) { location in
                HStack {
                    Text(location.name)
                        .foregroundColor(.gray)
                        .font(Font.caption)
                        .padding(.bottom)
//                            Text(location.address).font(Font.title)
                }
//                .id(location._id)
                .padding()
            }
         }
        .onAppear { initData() }

//        return ScrollView {
//            ScrollViewReader { _ in
//                VStack(alignment: .leading, spacing: 5) {
//                    Text(userName)
//                    ForEach(publicUsers) { location in
//                        VStack(alignment: .leading) {
//                            Text(location.firstName)
//                                .foregroundColor(.gray)
//                                .font(Font.caption)
//                                .padding(.bottom)
////                            Text(location.address).font(Font.title)
//                        }
//                        .id(location._id)
//                        .padding()
//                    }
//                 }
////                 .onAppear() {
////                     scrollToBottom(proxy: proxy)
////                 }
////                 .onChange(of: chatEntries.count) { _ in
////                     scrollToBottom(proxy: proxy)
////                 }
//            }
//            .onAppear { initData() }
//        }
    }
    private func initData() {
        userName = state.user?.userPreferences?.userName ?? ""
        callthis()
    }
    
    private func callthis() {
        print("called this:")
//        print(location)
//        print(users)
        print(locations)
        print(publicUsers)
//        print(location[0].firstName)
    }
}

struct LocationListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationListView()
    }
}
