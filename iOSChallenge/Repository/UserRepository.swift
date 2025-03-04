//
//  UserRepository.swift
//  iOSChallenge
//
//  Created by Steven Chaves on 2/3/25.
//

import RealmSwift
import Combine

class UserRepository {

    private let realm = try! Realm()
    
    func fetchAllUsers() -> AnyPublisher<[User], Never> {
        let users = realm.objects(User.self)
        return Just(users.map { $0 })
            .eraseToAnyPublisher()
    }
    
    func fetchUser(by id: ObjectId) -> AnyPublisher<User?, Never> {
        let user = realm.object(ofType: User.self, forPrimaryKey: id)
        return Just(user)
            .eraseToAnyPublisher()
    }
    
    func addUser(_ user: User) -> Bool {
        if (realm.objects(User.self).filter("username==%@", user.username).first != nil) {
            return false
        }
        
        try! realm.write {
            realm.add(user, update: .all)
        }
        KeychainHelper.shared.saveUserToken(user.id)
        return true
    }
    
    func deleteUser(_ user: User) {
        try! realm.write {
            realm.delete(user)
        }
    }
    
    func saveUserPin(id: ObjectId, pin: String) {
        if let user = realm.object(ofType: User.self, forPrimaryKey: id) {
            try! realm.write {
                user.pin = pin
            }
        }
    }
    
    func addFavoriteSerie(uid: ObjectId, id: Int) {
        if let user = realm.object(ofType: User.self, forPrimaryKey: uid) {
            try! realm.write {
                user.favoriteSeries.append(id)
            }
        }
    }
    
    func removeFavoriteSerie(uid: ObjectId, id: Int) {
        if let user = realm.object(ofType: User.self, forPrimaryKey: uid) {
            try! realm.write {
                if let index = user.favoriteSeries.firstIndex(of: id) {
                    user.favoriteSeries.remove(at: index)
                }
            }
        }
    }
}
