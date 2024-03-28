//
//  ContentView-ViewModel.swift
//  Toss and Shoot
//
//  Created by Andrea Bottino on 28/03/2024.
//

import SwiftUI

extension ContentView {
    
    @Observable
    final class ViewModel {
        
        var shapes = [
            ShapeModel(name: "🪨", color: .purple),
            ShapeModel(name: "📄", color: .blue),
            ShapeModel(name: "✂️", color: .yellow)
        ]
        
        var opponentShape = ShapeModel(name: "🪨", color: .purple)
        
        var playerShape = ""
        var message = "Shoot!"
        var opponentScore = 0
        var playerScore = 0
        
        var playersHaveShot = false
        var playerHas = Evaluate.neutral

        var selectedButton = 4
        
        func shootResult(using shape: String) {
            if shape == opponentShape.name {
                message = "It's a tie!"
                playerHas = .tied
            } else if shape == "🪨" && opponentShape.name == "📄" {
                message = "Paper beats Rock!"
                opponentScore += 1
                playerHas = .lost
            } else if shape == "🪨" && opponentShape.name == "✂️" {
                message = "Rock beats Scissors!"
                playerScore += 1
                playerHas = .won
            } else if shape == "📄" && opponentShape.name == "✂️" {
                message = "Scissors beats Paper!"
                opponentScore += 1
                playerHas = .lost
            } else if shape == "📄" && opponentShape.name == "🪨" {
                message = "Paper beats Rock!"
                playerScore += 1
                playerHas = .won
            } else if shape == "✂️" && opponentShape.name == "🪨" {
                message = "Rock beats Scissor!"
                opponentScore += 1
                playerHas = .lost
            } else if shape == "✂️" && opponentShape.name == "📄" {
                message = "Scissors beats Paper!"
                playerScore += 1
                playerHas = .won
            }
        }
        
        func shoot(_ index: Int) {
            selectedButton = index
            opponentShape = shapes.randomElement()!
            playerShape = shapes[index].name
            playersHaveShot = true
            shootResult(using: playerShape)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) { [self] in
                reset()
            }
        }
        
        func assignColor(to result: Evaluate) -> Color {
            if result == .neutral {
                return .clear
            }  else if result == .tied {
                return .secondary
            } else if result == .won {
                return .green
            } else {
                return .red
            }
        }
        
        func reset() {
            playersHaveShot = false
            message = "Shoot!"
            playerHas = .neutral
            selectedButton = 4
        }
        
        func restartGame() {
            reset()
            playerScore = 0
            opponentScore = 0
        }
    }
}
