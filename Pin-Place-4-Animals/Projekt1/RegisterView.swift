//
//  RegisterView.swift
//  Projekt
//
//  Created by Mikołaj Starczewski on 17/06/2022.
//

import SwiftUI
import CoreData



struct RegisterView: View {
    
                   
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath:
        \User.name, ascending: true)],
        animation: .default)
    
    private var users: FetchedResults<User>
    @State var name = ""
    @State var password = ""
    @State var msg = ""
    @State var added = ""
    
    var body: some View {
            ZStack  {
                Color.green.edgesIgnoringSafeArea(.all)
                VStack {
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
                    
                    Button(action: {
                        added=""
                        if(name == "" || password == "") {
                            msg = "Login and/or password cannot be empty!"
                        }   else {
                            addUser()
            
                        }
                    }) {
                        Label("Sign up as a new user", systemImage: "plus.circle")
                            .padding()
                            .foregroundColor(.black)
                            .overlay(RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.black, lineWidth: 2))
                    }.padding()
                    
                    Text("\(msg)")
                        .padding()
                        .foregroundColor(.red)
                    
                    Text("\(added)")
                        .padding()
                        .foregroundColor(.black)
                }.padding() //vstack
            }//zstack
    }
    
    private func addUser() {
        var checkifunique = true
        let newUser = User(context: viewContext)
        for u in users {
            if u.name == name {
                checkifunique = false
                break
            }
        }
        if (checkifunique){
            msg = ""
            newUser.name = name
            newUser.password = password
            added = "Login : \(name). Password: hidden."
            do {
                try viewContext.save()
            }   catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }   else {
            msg = "Sorry, \(name) is already taken. Try something else!"
            added = "No user added"
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
