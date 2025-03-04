//
//  KeychainHelper.swift
//  iOSChallenge
//
//  Created by Steven Chaves on 2/3/25.
//

import Foundation
import KeychainAccess
import RealmSwift

final class KeychainHelper {
    let keyUserTokenStr: String = "userToken"
    static let shared = KeychainHelper()
    private let keychain = Keychain(service: "iOSChallenge")
    
    private init() {}
    
    func saveUserToken(_ token: ObjectId) {
        do {
            try keychain.set(token.stringValue, key: keyUserTokenStr)
        }catch {
            print("Error")
        }
    }
    
    func getUserToken() -> ObjectId? {
        do {
            if let objectIdString = try keychain.get(keyUserTokenStr) {
                return try ObjectId(string: objectIdString)
            }
        }catch{
            print("error")
        }
        return nil
    }
    
    func deleteUserToken() {
        do {
            try keychain.remove(keyUserTokenStr)
        }catch {
            print("Error")
        }
    }
}
