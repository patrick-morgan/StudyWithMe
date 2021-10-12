//
//  LogoutButton.swift
//  StudyWithMe
//
//  Created by Patrick Morgan on 10/12/21.
//

import SwiftUI
import RealmSwift

struct LogoutButton: View {
    @EnvironmentObject var state: AppState
    @Environment(\.realm) var userRealm
    
    var action: () -> Void = {}
    
    var body: some View {
        Button("Log Out") {
            state.shouldIndicateActivity = true
//            do {
//                try userRealm.write {
//                    state.user?.presenceState = .offLine
//                }
//            } catch {
//                state.error = "Unable to open Realm write transaction"
//            }
            logout()
        }
        .disabled(state.shouldIndicateActivity)
    }
    
    private func logout() {
        action()
        app.currentUser?.logOut()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
            }, receiveValue: {
                state.shouldIndicateActivity = false
                state.logoutPublisher.send($0)
            })
            .store(in: &state.cancellables)
    }
}

struct LogoutButton_Previews: PreviewProvider {
    static var previews: some View {
        AppearancePreviews(
            LogoutButton()
                .environmentObject(AppState())
                .previewLayout(.sizeThatFits)
                .padding()
        )
    }
}
