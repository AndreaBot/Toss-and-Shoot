//
//  ContentView.swift
//  Toss and Shoot
//
//  Created by Andrea Bottino on 11/01/2024.
//


import SwiftUI

struct ContentView: View {
    
    @State private var viewModel = ViewModel()
    
    var body: some View {
        ZStack {
            Color.customBackground
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                
                Text("Me  \(viewModel.playerScore) - \(viewModel.opponentScore)  A.I.")
                    .font(.title2)
                
                ZStack {
                    VStack {
                        Spacer()
                        
                        Text(viewModel.opponentShape.name)
                            .frame(maxWidth: 150, maxHeight: 150)
                            .background(viewModel.opponentShape.color)
                            .opacity(viewModel.playersHaveShot ? 1 : 0)
                            .clipShape(Circle())
                            .font(.system(size: 70))
                        
                        Spacer()
                        
                        Text(viewModel.message)
                            .font(.title)
                            .frame(minWidth: 50, maxWidth: .infinity, minHeight: 30, maxHeight: 50)
                            .background(viewModel.assignColor(to: viewModel.playerHas))
                            .clipShape(.capsule)
                        
                        Spacer()
                        
                        HStack(spacing: 15) {
                            ForEach(Array(viewModel.shapes.indices), id: \.self) { index in
                                Button {
                                    viewModel.shoot(index)
                                } label: {
                                    Text(viewModel.shapes[index].name)
                                        .font(.system(size: 50))
                                }
                                .frame(maxWidth: 150, maxHeight: 150)
                                .background(viewModel.shapes[index].color)
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(viewModel.selectedButton == index ? .primary : Color.clear, lineWidth: 6)
                                )
                            }
                        }
                        
                        Spacer()
                    }
                }
                .padding()
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Button("Reset Score") {
                    viewModel.restartGame()
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
}


#Preview {
    ContentView()
}


