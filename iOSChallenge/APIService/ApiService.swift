//
//  ApiService.swift
//  iOSChallenge
//
//  Created by Steven Chaves on 3/3/25.
//

import Foundation
import Combine

class ApiService {
    static let shared = ApiService()
    
    func fetchSeries(page: Int) -> AnyPublisher<[Serie], Error> {
        let url = URL(string: "https://api.tvmaze.com/shows?page=\(page)")!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [Serie].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetchFilterSeries(query: String) -> AnyPublisher<[FilteredSerie], Error> {
        let url = URL(string: "https://api.tvmaze.com/search/shows?q=\(query)")!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [FilteredSerie].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetchSeasons(id: Int) -> AnyPublisher<[Season], Error> {
        let url = URL(string: "https://api.tvmaze.com/shows/\(id)/seasons")!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [Season].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetchEpisodes(idSeason: Int) -> AnyPublisher<[Episode], Error> {
        let url = URL(string: "https://api.tvmaze.com/seasons/\(idSeason)/episodes")!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [Episode].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetchSerie(id: Int) -> AnyPublisher<Serie, Error> {
        let url = URL(string: "https://api.tvmaze.com/shows/\(id)")!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: Serie.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetchActors() -> AnyPublisher<[Actor], Error> {
        let url = URL(string: "https://api.tvmaze.com/people")!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [Actor].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetchCast(id: Int) -> AnyPublisher<[CastCredit], Error> {
        let url = URL(string: "https://api.tvmaze.com/people/\(id)/castcredits?embed=show")!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [CastCredit].self, decoder: JSONDecoder())
            .map { castCredits in
                castCredits.map { castCredit in
                    var newCastCredit = castCredit
                    newCastCredit.id = UUID()
                    return newCastCredit
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}
