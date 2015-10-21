//
//  ViewController.swift
//  RealmDemo
//
//  Created by Bipin Vaylu on 20/10/15.
//  Copyright © 2015 Bipin Vaylu. All rights reserved.
//

import Cocoa
import Realm
import SwiftyJSON

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let realm = RLMRealm.defaultRealm()
        print("Realm path: \(realm.path)")
    }
    
    override func viewDidAppear() {
        
        
        
//        let lion1 = Lion(id: 1, name: "Lion1")
//
//        let lion2 = Lion(id: 2, name: "Lion2")
//
//        let lion3 = Lion(id: 3, name: "Lion3")
//        
//        var lions = [Lion]()
//        lions.append(lion1)
//        lions.append(lion2)
//        lions.append(lion3)
//        
//        print("Creating Trainer")
//        let trainer = Trainer(id: 1, name: "Smitu", lions: lions)
//        
        var lionsJson = [[String:AnyObject]]()
        lionsJson.append(["id":7, "name": "Lion7"])
        lionsJson.append(["id":8, "name": "Lion8"])
        let trainerJson:[String:AnyObject] = ["id":9, "name": "Jayesh", "lions": lionsJson]
        let trainer = Trainer(trainerJson: JSON(trainerJson))
        trainer.saveTrainer()
        print("All trainers details")
        Trainer.printAllTrainer()
//        print("Trainer created")
        
//        print("\n\nPrint lions")
//        Lion.printAllLion()
        print("\n\nQuery result")
        Trainer.printTrainerByLionName(["Smitu","Abc","Krunal","Suresh"])
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

