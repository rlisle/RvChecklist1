//
//  Trip.swift
//  RvChecklist
//
//  Created by Ron Lisle on 2/13/21.
//

import SwiftUI
import MapKit

struct Trip: Identifiable, Hashable, Codable {
    let id: Int
    let destinationName: String
    let description: String
//    let date: Date
//    let lengthOfStay: Int
//    let coordinate: CLLocationCoordinate2D
}
