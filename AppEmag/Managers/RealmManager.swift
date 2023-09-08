//
//  RealmManager.swift
//  AppEmag
//
//  Created by Viorel on 07.09.2023.
//

import RealmSwift

class RealmManager {
    static let shared = RealmManager()
    
    private let realm: Realm
    
    private init() {
        do {
            realm = try Realm()
        } catch {
            fatalError("Realm error: \(error)")
        }
    }
    
    func addObject<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.add(object)
            }
        } catch {
            print("Realm error: \(error)")
        }
    }
    
    func deleteAllObjects<T: Object>(_ objectType: T.Type) {
        let objectsToDelete = realm.objects(objectType)
        
        do {
            try realm.write {
                realm.delete(objectsToDelete)
            }
        } catch {
            print("Error deleting objects from Realm: \(error)")
        }
    }
    
    func saveObjects<T: Object>(_ objects: [T]) {
        do {
            try realm.write {
                realm.add(objects)
            }
        } catch {
            print("Error saving objects to Realm: \(error)")
        }
    }
    
    func getAllObjects<T: Object>(_ objectType: T.Type) -> [T]? {
        return Array(realm.objects(objectType))
    }
}
