//
//  ContentView.swift
//  Toss and Shoot
//
//  Created by Andrea Bottino on 11/01/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var shapes = ["🪨", "📄", "✂️"]
    @State private var opponentShape = ""
    @State private var playerShape = ""
    @State private var message = "Shoot!"
    @State private var opponentScore = 0
    @State private var playerScore = 0
    
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Player \(playerScore) - \(opponentScore) Opponent")
            
            Spacer()
            
            Text(opponentShape)
                .frame(maxWidth: 150, maxHeight: 150)
                .background(.orange)
                .clipShape(Circle())
                .font(.system(size: 70))
            
            Spacer()
            
            Text(message)
            
            Spacer()
            
            HStack {
                ForEach(shapes, id: \.self) { shape in
                    
                    Button() {
                        opponentShape = shapes.randomElement()!
                        playerShape = shape
                        shoot(using: playerShape)
                    } label: {
                        Text("\(shape)")
                    }
                    .frame(maxWidth: 200, maxHeight: 200)
                    .background(.orange)
                    .clipShape(Circle())
                    .font(.system(size: 70))
                }
            }
            
            Spacer()
        }
        .padding()
    }
    
    func shoot(using shape: String) {
        if shape == opponentShape {
            message = "IT'S A TIE!"
        } else if shape == "🪨" && opponentShape == "📄" {
            message = "Paper beats Rock!"
            opponentScore += 1
        } else if shape == "🪨" && opponentShape == "✂️" {
            message = "Rock beats Scissors!"
            playerScore += 1
        } else if shape == "📄" && opponentShape == "✂️" {
            message = "Scissors beats Paper!"
            opponentScore += 1
        } else if shape == "📄" && opponentShape == "🪨" {
            message = "Paper beats Rock!"
            playerScore += 1
        } else if shape == "✂️" && opponentShape == "🪨" {
            message = "Rock beats Scissor!"
            opponentScore += 1
        } else if shape == "✂️" && opponentShape == "📄" {
            message = "Scissors beats Paper!"
            playerScore += 1
        }
    }
}

#Preview {
    ContentView()
}

