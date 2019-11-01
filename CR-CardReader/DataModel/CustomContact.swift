//
//  CustomContact.swift
//  CardReader
//
//  Created by sachin jeph on 15/08/19.
//  Copyright © 2019 sachin jeph. All rights reserved.
//

import Foundation

class customContact {
    var mainName = ""
    var phone = ""
    var company = ""
    var email = ""
    var address = ""
    
    func hasString(text:String)->String{
        
        if self.mainName == text{
            return "Name : "
        }
        else  if self.phone == text{
                   return "Phone : "
               }
        else  if self.company == text{
                          return "Company Name : "
                      }
        else  if self.email == text{
                          return "Email : "
                      }
        else  if self.address == text{
                          return "Address : "
                      }
        
        else{
            return ""
        }
    }
    
    
    func hasString(text:String)->Bool{
        
        if self.mainName == text{
            return true
        }
        else  if self.phone == text{
                   return true
               }
        else  if self.company == text{
                          return true
                      }
        else  if self.email == text{
                          return true
                      }
        else  if self.address == text{
                          return true
                      }
        
        else{
            return false
        }
    }
    
    
    func doEmpty(){
          self.mainName = ""
          self.phone = ""
          self.company = ""
          self.email = ""
          self.address = ""
        
    }

    
}
//Done1
