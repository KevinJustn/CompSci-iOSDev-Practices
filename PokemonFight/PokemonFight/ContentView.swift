//
//  ContentView.swift
//  PokemonFight
//
//  Created by SI CHEN on 9/7/22.
//

import SwiftUI

struct ContentView: View {
    @State var result:String = "Let's fight!"
    @State var randomNumber1 = Int.random(in:1...100)
    @State var randomNumber2 = Int.random(in:1...100)
    @State var pokemon1Shake: Bool = false
    @State var pokemon2Shake: Bool = false
    
    @State var hp1 = 1000
    @State var hp2 = 1000
    @State var alternate = 0
    @State var damage = 0
    var body: some View {
        Text(result)
            .padding()
        let pokemon1:String = String(format: "%03d", randomNumber1)
        let pokemon2:String = String(format: "%03d", randomNumber2)
        VStack{
            HStack{
                VStack{
                    Image(pokemon1).offset(x: pokemon1Shake ? -10 : 0)
                        .animation(Animation.default.repeatCount(5))
                    Text("HP: \(hp1)")
                }
                VStack{
                    Image(pokemon2).offset(x: pokemon2Shake ? -10 : 0)
                        .animation(Animation.default.repeatCount(5))
                    Text("HP: \(hp2)")
                }
            }
            Button("Attack!") {
                if result == "Pokemon 1 Wins!" || result == "Pokemon 2 Wins!" {
                    hp1 = hp1
                    hp2 = hp2
                }
                else {
                    if alternate % 2 == 0 {
                        self.pokemon1Shake.toggle()
                        damage = Int.random(in:1...100)
                        result = "Pokemon 1 did \(damage) damage to Pokemon 2!"
                        hp2 -= damage
                        if hp2 <= 0 {
                            hp2 = 0
                            result = "Pokemon 1 Wins!"
                        }
                    }
                    else {
                        self.pokemon2Shake.toggle()
                        damage = Int.random(in:1...100)
                        hp1 -= damage
                        result = "Pokemon 2 did \(damage) damage to Pokemon 1!"
                        if hp1 <= 0 {
                            hp1 = 0
                            result = "Pokemon 2 Wins!"
                        }
                    }
                    alternate += 1
                }
            }
            
            Button("Replay")
            {
                randomNumber1 = Int.random(in:1...100)
                randomNumber2 = Int.random(in:1...100)
                result = "Let's fight!"
                hp1 = 1000
                hp2 = 1000
                alternate = 0
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

    struct Shake: GeometryEffect {
        var amount: CGFloat = 10
        var shakesPerUnit = 3
        var animatableData: CGFloat

        func effectValue(size: CGSize) -> ProjectionTransform {
            ProjectionTransform(CGAffineTransform(translationX:
                amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)),
                y: 0))
        }
    }
