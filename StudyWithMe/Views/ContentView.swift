//
//  ContentView.swift
//  StudyWithMe
//
//  Created by Patrick Morgan on 9/21/21.
//

import RealmSwift
import SwiftUI
let lightGreyColor = Color(red: 239.0 / 255.0, green: 243.0 / 255.0, blue: 244.0 / 255.0, opacity: 1.0)

struct ContentView: View {
    @EnvironmentObject var state: AppState
    @State private var showingProfileView = false
    @State private var selection: Tab = .locations
    
    enum Tab {
        case friends
        case locations
        case profile
    }

    var body: some View {
        NavigationView {
            VStack {
                if state.loggedIn {
                    if (state.user != nil) && !state.user!.isProfileSet || showingProfileView {
                        SetProfileView(isPresented: $showingProfileView)
                            .environment(\.realmConfiguration, app.currentUser!.configuration(partitionValue: "user=\(state.user?._id ?? "")"))
                    } else {
                        TabView(selection: $selection) {
                            FriendsHome()
                                .tabItem {
                                    Label("Friends", systemImage: "star")
                                }
                                .tag(Tab.friends)
                            LocationHome()
                                .environment(\.realmConfiguration, app.currentUser!.configuration(partitionValue: "user=\(state.user?._id ?? "")"))
                                .tabItem {
                                    Label("Locations", systemImage: "list.bullet")
                                }
                                .tag(Tab.locations)
                            ProfileHome()
                                .environment(\.realmConfiguration, app.currentUser!.configuration(partitionValue: "user=\(state.user?._id ?? "")"))
                                .tabItem {
                                    Label("Profile", systemImage: "star")
                                }
                                .tag(Tab.profile)
                        }
                        
                    }
                } else {
                    SignInView()
                }
            }
            if state.busyCount > 0 {
                OpaqueProgressView("Working With Realm")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AppState())
    }
}
