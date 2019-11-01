//
//  ImageRecognition.swift
//  CardReader
//
//  Created by sachin jeph on 15/08/19.
//  Copyright © 2019 sachin jeph. All rights reserved.
//

import Foundation
import FirebaseMLVision
import UIKit
var realNameGlobal = false
var realName2 = "nil"

func runImageTextRecognistion(image:UIImage,completion:@escaping (_ text:[String]?)->()){
   
    //Ressting for new card scan
  //first emptying  autoContactCreate
    realNameGlobal = false
    realName2 = "nil"
    autoContactCreate = ["phone":"nil","email":"nil"]
    
    
      let vision = Vision.vision()
    let textRecognizer = vision.onDeviceTextRecognizer()
    
    let visionImage = VisionImage(image: image)
    textRecognizer.process(visionImage) { (features, error) in
        print("The Text is")
       // print(features?.text)
        
        if features != nil {
            var lineArr = [String]()
            var realName = "nil"
        for block in features!.blocks{
            
            
            for line in block.lines{
               print("LineRepeat")
                prevNum = ""
              //  print(line.text)
                var foundNum = false
                
                
                if(realName=="nil"){//ony one occurrence of name will be detected
                                 realName  =  checkIfNameCanBeFound(line:line.text)
                                 
                                 if(realName != "nil"){lineArr.append(realName)
                                     realNameGlobal = true
                                 }
                             }
                
                if(realName2 == "nil"){
                                   realName2 = checkIfNameCanBeFound2(line:line)
                                   if(realName2 != "nil"){lineArr.append(realName2)
                                                          realNameGlobal = true
                                                      }
                               }
                
                
             
            
                
                for word in line.elements{
                 
                    if  checkIfNumber(word: word.text){
                        lineArr.append(word.text)
                        foundNum = true
                    }
                    
                    
                    if  checkIfEmail(word: word.text){
                                           lineArr.append(word.text)
                                           foundNum = true
                                       }
                    
                    
                }
                //prevNum=""

                if !foundNum&&realName == "nil"{
                     lineArr.append(line.text)
                }
                
                
                
            }
            
        }
        //createContactAutomatically()
        completion(lineArr)
   
            }
        }
  
    
    
}

//****************************************************************************************
//LOGIC FOR CREATING CONTACT AUTOMATICALLY



var prevNum = ""
var prevSpace = false
func checkIfNumber(word:String)->Bool{
    var wordNew = word
   print("word",word,"yo")
   // if(word==" "){
        print("prevNum",prevNum)
        let num2 = Int(prevNum)//if previous num is Int
        if num2 != nil{
            let tempNumWord = prevNum+word
           
            wordNew = tempNumWord
            
        }
   // }
  //  if(prevSpace){
        print("val",prevSpace)
       
        
  //  }
    
    
    
    if(wordNew.hasPrefix("+91")){
        
        wordNew.removeFirst(3)
       
    }
     prevNum = wordNew
    
    let num = Int(wordNew)
    
    if num != nil{
      //   prevNum = wordNew
        if(wordNew.count == 10){autoContactCreate["phone"] = wordNew
            prevSpace = false
            prevNum=""
           
        }
       
        return true
    }else{
        return false
    }
    
}

func checkIfEmail(word:String)->Bool{
    
    if word.contains("@"){
         autoContactCreate["email"] = word
        return true
    }else{
        return false
    }
    
}


func checkIfNameCanBeFound(line:String)->String{
    
    //2 words seperated by space
    //name,Name,or NAME may be there in the same line

 let containsNameKey1 = line.contains("Name")
    let containsNameKey2 = line.contains("name")
    let containsNameKey3 = line.contains("NAME")
     let containsNameKey4 = line.contains("NAME:")
     let containsNameKey5 = line.contains("NAME-")
    
    
    if(containsNameKey1||containsNameKey2||containsNameKey3||containsNameKey4||containsNameKey5){
        //card has name field
        var newLine = ""
         newLine = line.replacingOccurrences(of: "name", with: "")
         newLine = line.replacingOccurrences(of: "Name", with: "")
         newLine = line.replacingOccurrences(of: "NAME", with: "")
        
    newLine  =  cleanStringToAlphabet(str: newLine)
         print("Name found is ",newLine)
        
        autoContactCreate["realName"] = newLine
        return newLine
    }else{
        //name field not found
        return "nil"
        
    }
    
    
    
}

