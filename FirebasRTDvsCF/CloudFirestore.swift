//
//  CloudFirestore.swift
//  FirebasRTDvsCF
//
//  Created by Mahnoor Khan on 19/04/2020.
//  Copyright © 2020 Mahnoor Khan. All rights reserved.
//

import Firebase
import Foundation
import FirebaseFirestoreSwift

class CloudFirestore {
    static let instance = CloudFirestore()
    var firestore = Firestore.firestore()
}

protocol CloudFirestoreProtocol {}

extension CloudFirestoreProtocol {
    func writeDataCF(sampleObject: SampleObject) {
        let path = CloudFirestore.instance.firestore.collection("Collection1").document()
        do {
            try path.setData(from: sampleObject)
        } catch (let error) {
            print(error.localizedDescription)
        }
    }
    
    func readDataCF() {
        let path = CloudFirestore.instance.firestore.collection("Collection1")
        path.getDocuments { (snapshot, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            } else if let documents = snapshot?.documents {
                let result = Result {
                    try documents.compactMap({
                        try $0.data(as: SampleObject.self)
                    })
                }
                switch result {
                case .success(let sampleObjects):
                    print(sampleObjects)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func equalToQueryCF() {
        let path = CloudFirestore.instance.firestore.collection("Collection1").whereField("attribute1", isEqualTo: 12)
        path.getDocuments { (snapshot, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            } else if let documents = snapshot?.documents {
                print("Equal To Query")
                for document in documents {
                    print(document.data())
                }
            }
        }
    }
}
