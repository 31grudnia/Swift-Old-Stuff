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
    /*
     Tutaj ma byc : dodanie miejsca wraz z pinezka, edycja miejsca i/lub pinezki, usuniecie miejsca i pinezki)
     */
    func seed_place() {
        let newPlace = Place(context: viewContext)
        let seed_places: KeyValuePairs = [
            "title" : "Restauracja Wesoly Orzech",
            "type":"Idealne jedzenie. Jest opcja zamowienia taniego i dobrej jakosci jedzenia zarowno dla psa jak i kota - restauracja przyjazna zwierzetom!",
            "title": "Lecznica zwierzat DajPsa",
            "type":"Uratowalismy juz dziesiatki zwierzat. Uzywamy tylko najlepszych lekow i podchodzimy do kazdego przypadku indywidualnie.",
            "title": "Park Zielona Linia",
            "type":"Park z polami dla psow do wybiegania sie, czy grania z wlascicielem w freezbe. Przejazdy tyrolka dla wlasciciela i psa!",
        ]
        /*
         Poniewaz s.1 wyswietla po jednym elemencie w foreach tj (Restauracja..., Idealne ..., Lecznica...) to mamy jakies i, ktore jest prawda a pozniej zmieniamy je na false zeby wstawiac gdzie indziej
         */
        var i = true
        for s in seed_places{
            if (i){
                newPlace.title = s.1
                print(newPlace.title!)
                i = false
            }
            else {
                newPlace.type = s.1
                print(newPlace.type!)
                i = true
            }
            
            if (i){
                print("SAVING DATA")
                do {
                                try viewContext.save()
                            }   catch {
                                let nsError = error as NSError
                                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                            }
            }
                }
        }
    
    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                    seed_place()
                })
                {
                    Text("SeedPlace")
                }
                List {
                    ForEach (places, id: \.self) { place in
                        Text("\(place.title!) oraz \(place.type!)")
                    }
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
