import SwiftUI
import CoreData



struct AddGameView: View {
  
  
  
  @Environment(\.managedObjectContext) private var viewContext
  @Environment(\.presentationMode) var presentation

  @State private var rate = 0
  @State private var name = ""
  @State private var genre = "RPG"
  @State private var genres = ["RPG", "FPS", "Puzzle", "RTS", "ArcadeA", "Other"]
  @State private var releaseDate = Date()
  @State private var nameError = false
  @State private var rateError = false
//  @State private var genreError = false
  @State var avatarName = "person.circle.fill"
  @State var pickerPresented = false

  var gameId: NSManagedObjectID?
  let viewModel = AddGameViewModel()

  var body: some View {
    NavigationView {
      VStack {
        Form {
          Section {
            HStack {
              Image(systemName: avatarName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .padding()
                .foregroundColor(Color("rw-green"))

              Button {
                withAnimation {
                  pickerPresented = true
                }
              } label: {
                Image(systemName: "pencil.circle")
                  .resizable()
                  .frame(width: 50, height: 50)
              }
            }
          }
          Section("GAME INFO") {
            VStack {
              TextField(
                "Name",
                text: $name,
              prompt: Text("Name"))
              if nameError {
                Text("Name is required")
                  .foregroundColor(.red)
              }
            }
            VStack {
              Picker("Genre", selection: $genre) {
                  ForEach(genres, id: \.self) {
                      Text($0)
                  }
              }.pickerStyle(.menu)
//              TextField(
//                "Genre",
//                text: $genre,
//              prompt: Text("Genre"))
//              if genreError {
//                Text("Genre is required")
//                  .foregroundColor(.red)
//              }
            }
            VStack {
              TextField(
                "Rate",
                value: $rate,
                formatter: NumberFormatter(),
                prompt: Text("Rate"))
              .keyboardType(/*@START_MENU_TOKEN@*/.numberPad/*@END_MENU_TOKEN@*/)
              if rateError {
                Text("Put in proper game's rating (0-10)")
                  .foregroundColor(.red)
              }
              
            }
            DatePicker(
              "Release Date",
              selection: $releaseDate)
          }
        }

        Button {
          if name.isEmpty || rate > 10 || rate < 0{
            nameError = name.isEmpty
            //genreError = genre.isEmpty
            if rate > 10 || rate < 0 {
              rateError = true
            } else {
              rateError = false
            }
          } else {
            let values = GameValues(
              name: name,
              genre: genre,
              releaseDate: releaseDate,
              avatarName: avatarName,
              rate: Int16(rate))

            viewModel.saveGame(
              gameId: gameId,
              with: values,
              in: viewContext)
            presentation.wrappedValue.dismiss()
          }
        } label: {
          Text("Save")
            .foregroundColor(.white)
            .font(.headline)
            .frame(maxWidth: 300)
        }
        .tint(Color("rw-green"))
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.roundedRectangle(radius: 5))
        .controlSize(.large)
      }
      .navigationTitle("\(gameId == nil ? "Add Game" : "Edit Game")")
      Spacer()
    }
    .sheet(isPresented: $pickerPresented) {
      SFSymbolSelectorView(
        isPresented: $pickerPresented,
        selectedSymbolName: $avatarName)
    }
    .onAppear {
      guard
        let objectId = gameId,
        let game = viewModel.fetchGame(for: objectId, context: viewContext)
      else {
        return
      }

      genre = game.genre
      name = game.name
      releaseDate = game.releaseDate
      avatarName = game.avatarName
      rate = Int(game.rate)
    }
  }
}

struct AddGameView_Previews: PreviewProvider {
  static var previews: some View {
    AddGameView()
  }
}
