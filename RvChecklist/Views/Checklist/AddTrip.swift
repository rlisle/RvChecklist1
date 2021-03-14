//
//  AddTrip.swift
//  RvChecklist
//
//  Created by Ron Lisle on 3/13/21.
//

import SwiftUI
import MapKit

struct AddTrip: View {
    static let DefaultDestination = "New Trip"
    static let DefaultDescription = "Have fun!"
    
    @State var destination = ""
    @State var description = ""
    @State var date = Date()
//    @State var lengthOfStay: Int
//    @State var coordinate: CLLocationCoordinate2D
    let onComplete: (String, String, Date) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Destination")) {
                    TextField("Destination", text: $destination)
                }
                Section(header: Text("Description")) {
                    TextField("Description", text: $description)
                }
                Section {
                    DatePicker(
                        selection: $date,
                        displayedComponents: .date) { Text("Date").foregroundColor(Color(.gray)) }
                }
//                Section(header: Text("Length of Stay")) {
//                    TextField("Length of Stay", text: $lengthOfStay)
//                }
                //TODO: Coordinate?
                Section {
                    Button(action: addTripAction) {
                        Text("Add Trip")
                    }
                }
            }
            .navigationBarTitle(Text("Add Trip"), displayMode: .inline)
        }
    }

  private func addTripAction() {
    onComplete(
      destination.isEmpty ? AddTrip.DefaultDestination : destination,
      description.isEmpty ? AddTrip.DefaultDescription : description,
      date)
  }
}
