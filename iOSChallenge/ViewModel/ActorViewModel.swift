//
//  ActorViewModel.swift
//  iOSChallenge
//
//  Created by Steven Chaves on 4/3/25.
//

import Foundation
import SwiftUI
import Combine
import RealmSwift

class ActorViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    @Published var searching: Bool = false
    @Published var actors: [Actor] = []
    @Published var actorSelected: Actor?
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchActors()
    }
    
    func fetchActors() {
        guard !isLoading else { return }
        isLoading = true
        
        ApiService.shared.fetchActors()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error \(error)")
                }
                self.isLoading = false
            }, receiveValue: { newSeries in
                self.actors.append(contentsOf: newSeries)
            })
            .store(in: &cancellables)
    }
    
    var filteredActors: [Actor] {
        guard !searchText.isEmpty else {
            return actors
        }
        
        return actors.filter {
            $0.name!.lowercased().hasPrefix(searchText.lowercased())
        }
    }
    
    func fetchCast() {
        isLoading = true
        
        ApiService.shared.fetchCast(id: actorSelected?.id ?? 0)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error \(error)")
                }
                self.isLoading = false
            }, receiveValue: { castCredits in
                self.actorSelected?.castCredit = castCredits
            })
            .store(in: &cancellables)
    }
}
