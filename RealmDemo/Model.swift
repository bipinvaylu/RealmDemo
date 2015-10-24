import Cocoa
import Realm
import SwiftyJSON


public class Lion: RLMObject {
    dynamic var id = 0
    dynamic var name = ""
    
    public convenience init(id:Int, name:String) {
        self.init()
        self.id = id
        self.name=name
    }
    
    public convenience init(lionJson: JSON) {
        self.init()
        if let id = lionJson["id"].int,
            let name = lionJson["name"].string {
                self.id = id
                self.name = name
        }
    }
    
    override public static func primaryKey() -> String? {
        return "id"
    }
    
    
    static public func printAllLion() {
        let objects = Lion.allObjects()
        var j:UInt = 0
        while  j < objects.count {
            let lion = objects.objectAtIndex(j) as! Lion
            print("\t\t Lion id: \(lion.id), name: \(lion.name)")
            j = j+1
        }
    }
}

public class Trainer: RLMObject {
    dynamic var id = 0
    dynamic var name:String?
    dynamic var lions = RLMArray(objectClassName: Lion.className())
    
    public convenience init(id:Int, name:String, lions: [Lion]) {
        self.init()
        self.id = id
        self.name=name
        self.lions.addObjects(lions)
    }
    
    public convenience init(name:String, lions: [Lion]) {
        self.init()
        self.name=name
        self.lions.addObjects(lions)
    }
    
    public convenience init(trainerJson: JSON) {
        self.init()
        if let id = trainerJson["id"].int,
            let name = trainerJson["name"].string,
            let lionJsonArray = trainerJson["lions"].array {
                self.id = id
                self.name = name
                for lionJson in lionJsonArray {
                    if let lion = Lion(lionJson: lionJson) as Lion? {
                        self.lions.addObject(lion)
                    }
                }
        }
    }
    
    override public static func primaryKey() -> String? {
        return "id"
    }
    
    public func saveTrainer() {
        print("Lion count: \(self.lions.count)")
        let realm = RLMRealm.defaultRealm()
        realm.beginWriteTransaction()
        realm.addOrUpdateObject(self)
        try! realm.commitWriteTransaction()
        print("Lion count: \(self.lions.count)")
        print("Trainer detail saved!")
    }
    
    static public func printAllTrainer() {
        let objects = Trainer.allObjects()
        var i:UInt = 0
        while  i < objects.count {
            let trainer = objects.objectAtIndex(i) as! Trainer
            print("Trainer id: \(trainer.id), name: \(trainer.name!), lions.count: \(trainer.lions.count)")
            var j:UInt = 0
            while  j < trainer.lions.count {
                let lion = trainer.lions.objectAtIndex(j) as! Lion
                print("\t\t Lion id: \(lion.id), name: \(lion.name)")
                j = j+1
            }
            i = i+1
        }
        
    }
    
    static public func printTrainerByLionName(names: [String]) {
        let predicate = NSPredicate(format: "name IN %@",names)
        print("predicate: \(predicate.description)")
        let objects = Trainer.objectsWithPredicate(predicate)
        var i:UInt = 0
        while  i < objects.count {
            let trainer = objects.objectAtIndex(i) as! Trainer
            print("Trainer id: \(trainer.id), name: \(trainer.name!), lions.count: \(trainer.lions.count)")
            var j:UInt = 0
            while  j < trainer.lions.count {
                let lion = trainer.lions.objectAtIndex(j) as! Lion
                print("\t\t Lion id: \(lion.id), name: \(lion.name)")
                j = j+1
            }
            i = i+1
        }
        
    }
}


