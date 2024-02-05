
import Foundation
import SwiftUI

extension Text {
    func lilTitle() -> some View {
        self.font(.title)
            .fontWeight(.heavy)
            .foregroundColor(Color("AccentColor"))
    }
}
