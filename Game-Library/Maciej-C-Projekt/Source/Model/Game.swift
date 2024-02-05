import CoreData

@objc(Game)
public class Game: NSManagedObject {
  @objc var releaseDay: String {
    return releaseDate.formatted(.dateTime.month(.wide).day().year())
  }


  @objc var releaseDayDescending: String {
    return releaseDate.formatted(.dateTime.month(.wide).day().year()) + " "
  }

  @nonobjc
  public class func fetchRequest() -> NSFetchRequest<Game> {
    return NSFetchRequest<Game>(entityName: "Game")
  }

  @NSManaged public var name: String
  @NSManaged public var genre: String
  @NSManaged public var releaseDate: Date
  @NSManaged public var avatarName: String
  @NSManaged public var rate: Int16
}

extension Game: Identifiable {}

extension Game {
  
  static func generateTestGames(in context: NSManagedObjectContext) throws {
    let names = [
      "Metal Gear Solid",
      "Water Traffic",
      "Big Boyo",
      "Elden RIng",
      "Minecraft",
      "Call of Duty",
      "Divinity",
      "Soldout",
      "Limbo",
      "Sea of thieves",
      "Fifa 20",
      "Royal Knight",
      "Battlefield 1",
      "NBA2k",
      "CS:GO",
      "League of Legends",
      "Arcade Aliens"
    ]
    let genres = [
      "ArcadeA",
      "Other",
      "RPG",
      "FPS",
      "RTS",
      "Puzzle"
    ]
    for name in names {
      let game = Game(context: context)
      game.name = name
      game.genre = genres.randomElement()!
      game.avatarName = Symbols.symbolNames.randomElement()!
      let minutesAgo = Int.random(in: 1...10000000)
      game.releaseDate = Calendar.current.date(
        byAdding: .minute,
        value: -minutesAgo,
        to: Date())!
      game.rate = Int16.random(in: 1...10)
    }
    try context.save()
  }
}
