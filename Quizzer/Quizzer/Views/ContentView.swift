
import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath:
     \User.login, ascending: true)],
    animation: .default)
    private var users: FetchedResults<User>
    
    @StateObject var quizzManager = QuizzManager()
    
    @State var login = ""
    @State var password = ""
    @State var msg = ""
    @State var selection: Int? = nil
    @State var registration = false
    var background: Color = Color("AccentColor")
    
    var body: some View {
        NavigationView {
            VStack(spacing: 40) {
                VStack(spacing: 20) {
                    Text("Quizzer App").lilTitle()
                    
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
                    
                    NavigationLink (destination: QuizzView().navigationBarHidden(true).environmentObject(quizzManager), tag: 1, selection: $selection) {
                        Button(action: {
                            if(login == "" || password == "") {
                                msg = "Cannot be empty"
                            }   else {
                                logOutAll()
                                if (checkUser()) {
                                    selection = 1
                                    msg = ""
                                }   else {
                                    msg = "User not found!"
                                }
                            }
                        }) {
                            PrimaryButton(text: "Let's go!")
                        }
                    }   //NavLink
                    
                    Button(action: {
                        registration.toggle()
                    }) {
                        PrimaryButton(text: "Add User")
                    }   //ButtonToRegister
                    .sheet(isPresented: $registration) {
                        RegisterView()
                    }
                    
                    Text("\(msg)")
                        .padding()
                        .foregroundColor(.red)
                    
                }   //VStack
            }   //VStack
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
            .background(Color(red: 0.985, green: 0.929, blue: 0.847))
        }   //NavView
        .navigationBarBackButtonHidden(true)
        .navigationTitle("asd")
        .navigationBarHidden(true)
    }   //var body
    
    func checkUser() -> Bool {
        for u in users {
            if u.login == login && u.password == password {
                DataController().logIn(user: u, context: viewContext)
                return true
            }
        }
        return false
    }   //checkUser()
    
    func logOutAll() {
        for u in users {
            DataController().logOut(user: u, context: viewContext)
        }
    }   //logOutAll
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
