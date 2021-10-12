//
//  StudyWithMeApp.swift
//  StudyWithMe
//
//  Created by Patrick Morgan on 9/21/21.
//

import RealmSwift
import SwiftUI

// Declare the global Realm App instance
let app = RealmSwift.App(id: "studywithme-realm-grlye")

@main
struct StudyWithMeApp: SwiftUI.App {
    @StateObject var state = AppState()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(state)
        }
    }
}
