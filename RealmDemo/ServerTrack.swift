//
//  Otto.swift
//  RealmDemo
//
//  Created by Bipin Vaylu on 22/10/15.
//  Copyright © 2015 Bipin Vaylu. All rights reserved.
//

import Foundation
import Realm
import SwiftyJSON

public class ServerTrackMetadata: RLMObject {
    
    dynamic var id = 0
    dynamic var cueType = ""
    dynamic var cueTime = 0.0
    dynamic var createdBy = 0
    dynamic var hotcue = -1
    dynamic var apiVersion = 0
    dynamic var createdAt = 0
    dynamic var updatedAt = 0
    
    public convenience init(cueType: String, cueTime: Double, createdBy: Int, apiVersion: Int, hotcue:Int) {
        self.init()
        self.cueType = cueType
        self.cueTime = cueTime
        self.createdBy = createdBy
        self.apiVersion = apiVersion
        self.hotcue = hotcue
    }
    
    
    public convenience init(metadata: JSON) {
        self.init()
        if  let id = metadata["id"].int,
            let cueType = metadata["cueType"].string,
            let cueTime = metadata["cueTime"].double,
            let createdBy = metadata["createdBy"].int,
            let apiVersion = metadata["apiVersion"].int,
            let createdAt = metadata["createdAt"].int,
            let updatedAt = metadata["updatedAt"].int {
                
                self.id = id
                self.cueType = cueType
                self.cueTime = cueTime
                self.createdBy = createdBy
                self.apiVersion = apiVersion
                self.createdAt = createdAt
                self.updatedAt = updatedAt
        }
    }
    
    public func toJSON() -> JSON?{
        if let dict = toDictionary() {
            return JSON(dict)
        }
        return nil
    }
    
    public func toDictionary() -> [String:AnyObject]? {
        //Skip of cue type is invalid
        if self.cueType == "" {
            return nil;
        }
        
        var dictionary = [String:AnyObject]()
        
        if self.id != 0 {
            dictionary["id"] = self.id
        }
        dictionary["cueType"] = self.cueType
        dictionary["cueTime"] = self.cueTime
        dictionary["createdBy"] = self.createdBy
        dictionary["apiVersion"] = self.apiVersion
        if self.createdAt != 0 {
            dictionary["createdAt"] = self.createdAt
        }
        if self.updatedAt != 0 {
            dictionary["updatedAt"] = self.updatedAt
        }
        return dictionary
    }
    
    public func save() {
        let realm = RLMRealm.defaultRealm()
        realm.beginWriteTransaction()
        realm.addOrUpdateObject(self)
        try! realm.commitWriteTransaction()
        print("ServerTrackMetadata saved!")
    }
    
    static public func printAll() {
        let objects = ServerTrackMetadata.allObjects()
        var j:UInt = 0
        while  j < objects.count {
            let metadata = objects.objectAtIndex(j) as! ServerTrackMetadata
            print("\t\t ServerTrackMetadata: \(metadata.toJSON())")
            j = j+1
        }
    }
    
    override public static func primaryKey() -> String? {
        return "id"
    }
}

public class ServerTrack: RLMObject {
    
    dynamic var id = 0
    dynamic var traktorAudioId = ""
    dynamic var bpm = 0.0
    dynamic var metadata = RLMArray(objectClassName: ServerTrackMetadata.className())
    dynamic var createdAt = 0
    dynamic  var updatedAt = 0
    
    public convenience init(traktorAudioId: String, bpm: Double, metadata: [ServerTrackMetadata]) {
        self.init()
        self.traktorAudioId = traktorAudioId
        self.bpm = bpm
        self.metadata.addObjects(metadata)
    }

    public convenience init(track: JSON) {
        self.init()
        if  let id = track["id"].int,
            let traktorAudioId = track["traktorAudioId"].string,
            let bpm = track["bpm"].double,
            let createdAt = track["createdAt"].int,
            let updatedAt = track["updatedAt"].int,
            let metadataJSONArray = track["metadata"].array {
                self.id = id
                self.traktorAudioId = traktorAudioId;
                self.bpm = bpm
                self.createdAt = createdAt
                self.updatedAt = updatedAt
                for metadataJSON in metadataJSONArray {
                    if let metadata = ServerTrackMetadata(metadata: metadataJSON) as ServerTrackMetadata?{
                        self.metadata.addObject(metadata)
                    }
                }
        }
    }

    public func toJSON() -> JSON{
        return JSON(toDictionary())
    }
    
    public func toDictionary() -> [String:AnyObject] {
        var dictionary = [String:AnyObject]()
        
        if self.id != 0 {
            dictionary["id"] = self.id
        }
        dictionary["traktorAudioId"] = self.traktorAudioId
        dictionary["bpm"] = self.bpm
        if self.createdAt != 0 {
            dictionary["createdAt"] = self.createdAt
        }
        if self.updatedAt != 0 {
            dictionary["updatedAt"] = self.updatedAt
        }
        
        var metadataDictArray = [[String:AnyObject]]()
        
        var i:UInt = 0
        while  i < self.metadata.count {
            if let metadata = self.metadata.objectAtIndex(i) as? ServerTrackMetadata {
                if let metadataDict = metadata.toDictionary() {
                    metadataDictArray.append(metadataDict)
                }
            }
            i = i+1
        }
        dictionary["metadata"] = metadataDictArray
        return dictionary
    }
// Un-comment will raise exception like this 
/***
    
Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '-[Swift._SwiftDeferredNSArray objectClassName]: unrecognized selector sent to instance 0x608000037720'
    
***/
//    public func getMetadata() -> [ServerTrackMetadata] {
//        var trackMetadata = [ServerTrackMetadata]()
//        var i:UInt = 0
//        while  i < self.metadata.count {
//            if let metadata = self.metadata.objectAtIndex(i) as? ServerTrackMetadata {
//                trackMetadata.append(metadata)
//            }
//            i = i+1
//        }
//        return trackMetadata
//    }
    
    
    override public static func primaryKey() -> String? {
        return "id"
    }
    
    public func save() {
        let realm = RLMRealm.defaultRealm()
        realm.beginWriteTransaction()
        realm.addOrUpdateObject(self)
        try! realm.commitWriteTransaction()
        print("ServerTrack saved!")
    }
    
    static public func printAllServerTrack() {
        let objects = ServerTrack.allObjects()
        var i:UInt = 0
        while  i < objects.count {
            if let serverTrack = objects.objectAtIndex(i) as? ServerTrack {
                print("ServerTrack at index: \(i), Json: \(serverTrack.toJSON())")
            } else {
                print("ServerTrack at index: \(i), Json: (null)")
            }
            i = i+1
        }
        
    }
    
}

