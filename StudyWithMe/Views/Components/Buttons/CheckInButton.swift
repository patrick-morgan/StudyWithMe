//
//  CheckInButton.swift
//  StudyWithMe
//
//  Created by Patrick Morgan on 11/11/21.
//

import SwiftUI

struct CheckInButton: View {
    @EnvironmentObject var state: AppState
    @Environment(\.realm) var userRealm
    @State var tapped: Bool = false
    var locationId: String
    
    var done: () -> Void = { }

    var body: some View {
        if tapped {
            Button("Checked In") {}
                .disabled(true)
        } else {
            Button(action: saveCheckIn) {
                Text("Check In")
            }
        }
    }
    
    private func saveCheckIn() {
        tapped = true
        let checkIn = CheckIn()
        checkIn.locationId = locationId
        state.shouldIndicateActivity = true

        do {
            try userRealm.write {
                state.user?.checkIns.append(checkIn)
            }
        } catch {
            state.error = "Unable to add checkIn to user realm"
            state.shouldIndicateActivity = false
            return
        }
        state.shouldIndicateActivity = false
        done()
    }
}

struct CheckInButton_Previews: PreviewProvider {
    static var previews: some View {
        CheckInButton(locationId: "61848d1ff624ec20e0127e16")
    }
}
