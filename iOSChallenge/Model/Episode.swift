//
//  Episode.swift
//  iOSChallenge
//
//  Created by Steven Chaves on 3/3/25.
//

import Foundation

struct Episode: Codable, Identifiable {
    let id: Int?
    let name: String?
    let number: Int?
    let season: Int?
    let summary: String?
    let image: Image?
    
    struct Image: Codable {
        let medium: String?
        let original: String?
    }
}


