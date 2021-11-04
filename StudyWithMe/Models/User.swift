//
//  User.swift
//  StudyWithMe
//
//  Created by Patrick Morgan on 10/11/21.
//

import Foundation
import RealmSwift

final class User: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id = UUID().uuidString
    @Persisted var partition = "" // "user=_id"
    @Persisted var firstName = ""
    @Persisted var lastName = ""
    @Persisted var email = ""
    @Persisted var lastSeenAt: Date?
    @Persisted var userPreferences: UserPreferences?
//    @Persisted var checkIns = List<CheckIn>()
    
    var isProfileSet: Bool { !(userPreferences?.isEmpty ?? true) }

    // TODO: Add friends, pending friendships relationships
    //    @Persisted var friends:
}
