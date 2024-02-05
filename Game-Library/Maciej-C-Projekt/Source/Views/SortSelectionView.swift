import SwiftUI

struct SortSelectionView: View {
  @Binding var selectedSortItem: GameSort
  let sorts: [GameSort]
  var body: some View {
    Menu {
      Picker("Sort By", selection: $selectedSortItem) {
        ForEach(sorts, id: \.self) { sort in
          Text("\(sort.name)")
        }
      }
    } label: {
      Label(
        "Sort",
        systemImage: "line.horizontal.3.decrease.circle")
    }
    .pickerStyle(.inline)
  }
}

struct SortSelectionView_Previews: PreviewProvider {
  @State static var sort = GameSort.default
    static var previews: some View {
      SortSelectionView(
        selectedSortItem: $sort,
        sorts: GameSort.sorts)
    }
}
