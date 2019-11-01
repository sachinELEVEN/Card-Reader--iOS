//
//  ContactCreatedScreen.swift
//  CardReader
//
//  Created by sachin jeph on 18/08/19.
//  Copyright © 2019 sachin jeph. All rights reserved.
//

import SwiftUI
//createContactAutomatically
struct ContactCreatedScreen: View {
    var contact =   createContactAutomatically()
    @Binding var showSheet :Bool
              
    
    var body: some View {
        VStack(alignment:.center){
           // Text(num).frame(width:0,height:0)
            
            HStack{
                
                Text("Contact Details")
                    .fontWeight(.black)
                    .font(.largeTitle)
                    .padding()
                
                Spacer()
                
                /*
                Button(action:{self.showSheet = false})  {Text(("Cancel"))
                                          .padding(.horizontal)
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(5)
                }
                 */
                
            }.padding()
            /////
            Spacer()
            VStack{
            Text("Contact Name  ")
                               .fontWeight(.bold)
                               .font(.title)
                
                
                Text(contact.mainName)
                                              .fontWeight(.bold)
                                              .font(.title)
                                                .foregroundColor(.secondary)
            }.padding()
            
            ///////
            VStack{
                     Text("Phone  ")
                                        .fontWeight(.bold)
                                        .font(.title)
                         
                         
                         Text(contact.phone)
                                                       .fontWeight(.bold)
                                                       .font(.title)
                .foregroundColor(.secondary)
                     }.padding()
            
            ////
            if(autoContactCreate["email"] != "nil"){
            VStack{
                              Text("Email   ")
                                                 .fontWeight(.bold)
                                                 .font(.title)
                                  
                                  
                                  Text(contact.email)
                                                                .fontWeight(.bold)
                                                                .font(.title)
                .foregroundColor(.secondary)
                }.padding()
            }
            
           Spacer()
            Button(action:{ createPhoneContact(customContact:self.contact);self.showSheet = false}){
                                  
                                   
                                         Text(("Save "))
                                        .frame(width:200)
                                        .padding()
                                        .padding(.horizontal)
                                        .background(Color.blue.opacity(0.95))
                                        .foregroundColor(.white)
                                    .cornerRadius(20)
                                        
                                }
            
            
            Spacer()
            
            
        }.background(Color.primary.colorInvert())
       .cornerRadius(30)
            .padding()
        
        
        
        
    }
}

//done3
