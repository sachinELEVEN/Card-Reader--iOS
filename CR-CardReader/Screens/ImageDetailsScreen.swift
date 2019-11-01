//
//  ImageDetailsScreen.swift
//  CardReader
//
//  Created by sachin jeph on 15/08/19.
//  Copyright © 2019 sachin jeph. All rights reserved.
//

import SwiftUI

struct ImageDetailsScreen: View {
    @Binding var showSheet :Bool
    @State var ShowSheet2 = DirectContactCreation
    var image : UIImage
    var navBarTitles = ["Tap Contact Name","Tap Contact Phone","Tap Contact Company","Tap Contact Email","Tap Contact Address"]
  @State var currentNavBarTitle = "Tap Contact Name" // since first nav bar title would always be "Name"
    @State var haveImageText = false
    @State var contact = customContact()
   @State var lineArr = [String]()// = "Before"
    var textTotextBatch : String {
        get {
            if(!haveImageText){ runImageTextRecognistion(image: image) { (lineArr) in
                self.lineArr =  lineArr!
                  self.haveImageText = true
                }
            }
            return "Done"

        }
    }

    
    
    var body: some View {
    NavigationView{
        VStack{
            
            Divider()
                .padding()
            HStack{
                
                Button(action:{
                    self.showSheet = false
                    self.contact.doEmpty()
                    }){
                                  Text("Cancel")
                                    .padding(.horizontal)
                                      .background(Color.red)
                                      .foregroundColor(.white)
                                   .cornerRadius(20)
                                  
                              }
                Spacer()
                    if(currentNavBarTitle != navBarTitles[0]&&currentNavBarTitle != "Tap Save"){
                Button(action:{self.addToCustomContact(skip:true,line: nil)}){
                                  Text("Skip")
                              }
            }
               
                if(contact.mainName != ""){//means contact name is there
                         Spacer()
                    Button(action:{self.addToPhoneContact()}){
                    Text("Save")
                        .padding(.horizontal)
                        .background(Color.blue)
                        .foregroundColor(.white)
                     .cornerRadius(20)
                    
                }
            }
                
            }.padding(.horizontal)
            
            Divider()
                           .padding()
            
        ScrollView{
            
            
            
        VStack{
        Text(textTotextBatch)
            .frame(width:0,height:0)
            
            ForEach(self.lineArr,id:\.self){line in
                VStack{
                textDisplay(line:line,type:self.contact.hasString(text:line),hasColor: self.contact.hasString(text:line) )
                    .onTapGesture {
                     
                        if !self.contact.hasString(text:line){
                            withAnimation{    self.addToCustomContact(skip:false,line: line)
                          }
                    }
                
                        
                }
                }//.frame(height:100)
            }
        
           }
         }
        .sheet(isPresented: $ShowSheet2){
           
            ContactCreatedScreen(showSheet:self.$showSheet)
            }
        }.navigationBarTitle("\(currentNavBarTitle)")
            .navigationBarItems(trailing:
                
            autoContactCreate["email"] != "nil"||realNameGlobal ? (
                //contact can be created automatically
                
                Button(action:{self.ShowSheet2 = true}){
              
                Text("Auto Create")
                                       .padding(.horizontal)
                                       .background(Color.blue)
                                       .foregroundColor(.white)
                                    .cornerRadius(20)
            }
                ):(
                Button(action:{}){
                Text("")
                                                      .padding(.horizontal)
                                                      .background(nil)
                                                      .foregroundColor(.white)
                                                   .cornerRadius(20)
                  }
                )
        
        
        )
       
        
    }
  }
    
    func addToCustomContact(skip:Bool,line : String?){
      
        
        if currentNavBarTitle=="Tap Contact Name"{
            currentNavBarTitle = navBarTitles[1]
            if(!skip){  contact.mainName = line!}
            
            
        }
        else if currentNavBarTitle=="Tap Contact Phone"{
                 currentNavBarTitle = navBarTitles[2]
            if(!skip){  contact.phone = line!}
             }
        else if currentNavBarTitle=="Tap Contact Company"{
                        currentNavBarTitle = navBarTitles[3]
            if(!skip){  contact.company = line!}
                    }
        else if currentNavBarTitle=="Tap Contact Email"{
                        currentNavBarTitle = navBarTitles[4]
            if(!skip){   contact.email = line!}
                    }
        else if currentNavBarTitle=="Tap Contact Address"{
            if(!skip){   contact.address = line!}
              currentNavBarTitle = "Tap Save"
        }
        else{
            print("Wrong NavBar value. Error_01")
        }
        
        
        
    }
    
    
    func addToPhoneContact(){
        createPhoneContact(customContact:contact)
        self.showSheet = false
    }
    
}

//Done3
struct textDisplay:View{
    var line :String
    var type:String
    var hasColor:Bool
    var body:some View{
    VStack{
                           Text(type)
                           Text(line).lineLimit(nil)
    }.font(.headline)
        .lineLimit(nil)
    .padding()
        //self.contact.hasString(text:line) ? Color.blue :
        .background(hasColor ? Color.green.opacity(0.9) : Color.secondary.opacity(0.10))
    .cornerRadius(20)
        
        
    }
}
