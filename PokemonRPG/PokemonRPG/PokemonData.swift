//
//  MyModel.swift
//  FetchAPI
//
//  Created by Kevin Jusino on 9/21/22.
//

import Foundation


struct MyModel: Decodable {
    let firstString: String
    let stringArray: [String]

    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        firstString = try container.decode(String.self)
        stringArray = try container.decode([String].self)
    }
}


struct PokemonData: Decodable{
  //  {"base_experience":270,"base_happiness":100,"capture_rate":45,"color_id":6,"conquest_order":null,"evolution_chain_id":78,"evolves_from_species_id":null,"forms_switchable":0,"gender_rate":-1,"generation_id":1,"growth_rate_id":4,"habitat_id":5,"has_gender_differences":0,"hatch_counter":120,"height":4,"id":151,"id:1":151,"identifier":"mew","is_baby":0,"is_default":1,"name":"Mew","order":182,"order:1":182,"shape_id":6,"species_id":151,"weight":40}
    
    var base_experience: Int
    var base_happiness: Int
    var capture_rate: Int
    var name: String
    var height: Int
    var id: Int
    
}
