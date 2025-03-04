//
//  Season.swift
//  iOSChallenge
//
//  Created by Steven Chaves on 3/3/25.
//

import Foundation

struct Season: Codable, Identifiable {
    let id: Int?
    let name: String?
    let number: Int?
    let episodes: [Episode]?
}
