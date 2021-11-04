//
//  LocationRow.swift
//  StudyWithMe
//
//  Created by Patrick Morgan on 10/27/21.
//

import SwiftUI
import RealmSwift

struct LocationRow: View {
    var location: Location
    
    var body: some View {
        HStack {
//            location.image
//                .resizable()
//                .frame(width: 50, height: 50)
            Text(location.name)
            
            Spacer()
        }
    }
}

struct LocationRow_Previews: PreviewProvider {
    static var previews: some View {
        Realm.bootstrap()

        return Group {
            LocationRow(location: .sample)
            LocationRow(location: .sample2)
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
