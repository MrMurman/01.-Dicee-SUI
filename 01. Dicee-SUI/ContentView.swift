//
//  ContentView.swift
//  01. Dicee-SUI
//
//  Created by Андрей Бородкин on 17.01.2023.
//

import SwiftUI

var dice = ["DiceOne", "DiceTwo", "DiceThree", "DiceFour", "DiceFive", "DiceSix"]

let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()



struct ContentView: View {
    
    @State var diceStationary = true
    @State var timeRemaining = 0
    @State var diceOneImageName = "DiceOne"
    @State var diceTwoImageName = "DiceOne"
    @State var imageOpacity = 1.0
    
    var body: some View {
        ZStack {
            Image("GreenBackground")
                .resizable()
                .scaledToFill()
            .ignoresSafeArea()
            VStack(spacing: 100){
                Image("DiceeLogo")
                
                HStack(spacing:50) {
                    Image(diceOneImageName)
                        .animation(.easeIn)
                    Image(diceTwoImageName)
                        .animation(.easeInOut)
                }
                .onReceive(timer) { time in
                    if timeRemaining > 0 {
                        timeRemaining -= 1
                        self.imageOpacity = 0.5
                        self.diceOneImageName = dice.randomElement() ?? "DiceOne"
                        self.diceTwoImageName = dice.randomElement() ?? "DiceOne"
                        self.imageOpacity = 1
                    }
                }
                .opacity(imageOpacity)
                
                Button(diceStationary ? "Roll" : "Stop") {
                    self.diceStationary.toggle()
                    if diceStationary {
                        self.timeRemaining = 0
                        self.imageOpacity = 1
                    } else {
                        self.timeRemaining = 100
                    }
                }
                .frame(width: 200, height: 60, alignment: .center)
                .background(Color(red: 0.608, green: 0.112, blue: 0.12))
                .foregroundColor(.white)
                .cornerRadius(8)
                .font(.system(size: 30))
                            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
