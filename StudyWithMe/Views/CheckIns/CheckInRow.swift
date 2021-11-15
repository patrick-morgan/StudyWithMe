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
//        print(locationId)
//        print(location!)
        
        return HStack {
            location!.image
                .resizable()
                .frame(width: 50, height: 50)
 
            Text(location!.name)
            Spacer()
        }
    }
}

 struct CheckInRow_Previews: PreviewProvider {
    static var previews: some View {
        CheckInRow(locationId: "61848d1ff624ec20e0127e16")
    }
 }
