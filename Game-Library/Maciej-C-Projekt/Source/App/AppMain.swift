import SwiftUI

@main
struct AppMain: App {

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environment(
          \.managedObjectContext,
           PersistenceManager.shared.persistentContainer.viewContext)
        .onAppear {
          addTestGames()
        }
    }
  }

  private func addTestGames() {
    let request = Game.fetchRequest()
    let context = PersistenceManager.shared.persistentContainer.viewContext
    do {
      if try context.count(for: request) == 0 {
        try Game.generateTestGames(in: context)
      }
    } catch {
      print("Error generating games: \(error)")
    }
  }
}
