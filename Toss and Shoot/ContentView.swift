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
    @State private var message = "TEST"
    @State private var opponentScore = 0
    @State private var playerScore = 0
    
    
    var body: some View {
        VStack {
            Spacer()
            Text("Opponent \(opponentScore) - \(playerScore) Player")
            Spacer()
            Text(shapes.randomElement()!)
                .frame(maxWidth: 200, maxHeight: 200)
                .background(.orange)
                .clipShape(Circle())
                .font(.system(size: 90))
            Spacer()
            Text(message)
            Spacer()
            
            HStack {
            ForEach(shapes, id: \.self) { shape in
                
                Button() {
                    print(shape)
                } label: {
                    Text("\(shape)")
                }
                .frame(maxWidth: 200, maxHeight: 200)
                .background(.orange)
                .clipShape(Circle())
                .font(.system(size: 90))
                }
            }
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

