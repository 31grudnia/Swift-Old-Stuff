import SwiftUI

struct SFSymbolSelectorView: View {
  @Binding var isPresented: Bool
  @Binding var selectedSymbolName: String

  var body: some View {
    NavigationView {
      ScrollView {
        LazyVGrid(
          columns: [GridItem(.adaptive(minimum: 100))],
          spacing: 20) {
          ForEach(Symbols.symbolNames, id: \.self) { symbolName in
            Image(systemName: symbolName)
              .font(.system(size: 30))
              .foregroundColor(Color("rw-green"))
              .onTapGesture {
                self.selectedSymbolName = symbolName
                self.isPresented = false
              }
          }
        }
      }
      .padding()
      .navigationTitle("Symbols")
    }
  }
}

struct SFSymbolSelectorView_Previews: PreviewProvider {
  static var previews: some View {
    SFSymbolSelectorView(
      isPresented: .constant(false),
      selectedSymbolName: .constant(""))
  }
}
