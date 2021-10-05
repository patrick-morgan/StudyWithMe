//
//  StudyWithMeApp.swift
//  StudyWithMe
//
//  Created by Patrick Morgan on 9/21/21.
//

import RealmSwift
import SwiftUI

// Declare the global Realm App instance
let app = App(id: "studywithmeapp-thoax")

@main
struct StudyWithMeApp: SwiftUI.App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
