//
//  APIData.swift
//  FetchAPI
//
//  Created by Kevin Jusino on 9/21/22.
//

import Foundation

class APIData: ObservableObject{
    var pokemonName: String = ""
    var base_exp: Int = -1
    var base_happiness: Int = -1
    var capture_rate: Int = -1
    var height: Int = -1
    var id: Int = 0
    init(PokemonID: Int){

        fetchAPIData(completionHandler: { (PokemonData) in
            self.pokemonName = PokemonData.name
            self.base_exp = PokemonData.base_experience
            self.base_happiness = PokemonData.base_happiness
            self.capture_rate = PokemonData.capture_rate
            self.height = PokemonData.height
            self.id = PokemonData.id

        }, pokemonID: PokemonID)
       
    }
    
    func fetchNew (PokemonID: Int) -> Void{
            self.fetchAPIData(completionHandler: { (PokemonData) in
            self.pokemonName = PokemonData.name
            self.base_exp = PokemonData.base_experience
            self.base_happiness = PokemonData.base_happiness
            self.capture_rate = PokemonData.capture_rate
            self.id = PokemonData.id
        }, pokemonID: PokemonID)

    }
    
    func fetchAPIData(completionHandler: @escaping (PokemonData) -> Void, pokemonID: Int){
        
        let url = URL(string: "https://king-prawn-app-zx6tp.ondigitalocean.app/pokemon/api/v1.0/pokemon_id/" + String(pokemonID))!
        var task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            
            do{
                let pokemonData = try JSONDecoder().decode(PokemonData.self, from: data)
                completionHandler(pokemonData)
            }
            catch{
                let error = error
                print(error.localizedDescription)
            }
        }.resume()
    }
    
   
}
