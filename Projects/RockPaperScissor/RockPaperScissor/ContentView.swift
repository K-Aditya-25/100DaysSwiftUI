//
//  ContentView.swift
//  RockPaperScissor
//
//  Created by Aditya Kharbanda on 16/07/24.
//

import SwiftUI


struct GradientBackground: View {
    var body: some View {
        LinearGradient(colors: [.red, .white], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }
}

struct ContentView: View {
    let options = ["Rock", "Paper", "Scissors"]
    let emojis = ["🪨", "🧻", "✂️"]
    @State private var shouldWin = Bool.random()
    @State private var appChoice = Int.random(in: 0..<3)
    @State private var score = 0
    @State private var round = 0
    
    @State private var showAlert = false
    
    var body: some View {
        ZStack{
            GradientBackground()
            VStack(){
                Text("\(emojis[appChoice])")
                    .font(.system(size: 150))
                Text("\(options[appChoice].uppercased())")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .fontWeight(.heavy)
                Text(shouldWin ? "You Have To WIN" : "You Have To LOSE")
                    .font(.title)
                    .foregroundStyle(.white)
                    .fontWeight(.heavy)
                    .padding(20)
                Spacer()
                VStack(spacing: 30){
                    ForEach(0..<3){number in
                        Button(action:{
                            buttonTapped(number)
                        },
                               label: {
                            Text("\(options[number])")
                                .padding(5)
                                .foregroundStyle(RadialGradient(
                                    gradient: Gradient(colors: [.red, .white]),
                                    center: .center,
                                    startRadius: 20,
                                    endRadius: 200
                                ))
                                .font(.title.bold())
                                .padding(15)
                        })
                        
                        
                    }
                    
                }
                .frame(minWidth: 100, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .padding(5)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                Spacer()
                Text("Score: \(score)")
                    .font(.system(size: 30))
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding(20)
            
            
        }
        .alert("Game Over", isPresented: $showAlert){
            Button("Restart", action: resetGame)
        }message:{
            Text("Score At The End Of 10 Rounds: \(score)")
        }
        
        
    }
    func buttonTapped(_ number: Int){
        if shouldWin{
            if (appChoice == 0 && number == 1) || (appChoice == 1 && number == 2) || (appChoice == 2 && number == 0){
                score += 1
            }
            else{
                if score == 0{}
                else{score -= 1}
            }
        }
        else{
            if (appChoice == 0 && number == 2) || (appChoice == 1 && number == 0) || (appChoice == 2 && number == 1){
                score += 1
            }
            else{
                if score == 0{}
                else{score -= 1}
            }
        }
        round += 1
        if round == 10{
            showAlert = true
        }
        else{
            nextRound()
        }
        
    }
    func nextRound(){
        appChoice = Int.random(in: 0...2)
        shouldWin.toggle()
    }
    func resetGame(){
        score = 0
        round = 0
        nextRound()
    }
}

#Preview {
    ContentView()
}
