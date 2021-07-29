//
//  ContactManager.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 28.07.21.
//

import UIKit
import Contacts

protocol ContactManagerProtocol: AnyObject {
    func fetchContacts(complition: @escaping ([Contact]) -> Void)
}

class ContactManager: ContactManagerProtocol {
    
    func fetchContacts(complition: @escaping ([Contact]) -> Void) {
        let contactStore = CNContactStore()
        var contacts = [Contact]()
        contactStore.requestAccess(for: .contacts) {
            (success, error) in
            success ? print("Success") : print("Error")
        }
        let key = [CNContactGivenNameKey,
                   CNContactFamilyNameKey,
                   CNContactPhoneNumbersKey,
                   CNContactThumbnailImageDataKey]
        let request = CNContactFetchRequest(keysToFetch: key as [CNKeyDescriptor])
        do {
            try contactStore.enumerateContacts(with: request, usingBlock: {
                (contact, shopingPointer) in
                let name = contact.givenName
                let lastname = contact.familyName
                let number = contact.phoneNumbers.first?.value.stringValue
                var numbers = [String]()
                for number in contact.phoneNumbers {
                    numbers.append(number.value.stringValue)
                }
                let firstSymbol = String(contact.givenName.prefix(1) + contact.familyName.prefix(1))
                let imageData = contact.thumbnailImageData
                let contactToAppend = Contact(name: name, lastName: lastname, number: number!, numbers: numbers, firstSymbol: firstSymbol, picture: imageData)
                contacts.append(contactToAppend)
            })
            complition(contacts)
        } catch {
            print("Error info: \(error)")
        }
    }
}
