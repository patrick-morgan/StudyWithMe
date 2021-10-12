//
//  UserPreferences.swift
//  StudyWithMe
//
//  Created by Patrick Morgan on 10/11/21.
//

import Foundation
import RealmSwift

class UserPreferences: EmbeddedObject, ObjectKeyIdentifiable {
    @Persisted var userName: String
    @Persisted var profilePhoto: Photo?
    
    // Returns true if userName is still default ""
    var isEmpty: Bool { userName == "" }
}
