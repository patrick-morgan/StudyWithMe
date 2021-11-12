//
//  CheckInRow.swift
//  StudyWithMe
//
//  Created by Patrick Morgan on 11/11/21.
//

import SwiftUI
import RealmSwift

struct CheckInRow: View {
    var locationId: String
    @ObservedResults(Location.self) var locations
    
    var location: Location? {
        locations.filter("_id = %@", locationId).first
    }
    
    var body: some View {
//        print("a fish!")
        print(locationId)
        print(location!)
        
        return HStack {
            Text(location?.name ?? "")
            Spacer()
        }
    }
}

// struct CheckInRow_Previews: PreviewProvider {
//    static var previews: some View {
//        CheckInRow()
//    }
// }
