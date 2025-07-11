//
//  TriviaQuestionService.swift
//  Trivia
//
//  Created by Patrick Kariuki on 7/9/25.
//
import Foundation
import UIKit

class TriviaQuestionService {
    static func fetchTrivia(difficulty: String, completion: @escaping (Result<[TriviaQuestion], Error>) -> Void) {
        var components = URLComponents(string: "https://opentdb.com/api.php")
        components?.queryItems = [
            URLQueryItem(name: "amount", value: "10"),
            URLQueryItem(name: "difficulty", value: difficulty),
            URLQueryItem(name: "type", value: "multiple")
        ]
        
        guard let url = components?.url else {
            completion(.failure(TriviaError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200,
                  let data = data else {
                completion(.failure(TriviaError.invalidResponse))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(TriviaResponse.self, from: data)
                let triviaQuestions = response.results.map { question in
                    convertToTriviaQuestion(question)
                }
                completion(.success(triviaQuestions))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    private static func convertToTriviaQuestion(_ question: Question) -> TriviaQuestion {
        // Combine correct and incorrect answers and shuffle
        var allOptions = question.incorrectAnswers
        allOptions.append(question.correctAnswer)
        allOptions.shuffle()
        
        // Find the index of the correct answer after shuffling
        let correctIndex = allOptions.firstIndex(of: question.correctAnswer) ?? 0
        
        return TriviaQuestion(
            topic: question.category,
            question: decodeHTMLEntities(question.question),
            options: allOptions.map { decodeHTMLEntities($0) },
            correctAnswerIndex: correctIndex
        )
    }
    
    private static func decodeHTMLEntities(_ text: String) -> String {
        return text
            .replacingOccurrences(of: "&quot;", with: "\"")
            .replacingOccurrences(of: "&#039;", with: "'")
            .replacingOccurrences(of: "&amp;", with: "&")
            .replacingOccurrences(of: "&lt;", with: "<")
            .replacingOccurrences(of: "&gt;", with: ">")
    }
}

enum TriviaError: Error {
    case invalidURL
    case invalidResponse
    case noData
}

struct Question: Codable {
    let type: String
    let difficulty: String
    let category: String
    let question: String
    let correctAnswer: String
    let incorrectAnswers: [String]
    
    enum CodingKeys: String, CodingKey {
        case type
        case difficulty
        case category
        case question
        case correctAnswer = "correct_answer"
        case incorrectAnswers = "incorrect_answers"
    }
}

struct TriviaResponse: Codable {
    let responseCode: Int
    let results: [Question]
    
    enum CodingKeys: String, CodingKey {
        case responseCode = "response_code"
        case results
    }
}
