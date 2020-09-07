//
//  RealtimeDatabase.swift
//  FirebasRTDvsCF
//
//  Created by Mahnoor Khan on 19/04/2020.
//  Copyright © 2020 Mahnoor Khan. All rights reserved.
//

import Firebase
import Foundation

class RealtimeDatabase {
    static let instance = RealtimeDatabase()
    var database = Database.database().reference()
}

protocol RealtimeDatabaseProtocol {}

extension RealtimeDatabaseProtocol {
    func writeDataRTD(sampleObject: SampleObject) {
        let path = RealtimeDatabase.instance.database.child("Node1").childByAutoId()
        let value: [String : Any] = ["attribute1"   : sampleObject.attribute1 as Any,
                                     "attribute2"   : sampleObject.attribute2 as Any]
        path.setValue(value)
    }
    
    func readDataRTD() {
        let path = RealtimeDatabase.instance.database.child("Node1")
        path.observeSingleEvent(of: .value, with: { (snapshot) in
            let decoder = JSONDecoder()
            do {
                if let response = snapshot.value as? [String: Any] {
                    let jsonData = try JSONSerialization.data(withJSONObject: Array(response.values), options: [])
                    let sampleObjects = try decoder.decode([SampleObject].self, from: jsonData)
                    print(sampleObjects)
                }
            } catch (let error) {
                print(error.localizedDescription)
            }
        }) { (error) in
            print(error)
        }
    }
    
    func equalToQueryRTD() {
        let path = RealtimeDatabase.instance.database.child("Node1")
        
        path.queryOrdered(byChild: "attribute1").queryEqual(toValue: 1).observeSingleEvent(of: .value, with: { (snapshot) in
            print("Equal Query Ordered by Child", snapshot.value as Any)
        }) { (error) in
            print(error.localizedDescription)
        }
        
        path.queryOrderedByKey().queryEqual(toValue: "-M5I_bJHQ3-ZTIvVg331").observeSingleEvent(of: .value, with: { (snapshot) in
            print("Equal Query Ordered by Key", snapshot.value as Any)
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}


//childadded wali cheezein (listeners basically)
