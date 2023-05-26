//
//  APIData.swift
//  ValorantAPI
//
//  Created by Kevin Jusino on 10/31/22.
//

import Foundation

class APIData: ObservableObject{
    var ValID: String = ""
    var name: String = ""
    var desc: String = ""
    var dname: String = ""
    var disp: String = ""
    var roleType: String = ""

    init(ValID: String){

        fetchAPIData(completionHandler: { (ValorantData) in
            self.name = ValorantData.data.displayName
            self.desc = ValorantData.data.description
            self.dname = ValorantData.data.developerName
            self.roleType = ValorantData.data.role.displayName

        }, valID: ValID)
       
    }
    
    func fetchNew (ValID: String) -> Void{
            self.fetchAPIData(completionHandler: { (ValorantData) in
                self.name = ValorantData.data.displayName
                self.desc = ValorantData.data.description
                self.dname = ValorantData.data.developerName
                self.roleType = ValorantData.data.role.displayName

            }, valID: ValID)

    }
    
    func fetchAPIData(completionHandler: @escaping (ValorantData) -> Void, valID: String){ // Figure out ID function
        
        let url = URL(string: "https://valorant-api.com/v1/agents/" + (valID))!
        var task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            
            do{
                let valorantData = try JSONDecoder().decode(ValorantData.self, from: data)
                completionHandler(valorantData)
            }
            catch{
                let error = error
                print(error.localizedDescription)
            }
        }.resume()
    }
    
}

