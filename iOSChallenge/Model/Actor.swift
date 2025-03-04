//
//  Actor.swift
//  iOSChallenge
//
//  Created by Steven Chaves on 4/3/25.
//

import Foundation

struct Actor: Codable, Identifiable {
    var id: Int?
    var name: String?
    var image: Image?
    var castCredit: [CastCredit]?
    
    struct Image: Codable {
        let medium: String?
        let original: String?
    }
}

struct CastCredit: Codable, Identifiable {
    var id: UUID?
    var _links: Links?
    var _embedded: Embedded?
}

struct Links: Codable {
    var show: Show?
    var character: Character?
}

struct Character: Codable {
    var name: String?
}

struct Show: Codable {
    var name: String?
}

struct Embedded: Codable {
    var show: Serie?
}
