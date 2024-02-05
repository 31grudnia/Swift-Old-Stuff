//
//  MainView.swift
//  Projekt1
//
//  Created by Mikołaj Starczewski on 18/06/2022.
//

import SwiftUI
import CoreData

struct MainView: View {
    
    
    
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
    @State var addViewShow: Bool = false
    //@State private var id : UUID = UUID()
    //@EnvironmentObject var place_object : Place
   
    /*
     Tutaj ma byc : dodanie miejsca wraz z pinezka, edycja miejsca i/lub pinezki, usuniecie miejsca i pinezki)
     */
    
    private func deletePlace(offsets: IndexSet) {withAnimation{
        offsets.map {places[$0] }.forEach(viewContext.delete)
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }}
    
//    @GestureState var isDetectingLongPress = false
      @State var completedLongPress = false
//    var longPress : some Gesture {
//        LongPressGesture(minimumDuration: 3)
//            .updating($isDetectingLongPress){
//                currentState, gestureState, transaction in gestureState = currentState
//                transaction.animation=Animation.easeIn(duration: 2.0)
//            }
//            .onEnded{finished in self.completedLongPress = finished}
//    }
    
    
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach (places, id: \.self) { place in
                        NavigationLink (destination: ShowPlace(place: place) ) {
                            VStack(alignment: .leading) {
                                Text("Name: \(place.title!)")
                                Text("Description: \(place.type!)")
                                Text("Long: \(place.pin!.latitude)")
                                Text("Lat: \(place.pin!.longitude)")
                            }.onLongPressGesture(perform: {
                                completedLongPress = true
                            })
                        }.sheet(isPresented: $completedLongPress) {
                            EditView(place: place)
                        }
                    }.onDelete(perform: deletePlace)
                        .listRowBackground(Color.green)
                }.toolbar{
                    ToolbarItemGroup(placement: .navigationBarTrailing){
                        Button{
                            addViewShow = true
                        } label: {
                            Image(systemName: "plus.circle")
                        }.foregroundColor(.black)
                    }
                }.sheet(isPresented: $addViewShow){
                    AddView()
                }.background(Color.green)//list
            }.background(Color.green)// vstack
        }.background(Color.green)// navview
    } //body
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
