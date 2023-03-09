//
//  FireBase.swift
//  collapse
//
//  Created by Marc-Antoine BAR on 2023-03-03.
//

import Foundation
import Firebase

/// This class provides functionality to read data from Firebase Realtime Database.
class Firebase {
    
    /// A reference to the Firebase database.
    var ref: DatabaseReference!
    
    /// Reads data from Firebase database.
    ///
    /// This method sets up a listener for changes to the data at the location specified by `Constants.fireBasePath`.
    /// When data changes, the closure passed to this method is called with the updated snapshot.
    /// - Parameters:
    ///     - callback: A closure to be executed when the data is read from the database. The closure takes a single parameter of type `DataSnapshot`.
    ///
    
    func readData(callback: @escaping(DataSnapshot) -> Void ) {
        self.ref = Database.database().reference(withPath: Constants.fireBasePath)
        self.ref.observe(.value, with: { snapshot in
            callback(snapshot)
        })
    }
}
