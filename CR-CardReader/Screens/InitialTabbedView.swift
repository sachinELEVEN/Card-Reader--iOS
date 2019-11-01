//
//  InitialTabbedView.swift
//
//
//  Created by sachin jeph on 24/07/19.
//  Copyright © 2019 sachin jeph. All rights reserved.
//

import SwiftUI

struct InitialTabbedView: View {
    
    var body: some View {
        TabView{
            
           cardScanScreen()
                .tabItem {
                                           VStack{
                                               Image(systemName: "doc.text.viewfinder")
                                            .resizable()
                                            .scaledToFit()
                                               Text("Scan")
                                               
                                               }
                                           }.tag(0)
            
          
            ImagePickerScreen()
                .tabItem {
                    VStack{
                        Image(systemName: "photo.on.rectangle")
                        .resizable()
                        .scaledToFit()
                        Text("Library")
                        
                    }
                    }.tag(1)
            
            
       Text("Cards")
                                       .tabItem {
                                           VStack{
                                               Image(systemName: "doc.plaintext")
                                            .resizable()
                                            .scaledToFit()
                                               Text("Cards")
                                               
                                               }
                                           }.tag(2)
            
            
           SettingsScreen()
            .tabItem {
                VStack{
                    Image(systemName: "gear")
                 .resizable()
                 .scaledToFit()
                    Text("Settings")
                    
                    }
                }.tag(3)
            
            
        }
        
        
        
        
    }
}


