//
//  ContentView.swift
//  RockPaperScissorsToggleGame
//
//  Created by saliou seck on 31/01/2024.
//

import SwiftUI

struct ContentView: View {
    let possibleMove = ["Rock", "Scissors", "Paper"]
    @State private var showDialog = false
    @State private var currentChoice : Int = Int.random(in: 0..<3)
    @State private var shouldWin: Bool = Bool.random()
    @State private var playerMove : Int = 0
    @State private var score = 0
    @State private var currentGameTour = 0
    @State private var maxTour = 10
    
    var body: some View {
        NavigationStack{
            VStack {
                Form {
                    Section {
                        Text("Game Tour \(currentGameTour)")
                    }
                    Text("Score: \(score)")
                    Text("Move: \(possibleMove[currentChoice])")
                    Text(shouldWin ?"Win":"Loose")
                }
                .frame(height: 400)
                HStack( alignment: .center){
                    ForEach(0..<3, id: \.self) { number in
                        Spacer()
                        Button{
                            //playerMove = number
                            print("Executed \(number)")
                            validateAnswer(choice: number)
                        } label: {Text(possibleMove[number])}.buttonStyle(.borderedProminent)
                            .frame(minWidth: 100)
                        Spacer()
                            
                        
                    }
                }
                    
            }
        }.alert("Game Recap ", isPresented: $showDialog, actions: {
            Button("Restart"){ 
                restartGame()
            }
        }, message: {
            Text("Your score is \(score)")
        })
    }
    func checkAnswer(_ choice: Int) -> Bool {
        if(possibleMove[currentChoice] == "Rock"){
            if(possibleMove[choice] == "Paper"){
                return true
            }else{
                return false
            }
        }else if (possibleMove[currentChoice] == "Paper"){
            if(possibleMove[choice] == "Scissors"){
                return true
            }else{
                return false
            }
        }else{
            if(possibleMove[choice] == "Rock"){
                return true
            }else{
                return false
            }
        }
    }
    
    func validateAnswer(choice: Int){
        var answer : Bool
        if(shouldWin){
            answer = checkAnswer(choice)
        }else{
            answer = !checkAnswer(choice)
        }
        handleWinOrLost(hasWin: answer)
        
    }
    
    func restartGame(){
       currentChoice = Int.random(in: 0..<3)
        shouldWin = Bool.random()
       playerMove = 0
        score = 0
       currentGameTour = 0
    }
    
    func nextGame(){
        currentChoice = Int.random(in: 0..<3)
        shouldWin.toggle()
        currentGameTour  = currentGameTour + 1
    }
    
    func handleWinOrLost(hasWin: Bool){
        
        if(currentGameTour==10){
            showDialog = true
        }else{
            if(hasWin){
                score = score + 1
            }else{
                score = score - 1
            }
            nextGame()
        }
       
    }
   
    
}

#Preview {
    ContentView()
}
