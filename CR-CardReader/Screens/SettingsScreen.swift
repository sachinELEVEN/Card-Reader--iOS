//
//  SettingsScreen.swift
//  CardReader
//
//  Created by sachin jeph on 18/08/19.
//  Copyright © 2019 sachin jeph. All rights reserved.
//

import SwiftUI

var DirectContactCreation = false
struct SettingsScreen: View {

     @State var strON_OFF2 = ""

    var body: some View {
    NavigationView{
        ScrollView(.vertical){
                
                
            VStack{
               // Section{
                Text("Tap to \(strON_OFF2) Allow to Create Contacts Automatically").font(.headline).padding()
                                         
                
                Button(action:{withAnimation{self.createContactDirectly()}}){
                     
                       
                         //   VStack(A) {
                           
                        
                      //  }.lineLimit(nil)
                        
                        
                            Rectangle()
                            .fill(DirectContactCreation ? Color.green : Color.secondary)
                                .frame(width:DirectContactCreation ? 200 : 150,height: DirectContactCreation ? 50 : 37.5)
                            .cornerRadius(15)
                        
                        }//.frame(height:fullWidth - fullWidth/10)
               
                
                Spacer()
            }
            .frame(width:fullWidth - fullWidth/10,height:fullHeight/4)
            .foregroundColor(.primary)
                    .lineLimit(nil)
                       
                        .background(Color.secondary.opacity(0.2))
            .cornerRadius(20)
            .padding()
            .navigationBarTitle("Settings")
        }.navigationBarTitle("Settings")
    }
        
    }
    
    func createContactDirectly(){
        
        if(UserDefaults.standard.bool(forKey: "DirectContactCreation")){
            UserDefaults.standard.set(false,forKey: "DirectContactCreation")
            DirectContactCreation = false
            strON_OFF2 = ""
            
        }
            
        else{
            UserDefaults.standard.set(true,forKey: "DirectContactCreation")
             DirectContactCreation = true
            strON_OFF2 = "Not"
        }
        
    }
}

//done2