func checkIfNameCanBeFound2(line: VisionTextLine)->String{
    
    print("aaaah",line.text,"  count is ",line.elements.count)
        
   var hasSpecialChar = false
    //line should contain only 2 words
    if(line.elements.count==2){
        //these words should not have any special character and shoould have only alphabets
        
        var name = ""
        for word in line.elements{
            print("word in name is ",word.text)
            if(!hasAnySpecialChar(word:word.text)){
                //if word does not have any special character
                name += word.text
                print(word.text)
                
                
                
            }else{
                hasSpecialChar = true
            }
            if(!hasSpecialChar){
            print("iop",name)
                name += " "}
            
        }
         if(!hasSpecialChar){
         autoContactCreate["realName2"] = name
        if(name==" "){name="nil"}
        print("hey ",name)
        
            return name}else{
            return "nil"
        }
        
    }else{
        return "nil"
    }
    
    
}



//contact will only be created if atleast there is a contact name
var autoContactCreate : [String:String] = ["phone":"nil","email":"nil"]
func createContactAutomatically()->customContact{
    
    if(autoContactCreate["phone"] == nil&&autoContactCreate["phone"]!.count==10){
        print("cannot create contact")
       let temp = customContact()
        return temp
    }
    //10 digit phone numbers are allowed only
    
    
    let contact = customContact()
    contact.phone = autoContactCreate["phone"]!
    contact.email = autoContactCreate["email"]!
    
    //First check if Name field is there or not, then finds 2 letter words and then email
    
    if(autoContactCreate["realName"] != nil){
           contact.mainName = autoContactCreate["realName"]!
       }
    
  else if(autoContactCreate["realName2"] != nil){
        contact.mainName = autoContactCreate["realName2"]!
    }else{
    
 contact.mainName = String(autoContactCreate["email"]!.prefix { (char) -> Bool in
  print()
    if( char != "@"){return true}
    else{
        return false
    }
    
 })
    cleanContactName(contact: contact)
   
        
}
    
    
    print("Contact created automatically with name ,",contact.mainName)
    
   //  createPhoneContact(customContact:contact)
    print(contact.mainName)
    print(contact.email)
    print(contact.phone)
   //  completion(contact)
    return contact
}


func cleanContactName(contact:customContact){
    
    
    
    contact.mainName.removeAll { (char) -> Bool in
        
        //char should strictly be just a alphabet
        if( (char.asciiValue!>UInt8(64)&&char.asciiValue!<UInt8(91)) || (char.asciiValue!>UInt8(96)&&char.asciiValue!<UInt8(123))){
           //char is an alphabet
            return false
        }else{
            return true
        }
    }
    
}

func cleanStringToAlphabet(str:String)->String{
    var str2 = str
    str2.removeAll { (char) -> Bool in
           
           //char should strictly be just a alphabet or a space
           if( (char.asciiValue!>UInt8(64)&&char.asciiValue!<UInt8(91)) || (char.asciiValue!>UInt8(96)&&char.asciiValue!<UInt8(123)||char.asciiValue!==UInt8(32))){
              //char is an alphabet or space
               return false
           }else{
               return true
           }
       }
    
    return str2
}


func hasAnySpecialChar(word:String)->Bool{
    
  let hasSpecialChar =  word.contains { (char) -> Bool in
       
         if( (char.asciiValue!>UInt8(64)&&char.asciiValue!<UInt8(91)) || (char.asciiValue!>UInt8(96)&&char.asciiValue!<UInt8(123)||char.asciiValue!==UInt8(32))){
            //if char is a alphabet
            
         return false
            
         }else{
            return true
        }
        
    }
    
    
    return hasSpecialChar
    
    
}

//done10
