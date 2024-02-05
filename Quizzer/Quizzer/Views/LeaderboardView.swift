
import SwiftUI
import CoreData

struct LeaderboardView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath:
     \User.login, ascending: true)],
    animation: .default)
    private var users: FetchedResults<User>
    
    var body: some View {
        VStack {
            Spacer()
            Text("Quizz Scoreboard").lilTitle()
            
            List {
                HStack {
                    Text("Login").fontWeight(.bold)
                    Spacer()
                    Text("Score").fontWeight(.bold)
                }   //HStack
                .listRowBackground(Color(red: 0.985, green: 0.929, blue: 0.847))
                ForEach(users, id: \.self) { u in
                    if u.highScore != 0 {
                        HStack {
                            Text(u.login!)
                            Spacer()
                            Text(String(u.highScore))
                        }   //HStack
                        .listRowBackground(Color(red: 0.985, green: 0.929, blue: 0.847))
                        .swipeActions {
                            Button("Burn") {
                                DataController().addHighScore(user: u, highScore: 0, context: viewContext)
                            }
                            .tint(.red)
                        }   //swipe
                    }   //if
                }   //ForEach
            }   //List
            
        }   //VStack
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
        .background(Color(red: 0.985, green: 0.929, blue: 0.847))
    }
}

struct LeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardView()
    }
}
