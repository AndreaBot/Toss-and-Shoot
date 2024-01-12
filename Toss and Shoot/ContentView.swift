//
//  ContentView.swift
//  Toss and Shoot
//
//  Created by Andrea Bottino on 11/01/2024.
//

import SwiftUI

struct ContentView: View {

    @State private var shapes = [
        ShapeModel(name: "🪨", color: .purple),
        ShapeModel(name: "📄", color: .blue),
        ShapeModel(name: "✂️", color: .yellow)
    ]

    @State private var opponentShape = ShapeModel(name: "🪨", color: .purple)
    
    @State private var playerShape = ""
    @State private var message = "Shoot!"
    @State private var opponentScore = 0
    @State private var playerScore = 0
    
    @State private var playersHaveShot = false
    @State private var playerHas = Evaluate.neutral
    
    
    var body: some View {
        ZStack {
            Color.customBackground
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Text("Player \(playerScore) - \(opponentScore) Opponent")
                    .font(.title2)
                
                ZStack {
                    VStack {
                        Spacer()
                        
                        Text(opponentShape.name)
                            .frame(maxWidth: 150, maxHeight: 150)
                            .background(opponentShape.color)
                            .opacity(playersHaveShot ? 1 : 0)
                            .clipShape(Circle())
                            .font(.system(size: 70))
                        
                        Spacer()
                        
                        Text(message)
                            .font(.title)
                            .frame(minWidth: 50, maxWidth: .infinity, minHeight: 30, maxHeight: 50)
                            .background(assignColor(to: playerHas))
                            .clipShape(.capsule)
                        
                        Spacer()
                        
                        HStack {
                            ForEach(shapes, id: \.self) { shape in
                                Button() {
                                    opponentShape = shapes.randomElement()!
                                    playerShape = shape.name
                                    playersHaveShot = true
                                    shoot(using: playerShape)
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) { [self] in
                                        reset()
                                    }
                                } label: {
                                    Text(shape.name)
                                        .font(.system(size: 50))
                                }
                                .frame(maxWidth: 150, maxHeight: 150)
                                .background(shape.color)
                                .clipShape(Circle())
                                .padding(5)
                            }
                        }
                        Spacer()
                    }
                }
                .padding()
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Button("Reset Game") {
                    reset()
                    playerScore = 0
                    opponentScore = 0
                }
                .padding()
                .font(.title3)
                .foregroundColor(.primary)
                .controlSize(.extraLarge)
                .background(RoundedRectangle(cornerRadius: 10)
                    .stroke(.primary, lineWidth: 3))
                    
            }
            .padding()
        }
        
    }
    
    func shoot(using shape: String) {
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
    }
    
    enum Evaluate {
        case neutral; case tied; case won; case lost
    }
}


#Preview {
    ContentView()
}

