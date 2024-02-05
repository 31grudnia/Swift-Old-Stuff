//
//  AddView.swift
//  Projekt1
//
//  Created by user on 19/06/2022.
//

import SwiftUI
import CoreData

struct AddView: View {
    @Environment(\.presentationMode) private var presentation
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath:
        \Place.title, ascending: true)],
    animation: .default)
    private var places: FetchedResults<Place>
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath:
        \Pin.id, ascending: true)],
    animation: .default)
    private var pins: FetchedResults<Pin>
    
    @State private var title : String = ""
    @State private var type : String = ""
    @State private var lat : Double = 0.0
    @State private var long : Double = 0.0
    @State var msg : String = ""
    
    var body: some View {
        ZStack  {
            Color.green.edgesIgnoringSafeArea(.all)
        VStack{
            HStack {
                TextField(
                    "Title...",
                    text: self.$title
                ).padding()
                    .background()
                    .cornerRadius(30)
                    .foregroundColor(Color.black)
            }.padding()
            
            HStack {
                TextField(
                    "Type...",
                    text: self.$type
                ).padding()
                    .background()
                    .cornerRadius(30)
                    .foregroundColor(Color.black)
            }.padding()
            
            HStack {
                Text("Lat: ")
                TextField(
                    "Latitude...",
                    value: self.$lat,
                    format: .number
                ).keyboardType(.decimalPad)
                    .padding()
                    .background()
                    .cornerRadius(30)
                    .foregroundColor(Color.black)
            }.padding()
            HStack {
                Text("Long: ")
                TextField(
                    "Longitude...",
                    value: self.$long,
                    format: .number
                ).keyboardType(.decimalPad)
                    .padding()
                    .background()
                    .cornerRadius(30)
                    .foregroundColor(Color.black)
            }.padding()
            Button(action: {
                if !title.isEmpty && !type.isEmpty && !(String(long).isEmpty) && !(String(lat).isEmpty) {
                    if lat > 90 || lat < -90 || long < -180 || long > 180 {
                        msg = "Wrong geographical params!"
                    }   else {
                        addPlace()
                        msg = ""
                        presentation.wrappedValue.dismiss()
                    }
                }   else {
                    msg = "Don't leave boxes empty!"
                }
                
                
            }) {
                Label("Add", systemImage: "plus.circle")
                    .padding()
                    .foregroundColor(.black)
                    .overlay(RoundedRectangle(cornerRadius: 25)
                        .stroke(Color.black, lineWidth: 2))
            }.padding()
            
            Text(msg).padding()
                .foregroundColor(.red)
            
        }.padding()
    }
    
    }
    private func addPlace(){
        let newPlace = Place(context: viewContext)
        newPlace.title = title
        newPlace.type = type
        
        let newPin = Pin(context: viewContext)
        newPin.latitude = lat
        newPin.longitude = long
        
        newPlace.pin = newPin
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError; fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        title = ""
        type = ""
        lat = 0.0
        long = 0.0
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
