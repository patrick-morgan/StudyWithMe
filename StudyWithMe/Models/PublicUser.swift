//
//  PublicUser.swift
//  StudyWithMe
//
//  Created by Patrick Morgan on 10/11/21.
//

import Foundation
import RealmSwift

// The public interface for each user we use this this data duplication method to hide private user elements from all other users
class PublicUser: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id = UUID().uuidString // Will match _id of the associated user
    @Persisted var partition = "all-users=all-the-users"
    @Persisted var firstName: String
    @Persisted var lastName: String
    @Persisted var userName: String
    @Persisted var profilePhoto: Photo?
    @Persisted var lastSeenAt: Date?
    @Persisted var checkIns: List<CheckIn>
    @Persisted var friends: List<Friend>
}
