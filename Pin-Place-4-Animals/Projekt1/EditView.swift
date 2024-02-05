//
//  EditView.swift
//  Projekt1
//
//  Created by user on 19/06/2022.
//

import SwiftUI
import CoreData


struct EditView: View {
    
   
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath:
        \Place.title, ascending: true)],
    animation: .default)
    
    private var places: FetchedResults<Place>
    @State private var title : String = ""
    @State private var type : String = ""
    @State var msg : String = ""
    let place: Place
    private func editPlace() {
        msg = ""
        if !title.isEmpty && !type.isEmpty {
            place.title = title
            place.type = type
            msg="Changed record !"
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
        else {
            msg = "Don't leave boxes empty :( Nothing changed."
        }
    }
    private func prepare() {
        self.title = place.title!
        self.type = place.type!
        
    }

    var body: some View {
        ZStack  {
            Color.green.edgesIgnoringSafeArea(.all)
         VStack{
             HStack {
                TextField(
                    place.title!,
                    text: self.$title
                ).padding()
                    .background()
                    .cornerRadius(30)
                    .foregroundColor(Color.black)
             }.padding()
             HStack {
                TextField(
                    place.type!,
                    text: self.$type
                ).padding()
                    .background()
                    .cornerRadius(30)
                    .foregroundColor(Color.black)
             }.padding()
            Button(action: {
                editPlace()
            }) {
                Label("Update", systemImage: "hammer")
                    .padding()
                    .foregroundColor(.black)
                    .overlay(RoundedRectangle(cornerRadius: 25)
                        .stroke(Color.black, lineWidth: 2))
            }
             
            Text(msg)
                 .padding()
                 .foregroundColor(.red)
         }.padding()//vstack
    }
    }
}
struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        let place = Place()
        EditView(place: place)
        
    }
}

