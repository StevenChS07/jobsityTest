//
//  SeasonViewModel.swift
//  iOSChallenge
//
//  Created by Steven Chaves on 3/3/25.
//

import Foundation
import Combine

class SeasonViewModel: ObservableObject {
    @Published var genres: String = ""
    @Published var time: String = TIME_STR
    @Published var days: String = DAYS_STR
    @Published var seasons = [Season]()
    @Published var episodes: [Int: [Episode]] = [:]
    @Published var isLoading: Bool = false
    private var cancellables = Set<AnyCancellable>()
    
    func getScheduleAndGeneres(serie: Serie) {
        genres = (serie.genres ?? []).joined(separator: " / ")
        time += serie.schedule?.time ?? "00:00"
        days += (serie.schedule?.days ?? []).joined(separator: " / ")
    }
    
    func fetchSeasons(id: Int) {
        self.seasons.removeAll()
        guard !isLoading else { return }
        isLoading = true
        
        ApiService.shared.fetchSeasons(id: id)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error \(error)")
                }
            }, receiveValue: { seasons in
                self.seasons = seasons
                self.fetchEpisodes(for: seasons)
            })
            .store(in: &cancellables)
    }
    
    func fetchEpisodes(for seasons: [Season]) {
        let publishers = seasons.map { ApiService.shared.fetchEpisodes(idSeason: $0.id!)}
        
        Publishers.MergeMany(publishers)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error \(error)")
                }
                self.isLoading = false
            }, receiveValue: { episodes in
                if let seasonNumber = episodes.first?.season {
                    self.episodes[seasonNumber] = episodes
                }
            })
            .store(in: &cancellables)
    }
    
}
