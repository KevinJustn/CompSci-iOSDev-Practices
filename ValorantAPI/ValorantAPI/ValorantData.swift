//
//  ValorantData.swift
//  ValorantAPI
//
//  Created by Kevin Jusino on 10/31/22.
//

import Foundation

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


struct ValorantData: Decodable {
    
    var data: Data
}

struct Data: Decodable {
    var displayName: String // name
    var description: String // descriptiuon
    var developerName: String // dname
    var role: Role
}

struct Role: Decodable {
    var displayName: String // role
}
