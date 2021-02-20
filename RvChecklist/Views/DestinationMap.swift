//
//  DestinationMap.swift
//  RvChecklist
//
//  Created by Ron Lisle on 2/13/21.
//

import SwiftUI
import MapKit

struct DestinationMap: View {
  var trip: Trip
  @State var region = MKCoordinateRegion()

  var body: some View {
    VStack {
      HStack {
        Text(self.trip.destinationName)
      }
      .padding()
      
      Map(coordinateRegion: $region, annotationItems: [trip]) { currentTrip in
        MapMarker(coordinate: currentTrip.coordinate)
      }
      .ignoresSafeArea()
      .onAppear {
        region.center = trip.coordinate
        region.span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02) }
    }
  }
}

struct LocationMap_Previews: PreviewProvider {
  static var previews: some View {
    DestinationMap(trip: tripData[0])
  }
}
