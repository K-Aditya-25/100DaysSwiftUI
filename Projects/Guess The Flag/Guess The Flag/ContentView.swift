//
//  ContentView.swift
//  Guess The Flag
//
//  Created by Aditya Kharbanda on 12/07/24.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var score = 0
    var body: some View {
        ZStack{
//            RadialGradient(stops: [
//                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
//                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
//            ], center: .top, startRadius: 200, endRadius: 700)
//            LinearGradient(colors: [.red, .yellow], startPoint: .top, endPoint: .bottom)
            LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 15){
                Spacer()
                Text("Guess The Flag")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                Spacer()
                VStack{
                    Text("Choose the flag of")
                        .foregroundColor(.primary)
                        .font(.title3)
                        .fontWeight(.heavy)
                    
                    Text(countries[correctAnswer])
                        .foregroundColor(.primary)
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                
                    ForEach(0..<3){number in
                        Button{
                            //flag was tapped
                            flagTapped(number)
                        }label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .padding(20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                Spacer()
                Text("Player Score: \(score)")
                    .foregroundColor(.white)
                    .fontWeight(.heavy)
                    .font(.title)
                    .padding(20)
                Spacer()
            }
            .padding()
            .shadow(radius: 10)
            
        }
        
        .alert(scoreTitle, isPresented: $showingScore){
            Button("Continue", action: askQuestion)
        }message: {
            Text("Your Score Is: \(score)")
        }
    }
    func flagTapped(_ number: Int){
        if number == correctAnswer{
            scoreTitle = "Correct!"
            score += 1
        }
        else{
            scoreTitle = "Wrong!"
            if score == 0{
//                
            }else{
                score -= 1
            }
        }
        showingScore = true
    }
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

#Preview {
    ContentView()
}
