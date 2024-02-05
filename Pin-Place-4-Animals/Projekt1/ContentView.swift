//
//  ContentView.swift
//  Projekt
//
//  Created by Mikołaj Starczewski on 17/06/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath:
     \User.name, ascending: true)],
    animation: .default)
    private var users: FetchedResults<User>
    @State var name = "" //do zmiany potem na ""
    @State var password = "" //do zmiany potem na ""
    @State var msg = ""
    @State var selection: Int? = nil
    @State var registration = false
    func seed_place() {
        let seed_places: [(String, String, Double, Double)] = [
            (
                "Restauracja Wesoly Orzech",
                "Idealne jedzenie. Jest opcja zamowienia taniego i dobrej jakosci jedzenia zarowno dla psa jak i kota - restauracja przyjazna zwierzetom!", 54.3453, 12.3455
            ),
            (
                "Lecznica zwierzat DajPsa",
                "Uratowalismy juz dziesiatki zwierzat. Uzywamy tylko najlepszych lekow i podchodzimy do kazdego przypadku indywidualnie.", 32.47375, 75.6382
            ),
            (
                 "Park Zielona Linia",
                 "Park z polami dla psow do wybiegania sie, czy grania z wlascicielem w freezbe. Przejazdy tyrolka dla wlasciciela i psa!", 12.3645, 64.2834
            )
        ]

        for s in seed_places{
            let newPlace = Place(context: viewContext)
            newPlace.id = UUID()
            newPlace.title = s.0
            newPlace.type = s.1
            
            let newPin = Pin(context: viewContext)
            newPin.latitude = s.2
            newPin.longitude = s.3
    
            newPlace.pin = newPin
            do {
                    try viewContext.save()
                }   catch {
                        let nsError = error as NSError
                        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                    }
            
            }
    }
        
    var body: some View {
        NavigationView {
        ZStack  {
            Color.green.edgesIgnoringSafeArea(.all)
            VStack{
                Image("pets-pets_symbol")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .padding()
                
                TextField(
                    "Login...",
                    text: $name
                ).padding()
                    .background()
                    .cornerRadius(30)
                    .foregroundColor(Color.black)
                    
                TextField(
                    "Password...",
                    text: $password
                ).padding()
                    .background()
                    .cornerRadius(30)
                    .foregroundColor(Color.black)
                
                NavigationLink (destination: MainView().navigationBarHidden(true), tag: 1, selection: $selection) {
                    Button(action: {
                        if(name == "" || password == "") {
                            msg = "Cannot be empty"
                        }   else {
                            if (checkUser()) {
                                selection = 1
                                msg = ""
                            }   else {
                                msg = "User not found!"
                            }
                        }
                    }) {
                        Label("Login", systemImage: "figure.wave")
                            .padding()
                            .foregroundColor(.black)
                            .overlay(RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.black, lineWidth: 2))
                    }
                }
                
                
                Button {
                    registration.toggle()
                } label: {
                    Label("Sign up", systemImage: "person.crop.circle.fill.badge.plus")
                        .padding()
                        .foregroundColor(.black)
                        .overlay(RoundedRectangle(cornerRadius: 25)
                            .stroke(Color.black, lineWidth: 2))
                }.sheet(isPresented: $registration) {
                    RegisterView()
                }
                Button(action: {
                    seed_place()
                })    {
                    Text("SeedPlace")
                        .padding()
                        .foregroundColor(.black)
                        .overlay(RoundedRectangle(cornerRadius: 25)
                            .stroke(Color.black, lineWidth: 2))
                }
                Text("\(msg)")
                    .padding()
                    .foregroundColor(.red)
                
                
                
            }.padding()
        }.navigationBarBackButtonHidden(true)
                .navigationTitle("asd")
                .navigationBarHidden(true)
                
        }
    }
    
    func checkUser() -> Bool {
        for u in users {
            if u.name == name && u.password == password {
                return true
            }
        }
        return false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
