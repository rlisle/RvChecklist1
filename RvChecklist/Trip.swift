//
//  Trip.swift
//  RvChecklist
//
//  Created by Ron Lisle on 2/13/21.
//

import SwiftUI
import MapKit

struct Trip: Identifiable {
    let id = UUID()
    let destinationName: String
    let description: String
    let date: Date
    let coordinate: CLLocationCoordinate2D
}

let tripData = [
    Trip(destinationName: "Inks Lake", description: "Inks Lake State Park", date: Date(), coordinate: CLLocationCoordinate2D(latitude: 30.732393, longitude: -98.366089))
]
