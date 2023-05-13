//
//  Quiz.swift
//  QuizGame
//
//  Created by Bartłomiej on 13/05/2023.
//

import Foundation

struct Quiz: Decodable, Hashable {
    var title: String
    var questions: [Question]
}

struct Question: Decodable, Hashable {
    var question: String
    var options: [String]
    var answer: String
}

extension Quiz {
    static var empty: Self = .init(title: "", questions: [])
}

var questionMock =
"""
{
  "title": "Quiz Title",
  "questions": [
    {
      "question": "What is the capital of France?",
      "options": ["London", "Paris", "Madrid", "Berlin"],
      "answer": "Paris"
    },
    {
      "question": "Who painted the Mona Lisa?",
      "options": ["Vincent van Gogh", "Leonardo da Vinci", "Pablo Picasso", "Claude Monet"],
      "answer": "Leonardo da Vinci"
    },
    {
      "question": "Which planet is known as the Red Planet?",
      "options": ["Mars", "Jupiter", "Mercury", "Saturn"],
      "answer": "Mars"
    },
    {
      "question": "What is the largest organ in the human body?",
      "options": ["Liver", "Heart", "Lungs", "Skin"],
      "answer": "Skin"
    },
    {
      "question": "What is the chemical symbol for gold?",
      "options": ["Ag", "Au", "Fe", "Hg"],
      "answer": "Au"
    },
    {
      "question": "Which country is home to the kangaroo?",
      "options": ["Australia", "Brazil", "Canada", "India"],
      "answer": "Australia"
    },
    {
      "question": "Who wrote the play 'Romeo and Juliet'?",
      "options": ["William Shakespeare", "Jane Austen", "Mark Twain", "Charles Dickens"],
      "answer": "William Shakespeare"
    },
    {
      "question": "Which instrument is known as the 'king of instruments'?",
      "options": ["Guitar", "Piano", "Violin", "Drums"],
      "answer": "Piano"
    },
    {
      "question": "What is the tallest mountain in the world?",
      "options": ["Mount Everest", "K2", "Makalu", "Kangchenjunga"],
      "answer": "Mount Everest"
    },
    {
      "question": "Who discovered penicillin?",
      "options": ["Alexander Fleming", "Marie Curie", "Albert Einstein", "Isaac Newton"],
      "answer": "Alexander Fleming"
    }
  ]
}

"""

var questionsArrayMock: [Question] = [
    .init(question: "Which country won the FIFA World Cup in 2018?", options: ["France", "Brazil", "Germany", "Spain"], answer: "France"),
    
        .init(question: "Who is the all-time leading scorer in NBA history?", options: ["Kareem Abdul-Jabbar", "LeBron James", "Michael Jordan", "Kobe Bryant"], answer: "Kareem Abdul-Jabbar"),
    
        .init(question: "Which team has won the most Super Bowl titles?", options: ["New England Patriots", "San Francisco 49ers", "Pittsburgh Steelers", "Dallas Cowboys"], answer: "New England Patriots")
]
