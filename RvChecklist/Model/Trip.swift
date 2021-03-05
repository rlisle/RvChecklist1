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
    let lengthOfStay: Int
    let coordinate: CLLocationCoordinate2D
}

let tripData = [
    Trip(destinationName: "Inks Lake",
         description: "Inks Lake State Park, site 286",
         date: Date(),
         lengthOfStay: 5,
         coordinate: CLLocationCoordinate2D(latitude: 30.732393, longitude: -98.366089))
]
