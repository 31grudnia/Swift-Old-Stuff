import CoreData

struct AddGameViewModel {
  func fetchGame(for objectId: NSManagedObjectID, context: NSManagedObjectContext) -> Game? {
    guard let game = context.object(with: objectId) as? Game else {
      return nil
    }

    return game
  }

  func saveGame(
    gameId: NSManagedObjectID?,
    with gameValues: GameValues,
    in context: NSManagedObjectContext
  ) {
    let game: Game
    if let objectId = gameId,
      let fetchedGame = fetchGame(for: objectId, context: context) {
      game = fetchedGame
    } else {
      game = Game(context: context)
    }

    game.name = gameValues.name
    game.releaseDate = gameValues.releaseDate
    game.genre = gameValues.genre
    game.avatarName = gameValues.avatarName
    game.rate = gameValues.rate
    do {
      try context.save()
    } catch {
      print("Save error: \(error)")
    }
  }
}
