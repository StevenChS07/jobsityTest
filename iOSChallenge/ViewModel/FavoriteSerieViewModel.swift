//
//  FavoriteSerieViewModel.swift
//  iOSChallenge
//
//  Created by Steven Chaves on 4/3/25.
//

import Foundation
import Combine

class FavortiteSerieViewModel: ObservableObject {
    @Published var series = [Serie]()
    @Published var isLoading: Bool = false
    private var cancellables = Set<AnyCancellable>()
    
    func fetchFavoriteSeries(ids: [Int]) {
        self.series.removeAll()
        guard !isLoading else { return }
        isLoading = true
        
        let publishers = ids.map { ApiService.shared.fetchSerie(id: $0) }
        
        Publishers.MergeMany(publishers)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error \(error)")
                }
                self.isLoading = false
                print(self.series)
            }, receiveValue: { serie in
                self.series.append(serie)
            })
            .store(in: &cancellables)
    }
}
