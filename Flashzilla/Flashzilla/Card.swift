//
//  Card.swift
//  Flashzilla
//
//  Created by saliou seck on 29/04/2024.
//

import Foundation

struct Card : Codable, Identifiable, Equatable {
    var id = UUID()
    var prompt: String
    var answer: String

    static let example = Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
}
