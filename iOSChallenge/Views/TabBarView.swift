//
//  MainView.swift
//  iOSChallenge
//
//  Created by Steven Chaves on 2/3/25.
//

import SwiftUI
import RealmSwift

struct TabBarView: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    @State var id: ObjectId?
    
    var body: some View {
        TabView {
            
            MainView()
                .tag(0)
                .tabItem {
                    VStack {
                        Image(systemName: "film.stack")
                        Text(SERIES_STR)
                    }
                }
            
            ActorsView()
                .tabItem {
                    VStack {
                        Image(systemName: "person.3.fill")
                        Text(ACTORS_STR)
                    }
                }
            
            ProfileView()
                .tabItem {
                    VStack {
                        iconTabItemLabel()
                        Text(PROFILE_STR)
                    }
                }
            
        }
        .tint(.PRIMARY_GREEN)
        .onAppear() {
            UITabBar.appearance().backgroundColor = .PRIMARY_BLUE
            UITabBar.appearance().barTintColor = UIColor.white
            fetchData()
        }
        .navigationBarBackButtonHidden(true)
        .toolbarBackground(.hidden, for: .navigationBar)
    }
    
    func fetchData() {
        if (id != nil) {
            KeychainHelper.shared.saveUserToken(id!)
        }
        userViewModel.fetchUser(id: KeychainHelper.shared.getUserToken()!)
    }
}

private extension TabBarView {
    @ViewBuilder
    private func iconTabItemLabel() -> some View {
        let image = UIImage(named: userViewModel.user?.iconPath ?? "foIcon")?.createTabItemLabelFromImage()
        Image(uiImage: image!)
    }
}

#Preview {
    TabBarView()
}
