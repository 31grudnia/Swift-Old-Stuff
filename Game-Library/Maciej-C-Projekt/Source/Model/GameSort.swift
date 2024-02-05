import Foundation

struct GameSort: Hashable, Identifiable {
  let id: Int
  let name: String
  let descriptors: [SortDescriptor<Game>]
  let section: KeyPath<Game, String>

  static let sorts: [GameSort] = [
    GameSort(
      id: 0,
      name: "Genre | Ascending",
      descriptors: [
        SortDescriptor(\Game.genre, order: .forward),
        SortDescriptor(\Game.name, order: .forward)
      ],
      section: \Game.genre),
    GameSort(
      id: 1,
      name: "Genre | Descending",
      descriptors: [
        SortDescriptor(\Game.genre, order: .reverse),
        SortDescriptor(\Game.name, order: .forward)
      ],
      section: \Game.genre),
    GameSort(
      id: 2,
      name: "Release Date | Ascending",
      descriptors: [
        SortDescriptor(\Game.releaseDate, order: .forward),
        SortDescriptor(\Game.name, order: .forward)
      ],
      section: \Game.releaseDay),
    GameSort(
      id: 3,
      name: "Release Date | Descending",
      descriptors: [
        SortDescriptor(\Game.releaseDate, order: .reverse),
        SortDescriptor(\Game.name, order: .forward)
      ],
      section: \Game.releaseDayDescending)
  ]

  static var `default`: GameSort { sorts[0] }
}


