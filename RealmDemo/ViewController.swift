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
//        let realm = RLMRealm.defaultRealm()
//        print("Realm path: \(realm.path)")
    }
    
    override func viewDidAppear() {
        
//        let metadata = ServerTrackMetadata(metadata: JSON(["id": 1,
//            "cueType": "beat_grid_marker",
//            "cueTime": 146572,
//            "createdBy": 1,
//            "createdAt": 1441960092,
//            "updatedAt": 1441960092,
//            "apiVersion": 1]))
//        metadata.save()
        
//        ServerTrackMetadata.printAll()
        
        
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
//        var lionsJson = [[String:AnyObject]]()
//        lionsJson.append(["id":7, "name": "Lion7"])
//        lionsJson.append(["id":8, "name": "Lion8"])
//        let trainerJson:[String:AnyObject] = ["id":9, "name": "Jayesh", "lions": lionsJson]
//        let trainer = Trainer(trainerJson: JSON(trainerJson))
//        trainer.saveTrainer()
//        print("All trainers details")
//        Trainer.printAllTrainer()
//        print("Trainer created")
        
//        print("\n\nPrint lions")
//        Lion.printAllLion()
//        print("\n\nQuery result")
//        Trainer.printTrainerByLionName(["Smitu","Abc","Krunal","Suresh"])
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


    @IBAction func saveTrainer(sender: AnyObject) {
        var lionsJson = [[String:AnyObject]]()
        lionsJson.append(["id":9, "name": "Lion9"])
        lionsJson.append(["id":10, "name": "Lion10"])
        let trainerJson:[String:AnyObject] = ["id":10, "name": "Vipul", "lions": lionsJson]
        let trainer = Trainer(trainerJson: JSON(trainerJson))
        trainer.saveTrainer()
        print("All trainers details")
        Trainer.printAllTrainer()
    }
    
    @IBAction func saveTrack(sender: AnyObject) {
        
        var metadata = [[String:AnyObject]]()
        metadata.append(["id": 3,
            "cueType": "beat_grid_marker",
            "cueTime": 17524,
            "createdBy": 2,
            "createdAt": 1441884568,
            "updatedAt": 1441884568,
            "apiVersion": 1
        ])
        metadata.append(["id": 4,
            "cueType": "start_point",
            "cueTime": 34575.3,
            "createdBy": 1,
            "createdAt": 1442785485,
            "updatedAt": 1442786358,
            "apiVersion": 1])
        metadata.append(["id": 5,
            "cueType": "end_point",
            "cueTime": 72375,
            "createdBy": 1,
            "createdAt": 1442785485,
            "updatedAt": 1442786413,
            "apiVersion": 1])
        
        
        let serverTrack = ServerTrack(track: JSON([ "id": 1,
            "traktorAudioId": "AWaNzdzs3c7M3N3Nzdzczc7M3N3Nzdzczt//////////////////////////////+aqamJmKmaqJiJmJiaiYiJeYiZiYeIaP/////////////7v/////////////////////////////+4iFRERERURERERERERERERERERERERWdXZnd4iJiIiJiZmqiqmqmqqpmZmZiIfv/////////////73//////////////////////////+7rqv/////////////97//////////////////////////////v/////////////6j///////////////////7/7//+/u7VMA==",
            "bpm": 118,
            "metadata": metadata,
            "createdAt": 1441960092,
            "updatedAt": 1441960092]))
        
//        print("ServerTrack : \(serverTrack.toJSON())")
        serverTrack.save()
        
        let tracks = ServerTrack.getAllServerTracks()
        for track in tracks {
            print(track.toJSON())
        }
        
        
        //ServerTrackMetadata
//        let trackMetadata = ServerTrackMetadata(metadata: JSON(["id": 2,
//            "cueType": "start_point",
//            "cueTime": 205475.25,
//            "createdBy": 1,
//            "createdAt": 1441946789,
//            "updatedAt": 1441946789,
//            "apiVersion": 1
//            ]))
//
//        trackMetadata.save()
//        
//        ServerTrackMetadata.printAll()
    }
    
}

