//
//  Models.swift
//  StudyWithMe
//
//  Created by Patrick Morgan on 9/22/21.
//

import Foundation
import RealmSwift

final class User: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var firstName: String
    @Persisted var lastName: String
    // Add unique username later
    //    @Persisted var username: String

    // Check for unique email later
    @Persisted var email: String
    @Persisted var password: String
    @Persisted var profileImageName: String?

    // TODO: References foreign key, update later
    @Persisted var recentLocationId: String
    @Persisted var recentLocationTime: String

    // TODO: Add friends, pending friendships relationships
    //    @Persisted var friends:
}

final class UserRealmConfiguration: ObservableObject {
    @Published var configuration: Realm.Configuration = Realm.Configuration.defaultConfiguration
    @Published var score: Int = 0
    @Published var signedIn: Bool = false
    public init() {}
}
