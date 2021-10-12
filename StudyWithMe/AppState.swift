//
//  Models.swift
//  StudyWithMe
//
//  Created by Patrick Morgan on 9/22/21.
//

import Foundation
import RealmSwift
import Combine

class AppState: ObservableObject {
    
    @Published var error: String?
    @Published var busyCount = 0
    
    var user: User?
    
    var loginPublisher = PassthroughSubject<RealmSwift.User, Error>()
    var logoutPublisher = PassthroughSubject<Void, Error>()
    let userRealmPublisher = PassthroughSubject<Realm, Error>()
    var cancellables = Set<AnyCancellable>()

//    let publicUsersLoginPublisher = PassthroughSubject<RealmSwift.User, Error>()
//    let publicUsersRealmPublisher = PassthroughSubject<Realm, Error>()
    
    var shouldIndicateActivity: Bool {
        get {
            return busyCount > 0
        }
        set (newState) {
            if newState {
                busyCount += 1
                print("busy count plus:", busyCount)
            } else {
                print("busy count subtract:", busyCount)
                if busyCount > 0 {
                    busyCount -= 1
                } else {
                    print("Attempted to decrement busyCount below 1")
                }
            }
        }
    }
    
    var loggedIn: Bool {
        app.currentUser != nil && user != nil && app.currentUser?.state == .loggedIn
    }
    
    init() {
        _ = app.currentUser?.logOut()
        initLoginPublisher()
        initUserRealmPublisher()
        initLogoutPublisher()
    }
    
    func initLoginPublisher() {
        loginPublisher
            .receive(on: DispatchQueue.main)
            .flatMap { user -> RealmPublishers.AsyncOpenPublisher in
                self.shouldIndicateActivity = true
                let realmConfig = user.configuration(partitionValue: "user=\(user.id)")
                return Realm.asyncOpen(configuration: realmConfig)
            }
            .receive(on: DispatchQueue.main)
            .map {
                return $0
            }
            .subscribe(userRealmPublisher)
            .store(in: &self.cancellables)
    }
    
    func initUserRealmPublisher() {
        userRealmPublisher
            .sink(receiveCompletion: { result in
                if case let .failure(error) = result {
                    self.error = "Failed to log in and open user realm: \(error.localizedDescription)"
                }
            }, receiveValue: { realm in
                print("User Realm User file location: \(realm.configuration.fileURL!.path)")
                self.user = realm.objects(User.self).first
                // Will write through to mongo --> neat!!
                do {
                    try realm.write {
                        self.user?.lastSeenAt = Date()
                    }
                } catch {
                    self.error = "Unable to open Realm write transaction"
                }
                self.shouldIndicateActivity = false
            })
            .store(in: &cancellables)
    }
    
    func initLogoutPublisher() {
        logoutPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
            }, receiveValue: { _ in
                self.user = nil
            })
            .store(in: &cancellables)
    }
}
