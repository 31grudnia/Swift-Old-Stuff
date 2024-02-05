import CoreData

struct PersistenceManager {
  static let shared = PersistenceManager()

  let persistentContainer: NSPersistentContainer

  init(inMemory: Bool = false) {
    persistentContainer = NSPersistentContainer(name: "Games")
    if inMemory,
      let storeDescription = persistentContainer.persistentStoreDescriptions.first {
      storeDescription.url = URL(fileURLWithPath: "/dev/null")
    }

    persistentContainer.loadPersistentStores { _, error in
      if let error = error as NSError? {
        fatalError("Unable to configure Core Data Store: \(error), \(error.userInfo)")
      }
    }
  }

  static var preview: PersistenceManager = {
    let result = PersistenceManager(inMemory: true)
    let viewContext = result.persistentContainer.viewContext
    for gameNumber in 0..<10 {
      let newGame = Game(context: viewContext)
      newGame.name = "Game \(gameNumber)"
      newGame.avatarName = "person.circle.fill"
      newGame.releaseDate = Date()
      newGame.genre = "Genre \(gameNumber)"
      newGame.rate = Int16.random(in: 1...10)
    }
    do {
      try viewContext.save()
    } catch {
      let nsError = error as NSError
      fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    }
    return result
  }()
}
