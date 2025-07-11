//
//  TriviaQuestions.swift
//  Trivia
//
//  Created by Patrick Kariuki on 6/22/25.
//

struct TriviaQuestion {
    let topic: String
    let question: String
    let options: [String]
    let correctAnswerIndex: Int
}

func getMockData() -> [TriviaQuestion] {
    return [
        // Video Games
        TriviaQuestion(
            topic: "Entertainment: Video Games",
            question: "Which company developed the game 'The Witcher 3: Wild Hunt'?",
            options: ["Bethesda", "CD Projekt Red", "BioWare", "Ubisoft"],
            correctAnswerIndex: 1
        ),
        
        TriviaQuestion(
            topic: "Entertainment: Video Games",
            question: "What is the highest selling video game of all time?",
            options: ["Tetris", "Minecraft", "Grand Theft Auto V", "Super Mario Bros."],
            correctAnswerIndex: 1
        ),
        
        // Science
        TriviaQuestion(
            topic: "Science: Nature",
            question: "What is the chemical symbol for gold?",
            options: ["Go", "Gd", "Au", "Ag"],
            correctAnswerIndex: 2
        ),
        
        // History
        TriviaQuestion(
            topic: "History",
            question: "In which year did World War II end?",
            options: ["1944", "1945", "1946", "1947"],
            correctAnswerIndex: 1
        ),
        
        TriviaQuestion(
            topic: "History",
            question: "Who was the first person to walk on the moon?",
            options: ["Buzz Aldrin", "Neil Armstrong", "John Glenn", "Alan Shepard"],
            correctAnswerIndex: 1
        ),
        
        // Geography
        TriviaQuestion(
            topic: "Geography",
            question: "What is the capital of Australia?",
            options: ["Sydney", "Melbourne", "Canberra", "Perth"],
            correctAnswerIndex: 2
        ),
        
        TriviaQuestion(
            topic: "Geography",
            question: "Which is the longest river in the world?",
            options: ["Amazon River", "Nile River", "Mississippi River", "Yangtze River"],
            correctAnswerIndex: 1
        ),
        
        // Entertainment: Movies
        TriviaQuestion(
            topic: "Entertainment: Film",
            question: "Which movie won the Academy Award for Best Picture in 2020?",
            options: ["1917", "Joker", "Parasite", "Once Upon a Time in Hollywood"],
            correctAnswerIndex: 2
        ),
        
        TriviaQuestion(
            topic: "Entertainment: Film",
            question: "Who directed the movie 'Inception'?",
            options: ["Steven Spielberg", "Christopher Nolan", "Martin Scorsese", "Quentin Tarantino"],
            correctAnswerIndex: 1
        ),
        
        // Sports
        TriviaQuestion(
            topic: "Sports",
            question: "How many players are on a basketball team on the court at one time?",
            options: ["4", "5", "6", "7"],
            correctAnswerIndex: 1
        )
    ]
}
