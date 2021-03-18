//
//  DestinationMap.swift
//  RvChecklist
//
//  Created by Ron Lisle on 2/13/21.
//

import SwiftUI
import MapKit

struct DestinationMap: View {
    
    var destination: String
    var coordinate: CLLocationCoordinate2D
    @State private var region = MKCoordinateRegion()
    
    var body: some View {
        VStack {
            HStack {
                Text(destination)
            }
            .padding()
            
//            Map(coordinateRegion: $region, annotationItems: [trip]) { currentTrip in
////                MapMarker(coordinate: currentTrip.coordinate)
//            }
            .ignoresSafeArea()
            .onAppear {
//                region.center = trip.coordinate
                region.span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02) }
        }
    }

    private func setRegion(_ coordinate: CLLocationCoordinate2D) {
        region = MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        )
    }
}

struct LocationMap_Previews: PreviewProvider {
  static var previews: some View {
    DestinationMap(destination: "Inks Lake", coordinate: CLLocationCoordinate2D())
  }
}
