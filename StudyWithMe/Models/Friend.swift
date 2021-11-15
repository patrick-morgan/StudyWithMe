//
//  Friend.swift
//  StudyWithMe
//
//  Created by Patrick Morgan on 11/15/21.
//

import Foundation
import RealmSwift

class Friend: EmbeddedObject, ObjectKeyIdentifiable {
    @Persisted var id = UUID().uuidString
    @Persisted var friendId = ""
    @Persisted var relationshipType = "friend"
    
    var relationship: Relationship {
        get { return Relationship(rawValue: relationshipType) ?? .friend}
        set { relationshipType = newValue.asString}
    }
    
}

enum Relationship: String {
    case friend = "friend"
    case incomingPending = "incomingPending"
    case outgoingPending = "outgoingPending"
    
    var asString: String {
        self.rawValue
    }
}
