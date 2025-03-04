//
//  Serie.swift
//  iOSChallenge
//
//  Created by Steven Chaves on 2/3/25.
//

import Foundation

struct Serie: Codable, Identifiable {
    let id: Int?
    let url: String?
    let name: String?
    let type: String?
    let language: String?
    let genres: [String]?
    let status: String?
    let runtime: Int?
    let averageRuntime: Int?
    let premiered: String?
    let ended: String?
    let officialSite: String?
    let schedule: Schedule?
    let rating: Rating?
    let weight: Int?
    let network: Network?
    let externals: Externals?
    let image: Image?
    let summary: String?
    let updated: Int?
    let links: Links?
    
    struct Schedule: Codable {
        let time: String?
        let days: [String]?
    }
    
    struct Rating: Codable {
        let average: Double?
    }
    
    struct Network: Codable {
        let id: Int?
        let name: String?
        let country: Country?
        let officialSite: String?
        
        struct Country: Codable {
            let name: String?
            let code: String?
            let timezone: String?
        }
    }
    
    struct Externals: Codable {
        let tvrage: Int?
        let thetvdb: Int?
        let imdb: String?
    }
    
    struct Image: Codable {
        let medium: String?
        let original: String?
    }
    
    struct Links: Codable {
        let selfLink: SelfLink?
        let previousEpisode: PreviousEpisode?
        
        struct SelfLink: Codable {
            let href: String?
        }
        
        struct PreviousEpisode: Codable {
            let href: String?
            let name: String?
        }
    }
}
