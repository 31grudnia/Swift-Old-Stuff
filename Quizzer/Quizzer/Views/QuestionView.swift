
import SwiftUI

struct QuestionView: View {
    
    @EnvironmentObject var quizzManager: QuizzManager
    
    var body: some View {
        VStack(spacing: 40) {
            HStack {
                Text("Quizzer App").lilTitle()
                
                Spacer()
                
                Text("\(quizzManager.i + 1) out of \(quizzManager.len)")
                    .foregroundColor(Color("AccentColor"))
                    .fontWeight(.heavy)
            }   //HStack
            
            ProgressBar(progress: quizzManager.progress)
            VStack(alignment: .leading, spacing: 20) {
                Text(quizzManager.question)
                    .font(.system(size: 20))
                    .bold()
                    .foregroundColor(.gray)
                
                ForEach(quizzManager.answerChoices, id: \.id) { answer in
                    AnswerRow(answer: answer).environmentObject(quizzManager)
                }   //ForEach
            }   //VStack
            Button {
                quizzManager.nextQuestion()
            }   label: {
                PrimaryButton(text: "Next", background: quizzManager.answerSel ? Color("AccentColor") : Color(hue: 1.0, saturation: 0.0, brightness: 0.5, opacity: 0.3))
            }   //Button
            .disabled(!quizzManager.answerSel)
            Spacer()
        }   //VStack
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 0.985, green: 0.929, blue: 0.847))
        .navigationBarHidden(true)
        
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView()
            .environmentObject(QuizzManager())
    }
}
