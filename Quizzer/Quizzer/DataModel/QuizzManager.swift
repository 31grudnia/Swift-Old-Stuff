
import Foundation
import SwiftUI

class QuizzManager: ObservableObject {
    private(set) var quizz: [Quizz.Result] = []
    @Published private(set) var len = 0
    @Published private(set) var i = 0
    @Published private(set) var end = false
    @Published private(set) var answerSel = false
    @Published private(set) var question: AttributedString = ""
    @Published private(set) var answerChoices: [Answer] = []
    @Published private(set) var progress: CGFloat = 0.0
    @Published private(set) var score = 0
    
    init() {
        Task.init {
            await fetchQuizz()
        }
    }
    
    func fetchQuizz() async {
        guard let url = URL(string: "https://opentdb.com/api.php?amount=10") else { fatalError("Missing URL!")}
        
        let urlRequest = URLRequest(url: url)
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error fetching data!")}
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decoded = try decoder.decode(Quizz.self, from: data)
            
            DispatchQueue.main.async {
                self.i = 0
                self.score = 0
                self.progress = 0.00
                self.end = false
                self.quizz = decoded.results
                self.len = self.quizz.count
                self.setQuestion()
            }
        }   catch {
            print("Error fetching quizz: \(error)")
        }
    }   //fetchQuizz()
    
    func nextQuestion() {
        if i+1 < len {
            i += 1
            setQuestion()
        }   else {
            end = true
        }
    }   //nextQuestion()
    
    func setQuestion() {
        answerSel = false
        progress = CGFloat(Double(i+1) / Double(len) * 350)
        if i < len {
            let currentQuizzQuestion = quizz[i]
            question = currentQuizzQuestion.formattedQuestion
            answerChoices = currentQuizzQuestion.answers
        }
    }   //setQuestion()
    
    func selectAnswer(answer: Answer) {
        answerSel = true
        if answer.isCorrect {
            score += 1
        }
    }   //select answer
}
