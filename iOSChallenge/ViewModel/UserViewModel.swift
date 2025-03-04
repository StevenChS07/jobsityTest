//
//  UserViewModel.swift
//  iOSChallenge
//
//  Created by Steven Chaves on 2/3/25.
//

import Foundation
import SwiftUI
import Combine
import RealmSwift

class UserViewModel: ObservableObject {
    private var userRepository = UserRepository()
    private var cancellables = Set<AnyCancellable>()
    @Published var users: [User] = []
    @Published var user: User?
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    @Published var userSaved: Bool = false
    @Published var selectedUserId: ObjectId?
    
    init() {
        fetchUsers()
    }
    
    func fetchUsers() {
        self.isLoading = true
        userRepository.fetchAllUsers()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] users in
                self?.users = users
                self?.isLoading = false
            }
            .store(in: &cancellables)
    }
    
    func fetchUser(id: ObjectId) {
        self.isLoading = true
        userRepository.fetchUser(by: id)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] user in
                self?.user = user
                self?.isLoading = false
            }
            .store(in: &cancellables)
    }
    
    func addUser(username: String, iconPath: String) {
        guard !username.isEmpty, !iconPath.isEmpty else {
            self.errorMessage = USERNAME_ICON_EMPTY_STR
            return
        }
        
        let user = User()
        user.username = username.lowercased()
        user.iconPath = iconPath
        self.user = user
        let userCreated = userRepository.addUser(user)
        fetchUsers()
        if (userCreated) {
            self.userSaved = true
        }else {
            self.errorMessage = USERNAME_CREATED_STR
        }
    }
    
    func saveUserPin(pin: String, id: ObjectId) {
        userRepository.saveUserPin(id: id, pin: pin)
    }
    
    func toggleFavoriteSerie(id: Int) {
        if (user!.favoriteSeries.contains(id)) {
            userRepository.removeFavoriteSerie(uid: user!.id, id: id)
        } else {
            userRepository.addFavoriteSerie(uid: user!.id, id: id)
        }
    }
}
