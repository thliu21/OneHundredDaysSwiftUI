//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Tianhao Liu on 10/27/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var game = GameViewModel()
    
    @State private var showingAlert = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()

                VStack(spacing: 30) {
                    VStack {
                        Text("Tap the flag for")
                            .font(.system(.title))
                            .foregroundColor(.white)
                        Text(game.question.capitalized)
                            .font(.system(.largeTitle).weight(.heavy))
                            .foregroundColor(.white)
                            .padding()
                    }
                    Divider().background(Color.white).frame(width: geometry.size.width * 0.6)
                    
                    ForEach(0..<3) { num in
                        Button {
                            flagTapped(num)
                        } label: {
                            Image(game.flags[num])
                                .renderingMode(.original)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 150)
                                .shadow(radius: 4.0)
                        }
                    }
                }
            }
            .alert(isPresented: $showingAlert) {
                Alert(
                    title: Text(game.isLastAnswerCorrect ? "Right!" : "Wrong..."),
                    message: Text("Your score is \(game.score)"),
                    dismissButton: .default(Text("Ok")) {
                        nextQuestion()
                    }
                )
            }
        }
        .onAppear {
            nextQuestion()
        }
    }
    
    private func flagTapped(_ num: Int) {
        game.choose(num)
        showingAlert = true
    }
    
    private func nextQuestion() {
        game.nextQuestion()
    }
}
