//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Tianhao Liu on 10/27/22.
//

import SwiftUI

struct ContentView: View {
    static let countries = ["china", "france", "germany", "italy", "japan", "korea", "russia", "spain", "uk", "us"]
    
    @State private var showingAlert = false
    
    @State private var flags: ArraySlice<String> = Self.countries.shuffled()[0..<3]
    @State private var correctAnswer = Int.random(in: 0..<3)
    
    @State private var isAnswerCorrect = false
    @State private var score = 0
    
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
                        Text(flags[correctAnswer].capitalized)
                            .font(.system(.largeTitle).weight(.heavy))
                            .foregroundColor(.white)
                            .padding()
                    }
                    Divider().background(Color.white).frame(width: geometry.size.width * 0.6)
                    
                    ForEach(0..<3) { num in
                        Button {
                            flagTapped(num)
                        } label: {
                            Image(flags[num])
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
                    title: Text(isAnswerCorrect ? "Right!" : "Wrong..."),
                    message: Text("Your score is \(score)"),
                    dismissButton: .default(Text("Ok")) {
                        resetGame()
                    }
                )
            }
        }
        .onAppear {
            resetGame()
        }
    }
    
    private func flagTapped(_ num: Int) {
        isAnswerCorrect = num == correctAnswer
        score += num == correctAnswer ? 1 : 0
        showingAlert = true
    }
    
    private func resetGame() {
        correctAnswer = Int.random(in: 0..<3)
        flags = Self.countries.shuffled()[0..<3]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
