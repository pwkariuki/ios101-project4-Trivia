//
//  ViewController.swift
//  Trivia
//
//  Created by Patrick Kariuki on 6/22/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var progressLabel: UILabel!
    @IBOutlet var topicLabel: UILabel!
    @IBOutlet var questionView: UITextView!
    @IBOutlet var firstOptionButton: UIButton!
    @IBOutlet var secondOptionButton: UIButton!
    @IBOutlet var thirdOptionButton: UIButton!
    @IBOutlet var fourthOptionButton: UIButton!
    
    var triviaQuestions: [TriviaQuestion] = []
    var currQuestionIndex = 0
    var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadTriviaQuestions()
    }
    
    func loadTriviaQuestions() {
        // Fetch questions from API
        TriviaQuestionService.fetchTrivia(difficulty: "easy") { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                    case .success(let questions):
                        self?.triviaQuestions = questions
                        self?.loadCurrentQuestion()
                    case .failure(let error):
                        self?.showErrorAlert(error: error)
                }
            }
        }
    }
    
    func showErrorAlert(error: Error) {
        let alert = UIAlertController(title: "Error", message: "Failed to load questions: \(error.localizedDescription)", preferredStyle: .alert)
        let retryAction = UIAlertAction(title: "Retry", style: .default) { _ in
            self.loadTriviaQuestions()
        }
        let useMockAction = UIAlertAction(title: "Use Sample Questions", style: .default) { _ in
            self.triviaQuestions = getMockData()
            self.loadCurrentQuestion()
        }
        alert.addAction(retryAction)
        alert.addAction(useMockAction)
        present(alert, animated: true)
    }
    
    @IBAction func didTapOptionButton(_ sender: UIButton) {
        if sender.tag == triviaQuestions[currQuestionIndex].correctAnswerIndex {
            score += 1
        }
        loadNextQuestion()
    }
    
    func loadCurrentQuestion() {
        guard !triviaQuestions.isEmpty else { return }
        
        // Enable buttons
        firstOptionButton.isEnabled = true
        secondOptionButton.isEnabled = true
        thirdOptionButton.isEnabled = true
        fourthOptionButton.isEnabled = true
        
        // Question labels
        progressLabel.text = "Question \(currQuestionIndex + 1) of \(triviaQuestions.count)"
        topicLabel.text = triviaQuestions[currQuestionIndex].topic
        // Question text
        questionView.text = triviaQuestions[currQuestionIndex].question
        // Option buttons
        firstOptionButton.setTitle(triviaQuestions[currQuestionIndex].options[0], for: .normal)
        secondOptionButton.setTitle(triviaQuestions[currQuestionIndex].options[1], for: .normal)
        thirdOptionButton.setTitle(triviaQuestions[currQuestionIndex].options[2], for: .normal)
        fourthOptionButton.setTitle(triviaQuestions[currQuestionIndex].options[3], for: .normal)
    }
    
    func loadNextQuestion() {
        currQuestionIndex += 1
        if currQuestionIndex >= triviaQuestions.count {
            gameOver()
        } else {
            loadCurrentQuestion()
        }
    }
    
    func gameOver() {
        let ac = UIAlertController(title: "Game Over!", message: "Final score: \(score)/\(triviaQuestions.count)", preferredStyle: .alert)
        let restart = UIAlertAction(title: "Restart", style: .default) { _ in
            self.restartGame()
        }
        ac.addAction(restart)
        present(ac, animated: true)
    }
    
    func restartGame() {
        score = 0
        currQuestionIndex = 0
        loadTriviaQuestions()
    }
}
