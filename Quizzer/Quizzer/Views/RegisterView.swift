
import SwiftUI
import CoreData

struct RegisterView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath:
     \User.login, ascending: true)],
    animation: .default)
    private var users: FetchedResults<User>
    
    @State var login = ""
    @State var password = ""
    @State var msg = ""
    @State var added = ""
    var background: Color = Color("AccentColor")
    
    var body: some View {
        VStack(spacing: 40) {
            VStack(spacing: 20) {
                TextField(
                    "Login...",
                    text: $login
                )   //TextField
                    .padding()
                    .background()
                    .cornerRadius(30)
                    .shadow(radius: 10)
                    .padding(.horizontal)
                
                TextField(
                    "Password...",
                    text: $password
                )   //TextField
                    .padding()
                    .background()
                    .cornerRadius(30)
                    .shadow(radius: 10)
                    .padding(.horizontal)
                
                Button(action: {
                    added = ""
                    if(login == "" || password == "") {
                        msg = "Login and/or password cannot be empty!"
                    }   else {
                        addUser()
                    }
                }) {
                    PrimaryButton(text: "Add User!")
                }   //Button
                .padding()
                
                VStack {
                    Text("\(msg)").foregroundColor(.red)
                    Text("\(added)").foregroundColor(.black)
                }   //VStack
            }   //VStack
        }   //VStack
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
        .background(Color(red: 0.985, green: 0.929, blue: 0.847))
    }   //var body
    
    private func addUser() {
        var checkUnique = true
        for u in users {
            if u.login == login {
                checkUnique = false
                break
            }
        }
        if (checkUnique){
            msg = ""
            DataController().addUser(login: login, password: password, context: viewContext)
            added = "Login : \(login). Password: hidden."
        }   else {
            msg = "Sorry, \(login) is already taken. Try something else!"
            added = "No user added"
        }
    }   //addUser()
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
