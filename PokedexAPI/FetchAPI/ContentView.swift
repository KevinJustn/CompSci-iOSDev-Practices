//
//  ContentView.swift
//  FetchAPI
//
//  Created by SI CHEN on 10/03/22.
//

import SwiftUI


struct ContentView: View {
    @ObservedObject var apiData:APIData = APIData(PokemonID: 1)
    @State var pokemonID: Int = 1
    @State var pokemonID_String: String = ""
    @State var pokemonName: String = "Bulbasaur"
    @State var base_exp: Int = 64
    @State var base_happiness: Int = 70
    @State var capture_rate: Int = 45

    
    var body: some View {
        VStack {
      
            let pokemonID_string = String(format: "%03d", self.pokemonID)
            Image(pokemonID_string)
            Text("Name:" + self.pokemonName).font(
                .system(size: 20)
                .weight(.heavy)

            )
            Text("Base Exp:" + String(self.base_exp)).font(
                .system(size: 15)
                .weight(.heavy)

            )
            Text("Base Happiness:"+String(self.base_happiness)).font(
                .system(size: 15)
                .weight(.heavy)

            )
            Text("Capture Rate: " + String(self.capture_rate)).font(
                .system(size: 15)
                .weight(.heavy)

            )
            TextField("pokemon ID", text: $pokemonID_String).multilineTextAlignment(.center).padding(6.0)
                .background(RoundedRectangle(cornerRadius: 4.0, style: .continuous)
                              .stroke(.gray, lineWidth: 1.0))
                .padding()
           
            Button("Search"){
                
                    self.pokemonID  = Int(pokemonID_String) ?? 0
                    apiData.fetchNew(PokemonID: self.pokemonID)
                    sleep(1)
                    self.pokemonName = apiData.pokemonName
                    self.base_exp = apiData.base_exp
                    self.capture_rate = apiData.capture_rate
                    self.base_happiness = apiData.base_happiness
                
            } .tint(.green)
                .controlSize(.large)
                .buttonStyle(.borderedProminent)
         
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }

}
