//
//  SetProfileView.swift
//  StudyWithMe
//
//  Created by Patrick Morgan on 10/12/21.
//
import UIKit
import SwiftUI
import RealmSwift

struct SetProfileView: View {
    @EnvironmentObject var state: AppState
    @Environment(\.realm) var userRealm
    
    @Binding var isPresented: Bool
    
    @State private var userName = ""
    @State private var photo: Photo?
    @State private var photoAdded = false
    @State private var firstName = ""
    @State private var lastName = ""
    
    var body: some View {
        Form {
            Section(header: Text("User Profile")) {
                if let photo = photo {
                    AvatarButton(photo: photo) {
                        self.showPhotoTaker()
                    }
                }
                if photo == nil {
                    Button(action: { self.showPhotoTaker() }) {
                        Text("Add Photo")
                    }
                }
                InputField(title: "First Name", text: $firstName)
                InputField(title: "Last Name", text: $lastName)
                InputField(title: "User Name", text: $userName)
                CallToActionButton(title: "Save User Profile", action: saveProfile)
            }
//            Section(header: Text("Device Settings")) {
//                Toggle(isOn: $shouldShareLocation, label: {
//                    Text("Share Location")
//                })
//                .onChange(of: shouldShareLocation) { value in
//                    if value {
//                        _ = LocationHelper.currentLocation
//                    }
//                }
//                OnlineAlertSettings()
//            }
        }
        .onAppear { initData() }
        .padding()
        .navigationBarTitle("Edit Profile", displayMode: .inline)
        .navigationBarItems(
            leading: Button(action: { isPresented = false }) { BackButton() },
            trailing: state.loggedIn ? LogoutButton(action: { isPresented = false }) : nil)
    }
    
    private func initData() {
        userName = state.user?.userPreferences?.userName ?? ""
        photo = state.user?.userPreferences?.profilePhoto
    }
    
    private func saveProfile() {
        state.shouldIndicateActivity = true
        do {
            try userRealm.write {
                state.user?.firstName = firstName
                state.user?.lastName = lastName
                state.user?.userPreferences?.userName = userName
                if photoAdded {
                    guard let newPhoto = photo else {
                        print("Missing photo")
                        state.shouldIndicateActivity = false
                        return
                    }
                    state.user?.userPreferences?.profilePhoto = newPhoto
                }
            }
        } catch {
            state.error = "Unable to open Realm write transaction"
        }
        state.shouldIndicateActivity = false
    }
    
    private func showPhotoTaker() {
        PhotoCaptureController.show(source: .camera) { controller, photo in
            self.photo = photo
            photoAdded = true
            controller.hide()
        }
    }
}

struct SetProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let previewState: AppState = .sample
        return AppearancePreviews(
            NavigationView {
                SetProfileView(isPresented: .constant(true))
            }
        )
        .environmentObject(previewState)
    }
}
