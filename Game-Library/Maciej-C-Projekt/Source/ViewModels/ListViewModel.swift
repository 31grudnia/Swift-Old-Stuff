import CoreData
import SwiftUI

struct ListViewModel {
  func deleteItem(
    for indexSet: IndexSet,
    section: SectionedFetchResults<String, Game>.Element,
    viewContext: NSManagedObjectContext
  ) {
    indexSet.map { section[$0] }.forEach(viewContext.delete)

    do {
      try viewContext.save()
    } catch {
      let nsError = error as NSError
      fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    }
  }
}
