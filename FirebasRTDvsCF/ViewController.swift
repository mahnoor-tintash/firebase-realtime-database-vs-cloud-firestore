//
//  ViewController.swift
//  FirebasRTDvsCF
//
//  Created by Mahnoor Khan on 18/04/2020.
//  Copyright © 2020 Mahnoor Khan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, RealtimeDatabaseProtocol, CloudFirestoreProtocol {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let number = getInt() + 1
        let sampleObject = SampleObject(attribute1: number, attribute2: "text\(number)")
        saveInt(val: number)
        
        writeDataCF(sampleObject: sampleObject)
        writeDataRTD(sampleObject: sampleObject)
        
        readDataCF()
        readDataRTD()
        
        equalToQueryCF()
        equalToQueryRTD()
    }
}

extension ViewController {
    func getInt() -> Int {
        return UserDefaults.standard.integer(forKey: "intValue")
    }
    
    func saveInt(val: Int) {
        UserDefaults.standard.set(val, forKey: "intValue")
    }
}
