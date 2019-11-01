//
//  ImagePickerScreen.swift
//  CardReader
//
//  Created by sachin jeph on 15/08/19.
//  Copyright © 2019 sachin jeph. All rights reserved.
//

import SwiftUI
import AVFoundation
import UIKit
var fullWidth = UIScreen.main.bounds.width
var fullHeight = UIScreen.main.bounds.height

struct ImagePickerScreen: View {
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
            Text("Swipe to Open Photos").fontWeight(.black).font(.title)
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
            self.showImagePicker  ?  ImagePickerViewController(image: self.$Img, camera:false,showPicker:self.$showImagePicker,showDetails:self.$showDetails,showSheet:self.$showSheet):nil
            self.showDetails      ?    ImageDetailsScreen(showSheet:self.$showSheet,image : self.Img!):nil
            }
        }.navigationBarTitle("Choose Photo")
             .statusBar(hidden: true)
        .navigationBarItems(trailing:
            
        Button(action:withAnimation{{
            self.photoLibraryButton()}}){
                      Text(("Photo Library"))
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
                                         self.photoLibraryButton()
                                     }
              )
        
       

        
      }
    }
    
    func photoLibraryButton(){
        self.showImagePicker = true
        self.showDetails = false
        self.showSheet = true
    }
}

struct ImagePickerViewController: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    var camera:Bool
    @Binding var showPicker:Bool
     @Binding var showDetails:Bool
     @Binding var showSheet:Bool

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePickerViewController>) {
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerViewController>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        if(camera){
            imagePicker.sourceType = UIImagePickerController.SourceType.camera}
        else{
          imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary}
        imagePicker.allowsEditing = false
        imagePicker.delegate = context.coordinator
        return imagePicker
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate, AVCapturePhotoCaptureDelegate {

        var parent: ImagePickerViewController

        init(_ parent: ImagePickerViewController) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if  let imagePicked = info[.editedImage] as? UIImage{parent.image = imagePicked
                            picker.dismiss(animated: true, completion: nil)}
            else if let imagePicked = info[.originalImage] as? UIImage{parent.image = imagePicked
                           // picker.dismiss(animated: true, completion: nil)
               // if(parent.camera){
                    parent.showPicker = false
                    parent.showDetails = true
                    parent.showSheet=true
               // }
              
                
            }
            
        }
    }
}
//Done2
