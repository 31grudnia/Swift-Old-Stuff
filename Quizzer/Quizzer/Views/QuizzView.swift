
import SwiftUI
import CoreData

struct QuizzView: View {
    
    @EnvironmentObject var quizzManager: QuizzManager
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath:
     \User.login, ascending: true)],
    animation: .default)
    private var users: FetchedResults<User>
    
    @State var scoreBoard = false
    
    var body: some View {
        if quizzManager.end {
            NavigationView {
                VStack(spacing: 20) {
                    Text("Quizzer App").lilTitle()
                    Text("Congratulations on reaching end of quizz!")
                    Text("You scored \(quizzManager.score) out of \(quizzManager.len) points!")
                    VStack {
                        Button {
                            Task.init {
                                await quizzManager.fetchQuizz()
                            }
                        }   label: {
                            PrimaryButton(text: "Play again")
                        }   //Button
                        
                        Button {    
                            scoreBoard.toggle()
                        }   label: {
                            PrimaryButton(text: "Scoreboard")
                        }   //Button
                        .sheet(isPresented: $scoreBoard) {
                            LeaderboardView()
                        }
                    }   //VStack
                }   //VStack
                .foregroundColor(Color("AccentColor"))
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(red: 0.985, green: 0.929, blue: 0.847))
            }   //NavView
            .foregroundColor(Color("AccentColor"))
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(red: 0.985, green: 0.929, blue: 0.847))
            .onAppear {
                self.checkHighscore()
            }
        }   else {
            QuestionView()
                .environmentObject(quizzManager)
        }   //quizzManager.end
    }   //body
    
    func checkHighscore() -> Void {
        for u in users {
            if u.isLogged {
                if u.highScore < quizzManager.score {
                    DataController().addHighScore(user: u, highScore: quizzManager.score, context: viewContext)
                }
                break
            }
        }
    }   //checkHScores
}

struct QuizzView_Previews: PreviewProvider {
    static var previews: some View {
        QuizzView()
            .environmentObject(QuizzManager())
    }
}
