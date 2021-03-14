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
    @State var isPresented = false

    var body: some View {
        
        NavigationView {
            List {
                ForEach(modelData.trips(), id: \.self) { trip in
                    Button(action: {
                        selectedTrip = trip
                    }, label: {
                        Text(trip)
                    })
                }
                .onDelete(perform: deleteTrip)
            }
            .sheet(isPresented: $isPresented) {
              AddTrip { destination, description, date in
                self.addNewTrip(destination: destination, description: description, date: date)
                self.isPresented = false
              }
            }
        }
        .navigationBarTitle(Text("Trips"))
          .navigationBarItems(trailing:
            Button(action: { self.isPresented.toggle() }) {
              Image(systemName: "plus")
            }
        )
    }
    
    func deleteTrip(at offsets: IndexSet) {
        //TODO: delete trip at specified offset
        //movies.remove(atOffsets: offsets)
    }
    
    func addNewTrip(destination: String, description: String, date: Date) {
        //TODO:
//      let newTrip = Trip(title: title, date: date)
//      movies.append(newMovie)
    }
}

struct TripList_Previews: PreviewProvider {
    static var previews: some View {
        TripList(selectedTrip: "Inks Lake")
            .environmentObject(ModelData())
    }
}
