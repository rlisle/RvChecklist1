//
//  TripList.swift
//  RvChecklist
//
//  Created by Ron Lisle on 3/14/21.
//

import SwiftUI

struct TripList: View {
    
    @EnvironmentObject var modelData: ModelData
    @State var selectedTrip: String
    
    var body: some View {
        
        List {
            ForEach(modelData.trips(), id: \.self) { trip in
                Button(action: {
                    selectedTrip = trip
                }, label: {
                    Text(trip)
                })
            }
        }
    }
}

struct TripList_Previews: PreviewProvider {
    static var previews: some View {
        TripList(selectedTrip: "Inks Lake")
    }
}
