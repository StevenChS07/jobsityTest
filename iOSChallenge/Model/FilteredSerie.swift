//
//  FilteredSerie.swift
//  iOSChallenge
//
//  Created by Steven Chaves on 3/3/25.
//

import Foundation

struct FilteredSerie: Codable, Identifiable {
    var id: Int?
    let score: Float?
    let show: Serie
}

