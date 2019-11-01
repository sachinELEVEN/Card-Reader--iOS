//
//  ScanScreen.swift
//  CardReader
//
//  Created by sachin jeph on 15/08/19.
//  Copyright © 2019 sachin jeph. All rights reserved.
//

import Foundation
import SwiftUI
struct cardScanScreen:View{
    @State var showImagePicker = true
    @State var showSheet =  true
    @State var showDetails = false
    @State var Img  :  UIImage?=nil
    var body: some View {
    NavigationView{
        VStack{

               
                 VStack{
               if(Img != nil){
            Image(uiImage: Img!)
                 .resizable()
            .frame(height:fullHeight/1.8)
                 .scaledToFit()
               }else{
                Spacer()
                Text("Swipe to Open Camera").fontWeight(.black).font(.title)
                Text("Keep the Card in frame").font(.headline).foregroundColor(.secondary)
                
                    }
                 }
                  .cornerRadius(10)
                 .padding()
               
            
            Spacer()
            
            if(self.Img != nil){
                      Button(action:withAnimation{{
                        self.showImagePicker = false
                         self.showDetails = true
                        self.showSheet = true
                        print(self.showSheet)
                       
                       }}){
                                     Text(("See Information"))
                                    .frame(width:200)
                                    .padding()
                                    .padding(.horizontal)
                                    .background(Color.blue.opacity(0.95))
                                    .foregroundColor(.white)
                                .cornerRadius(20)
                                    }
                              }
      
            
            Spacer()
           
            
        
        .sheet(isPresented: $showSheet){
            self.showImagePicker  ?  ImagePickerViewController(image: self.$Img, camera:true,showPicker : self.$showImagePicker,showDetails:self.$showDetails,showSheet:self.$showSheet):nil
            self.showDetails      ?    ImageDetailsScreen(showSheet:self.$showSheet,image : self.Img!):nil
            }
        }.navigationBarTitle("Choose Photo")
        .navigationBarItems(trailing:
        Button(action:withAnimation{{
            self.cameraButton()
            }}){
                        Text(("Camera"))
                            .padding(.horizontal)
                          .background(Color.orange.opacity(0.95))
                          .foregroundColor(.white)
                          .cornerRadius(20)
                      }
        )
        
        .gesture(
        DragGesture(minimumDistance: 20)
                               .onEnded { _ in
                                print("Dragged")
                                   self.cameraButton()
                               }
        )

      }
    }
    
    func cameraButton(){
        self.showImagePicker = true
        self.showDetails = false
        self.showSheet = true
    }
}
//Done2
