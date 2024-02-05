import SwiftUI

struct GameView: View {
  @Environment(\.managedObjectContext) private var viewContext

  @ObservedObject var game: Game

  var body: some View {
    HStack {
      Image(systemName: game.avatarName)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 100, height: 100)
        .foregroundColor(Color("rw-green"))
      VStack(alignment: .leading) {
        Text("\(game.name)")
          .font(.title)
        Spacer()
        if !game.isFault {
          Text("Release: \(game.releaseDate.formatted(date: .numeric, time: .omitted))")
          Text("Genre: \(game.genre)")
          Text("Rating: \(game.rate)/10")
        }
      }
      .padding()
    }
    .frame(height: 100)
  }
}

struct GameView_Previews: PreviewProvider {
  static var previews: some View {
    GameView(game: getGame())
  }

  static func getGame() -> Game {
    let game = Game(context: PersistenceManager(inMemory: true).persistentContainer.viewContext)
    game.name = "Game"
    game.genre = "Genre"
    game.releaseDate = Date()
    game.avatarName = "person.circle.fill"
    game.rate = 0
    return game
  }
}
