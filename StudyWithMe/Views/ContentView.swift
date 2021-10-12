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
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    if state.loggedIn {
                        if (state.user != nil) && !state.user!.isProfileSet || showingProfileView {
                            SetProfileView(isPresented: $showingProfileView)
                                .environment(\.realmConfiguration, app.currentUser!.configuration(partitionValue: "user=\(state.user?._id ?? "")"))
                        } else {
                            HomeView()
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
        
//        SignInView()
//        if !userRealmConfiguration.signedIn {
//            SignInView()
//        } else {
//            HomeView()
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
