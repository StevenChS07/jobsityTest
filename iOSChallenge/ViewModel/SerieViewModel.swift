//
//  SerieViewModel.swift
//  iOSChallenge
//
//  Created by Steven Chaves on 2/3/25.
//

import Foundation
import Combine

class SerieViewModel: ObservableObject {
    @Published var series = [Serie]()
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    @Published var searching: Bool = false
    var currentPage: Int = 0
    private var cancellables = Set<AnyCancellable>()
    
    func loadMoreSeries() {
        if (searching) {
            searching = false
            series.removeAll()
        }
        if (currentPage == 0) {
            series.removeAll()
        }
        
        guard !isLoading else { return }
        isLoading = true
        
        ApiService.shared.fetchSeries(page: currentPage)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error \(error)")
                }
                self.isLoading = false
            }, receiveValue: { newSeries in
                self.series.append(contentsOf: newSeries)
                self.currentPage += 1
            })
            .store(in: &cancellables)
    }
    
    func searchSeries() {
        self.series.removeAll()
        searching = true
        guard !isLoading else { return }
        isLoading = true
        
        ApiService.shared.fetchFilterSeries(query: self.searchText)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error \(error)")
                }
                self.isLoading = false
            }, receiveValue: { filteredSeries in
                self.series.append(contentsOf: filteredSeries.map { $0.show })
            })
            .store(in: &cancellables)
    }
}
