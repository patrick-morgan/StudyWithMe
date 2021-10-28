//
//  MapView.swift
//  StudyWithMe
//
//  Created by Patrick Morgan on 10/27/21.
//

import SwiftUI
import MapKit

struct Place: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct MapView: View {
    var coordinate: CLLocationCoordinate2D
    var name: String
    
    @State private var region = MKCoordinateRegion()
    
    @State private var places: [Place] = []

    var body: some View {
        Map(coordinateRegion: $region, annotationItems: places) { _ in
            MapPin(coordinate: coordinate)
        }
        .onAppear {
            setRegion(coordinate, name)
        }
    }

    private func setRegion(_ coordinate: CLLocationCoordinate2D, _ name: String) {
        region = MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002)
        )
        places.append(Place(name: name, coordinate: coordinate))
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(coordinate: CLLocationCoordinate2D(latitude: 42.27506374973899, longitude: -83.73405691720389), name: "Starbucks" )
    }
}
