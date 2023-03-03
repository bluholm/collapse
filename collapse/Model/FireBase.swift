//
//  FireBase.swift
//  collapse
//
//  Created by Marc-Antoine BAR on 2023-03-03.
//

import Foundation
import Firebase

class Firebase {
    
    var ref: DatabaseReference!
    
    func readData(callback: @escaping(DataSnapshot) -> Void ) {
        self.ref = Database.database().reference(withPath: "tips")
        self.ref.observe(.value, with: { snapshot in
            callback(snapshot)
        })
    }
}

