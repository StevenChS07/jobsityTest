//
//  User.swift
//  iOSChallenge
//
//  Created by Steven Chaves on 2/3/25.
//

import Foundation
import RealmSwift

class User: Object, Identifiable {
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var username: String
    @Persisted var iconPath: String
    @Persisted var pin: String
    @Persisted var favoriteSeries = RealmSwift.List<Int>()
    
}
