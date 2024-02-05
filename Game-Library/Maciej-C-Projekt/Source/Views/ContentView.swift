import SwiftUI

struct ContentView: View {
  @Environment(\.managedObjectContext) private var viewContext

  @State private var addViewShown = false
  let viewModel = ListViewModel()

  @SectionedFetchRequest(
    sectionIdentifier: GameSort.default.section,
    sortDescriptors: GameSort.default.descriptors,
    animation: .default)
  private var games: SectionedFetchResults<String, Game>

  @State private var selectedSort = GameSort.default
  @State private var searchTerm = ""
  
  var searchQuery: Binding<String> {
    Binding {
      searchTerm
    } set: { newValue in
      searchTerm = newValue
      guard !newValue.isEmpty else {
        games.nsPredicate = nil
        return
      }
      games.nsPredicate = NSPredicate(
        format: "name contains[cd] %@",
        newValue)
    }
  }
  
  var body: some View {
    NavigationView {
      List {
        ForEach(games) { section in
          Section(header: Text(section.id)) {
            ForEach(section) { game in
              NavigationLink {
                AddGameView(gameId: game.objectID)
              } label: {
                GameView(game: game)
              }
            }
            .onDelete { indexSet in
              withAnimation {
                viewModel.deleteItem(
                  for: indexSet,
                  section: section,
                  viewContext: viewContext)
              }
            }
          }
        }
      }
      .searchable(text: searchQuery)
      .toolbar {
        ToolbarItemGroup(placement: .navigationBarTrailing) {
          SortSelectionView(
            selectedSortItem: $selectedSort,
            sorts: GameSort.sorts)
          .onChange(of: selectedSort) { _ in
            let request = games
            request.sectionIdentifier = selectedSort.section
            request.sortDescriptors = selectedSort.descriptors

          }
          Button {
            addViewShown = true
          } label: {
            Image(systemName: "plus.circle")
          }
        }
      }
      .sheet(isPresented: $addViewShown) {
        AddGameView()
      }
      .navigationTitle("Games")
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
