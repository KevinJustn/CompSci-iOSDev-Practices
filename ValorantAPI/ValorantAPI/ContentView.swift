//
//  ContentView.swift
//  ValorantAPI
//
//  Created by Kevin Jusino on 10/31/22.
//

import SwiftUI
import Subsonic


struct ContentView: View {
    @StateObject private var sound = SubsonicPlayer(sound: "Character_Select.mp3")
    @ObservedObject var apiData:APIData = APIData(ValID: "")
    @State var valID: String = "" // image should etner this string
    @State var valURL: String = ""
    @State var name = ""
    @State var desc = ""
    @State var dname = ""
    @State var disp = "logo" // make the default the Valorant Logo
    @State var roleType = ""
    @State var defaulttext = "Enter an Agent's Name"
    @State var trueInt = 0
    


    
    var body: some View {
        ZStack {
            Color.red.edgesIgnoringSafeArea(.all)
            VStack {
                
                Image(disp)
                Text(self.defaulttext).font( // Text Field for Default String:
                    .system(size: 25)
                    .weight(.heavy)
                    
                )
                Text(self.name).font( // Text Field for Name:
                    .system(size: 23)
                    .weight(.heavy)
                    
                )
                Text(self.roleType).font( // Text Field for Role Type:
                    .system(size: 21)
                    .weight(.heavy)
                    
                )
                Text(self.dname).font( // Text Field for Developer Name:
                    .system(size: 15)
                    .weight(.heavy)
                    
                )
                Text(self.desc).lineSpacing(2).multilineTextAlignment(.center).font( // Text Field for Description:
                    .system(size: 12)
                    .weight(.heavy)
                    
                )
                
                TextField("Agent Name (Ex: Fade)", text: $valURL).background(Color(.white)).multilineTextAlignment(.center).padding(6.0)
                    .background(RoundedRectangle(cornerRadius: 4.0, style: .continuous)
                        .stroke(.red, lineWidth: 1.0))
                    .padding()
                
                Button("Search Agent"){ // Figure out how to connect button to individual URL
                    switch (valURL.localizedLowercase) {
                    case "fade":
                        valID = "dade69b4-4f5a-8528-247b-219e5a1facd6"
                        self.disp = "fade"
                        trueInt = 1
                    case "breach":
                        valID = "5f8d3a7f-467b-97f3-062c-13acf203c006"
                        self.disp = "breach"
                        trueInt = 1
                    case "raze":
                        valID = "f94c3b30-42be-e959-889c-5aa313dba261"
                        self.disp = "raze"
                        trueInt = 1
                    case "chamber":
                        valID = "22697a3d-45bf-8dd7-4fec-84a9e28c69d7"
                        self.disp = "chamber"
                        trueInt = 1
                    case "kay/o":
                        valID = "601dbbe7-43ce-be57-2a40-4abd24953621"
                        self.disp = "kayo"
                        trueInt = 1
                    case "skye":
                        valID = "6f2a04ca-43e0-be17-7f36-b3908627744d"
                        self.disp = "skye"
                        trueInt = 1
                    case "cypher":
                        valID = "117ed9e3-49f3-6512-3ccf-0cada7e3823b"
                        self.disp = "cypher"
                        trueInt = 1
                    case "sova":
                        valID = "320b2a48-4d9b-a075-30f1-1f93a9b638fa"
                        self.disp = "sova"
                        trueInt = 1
                    case "killjoy":
                        valID = "1e58de9c-4950-5125-93e9-a0aee9f98746"
                        self.disp = "killjoy"
                        trueInt = 1
                    case "harbor":
                        valID = "95b78ed7-4637-86d9-7e41-71ba8c293152"
                        self.disp = "harbor"
                        trueInt = 1
                    case "viper":
                        valID = "707eab51-4836-f488-046a-cda6bf494859"
                        self.disp = "viper"
                        trueInt = 1
                    case "phoenix":
                        valID = "eb93336a-449b-9c1b-0a54-a891f7921d69"
                        self.disp = "phoenix"
                        trueInt = 1
                    case "astra":
                        valID = "41fb69c1-4189-7b37-f117-bcaf1e96f1bf"
                        self.disp = "astra"
                        trueInt = 1
                    case "brimstone":
                        valID = "9f0d8ba9-4140-b941-57d3-a7ad57c6b417"
                        self.disp = "brimstone"
                        trueInt = 1
                    case "neon":
                        valID = "bb2a4828-46eb-8cd1-e765-15848195d751"
                        self.disp = "neon"
                        trueInt = 1
                    case "yoru":
                        valID = "7f94d92c-4234-0a36-9646-3a87eb8b5c89"
                        self.disp = "yoru"
                        trueInt = 1
                    case "sage":
                        valID = "569fdd95-4d10-43ab-ca70-79becc718b46"
                        self.disp = "sage"
                        trueInt = 1
                    case "reyna":
                        valID = "a3bfb853-43b2-7238-a4f1-ad90e9e46bcc"
                        self.disp = "reyna"
                        trueInt = 1
                    case "omen":
                        valID = "8e253930-4c05-31dd-1b6c-968525494517"
                        self.disp = "omen"
                        trueInt = 1
                    case "jet":
                        valID = "add6443a-41bd-e414-f6ad-e58d267f4e95"
                        self.disp = "jet"
                        trueInt = 1
                    default:
                        valID = "None"
                        self.disp = "logo"
                        trueInt = 0
                        
                    }
                    
                    switch trueInt {
                    case 1:
                        self.valID  = valID
                        apiData.fetchNew(ValID: self.valID)
                        sleep(1)
                        self.name = "Name: " + apiData.name
                        self.roleType = "Role Type: " + apiData.roleType
                        self.dname = "Developer Name: " + apiData.dname
                        self.desc = "Description: \n" + apiData.desc
                        defaulttext = ""
                        
                    default:
                        defaulttext = "Invalid Agent Name: \nEnter an Agent's Name"
                        name = ""
                        roleType = ""
                        dname = ""
                        desc = ""
                    }
                    
                    
                } .tint(.green)
                    .controlSize(.large)
                    .buttonStyle(.borderedProminent)
                
                Text("Enjoy some music!").font( // Text Field for Name:
                    .system(size: 20)
                    .weight(.heavy)
                )
                HStack {
                    Button("Play") {
                        sound.play()
                    }.tint(.blue)
                        .controlSize(.small)
                        .buttonStyle(.borderedProminent)
                    Button("Stop") {
                        sound.stop()
                    }.tint(.black)
                        .controlSize(.small)
                        .buttonStyle(.borderedProminent)
                }
            }
            .padding()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }

}


