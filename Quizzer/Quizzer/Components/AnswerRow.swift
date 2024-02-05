
import SwiftUI

struct AnswerRow: View {
    
    var answer: Answer
    
    @EnvironmentObject var quizzManager: QuizzManager
    
    @State private var isSelected = false
    
    var body: some View {
        HStack {
            Image(systemName: "circle.fill").font(.caption)
            Text(answer.text).bold()
            if isSelected {
                Spacer()
                Image(systemName: answer.isCorrect ? "checkmark.circle.fill" : "x.circle.fill")
                    .foregroundColor(answer.isCorrect ? .green : .red)
            }
        }   //HStack
        .padding()
        .frame(maxWidth:.infinity, alignment: .leading)
        .foregroundColor(quizzManager.answerSel ? (isSelected ? Color("AccentColor") : .gray) : Color("AccentColor"))
        .background(.white)
        .cornerRadius(10)
        .shadow(color: isSelected ? (answer.isCorrect ? .green : .red) : .gray, radius: 5)
        .onTapGesture {
            if !quizzManager.answerSel {
                isSelected = true
                quizzManager.selectAnswer(answer: answer)
            }
        }
    }
}

struct AnswerRow_Previews: PreviewProvider {
    static var previews: some View {
        AnswerRow(answer: Answer(text: "Single", isCorrect: false))
            .environmentObject(QuizzManager())
    }
}
