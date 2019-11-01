//
//  SavingToPhoneContacts.swift
//  CardReader
//
//  Created by sachin jeph on 15/08/19.
//  Copyright © 2019 sachin jeph. All rights reserved.
//

import Foundation
import Contacts

func createPhoneContact(customContact : customContact){
   
    
    
    let contact = CNMutableContact()
    //Name and Company Name
    contact.givenName = customContact.mainName
    contact.organizationName = customContact.company
   
    //Phone Number
    contact.phoneNumbers = [CNLabeledValue(label: CNLabelPhoneNumberMain, value: CNPhoneNumber(stringValue: customContact.phone))]
    
    //Email
    let homeEmail = CNLabeledValue(label:CNLabelHome, value:customContact.email as NSString)
       contact.emailAddresses = [homeEmail]
    
    //Address
    let address = CNMutablePostalAddress()
    address.street = customContact.address
   
    
    //saving contact
    savingToPhoneContacts(contact: contact)
    
}

func savingToPhoneContacts(contact:CNMutableContact){
    let contactStore = CNContactStore()
       
       //Requesting Access to contacts
       contactStore.requestAccess(for: .contacts) { (success, error) in
           if error != nil{
               print("Error in Authorisation")
           }
           print(success)
       }
    
    let saveRequest = CNSaveRequest()
    saveRequest.add(contact, toContainerWithIdentifier:nil)
    try! contactStore.execute(saveRequest)
    print("contact saved")
}
//Done1
