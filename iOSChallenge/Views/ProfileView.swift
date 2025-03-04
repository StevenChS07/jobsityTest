//
//  ProfileView.swift
//  iOSChallenge
//
//  Created by Steven Chaves on 2/3/25.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @State private var listItems: [String] = []
    
    var body: some View {
        NavigationStack {
            VStack {
                Image(userViewModel.user?.iconPath ?? "")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .cornerRadius(75)
                    .padding(.top, 20)
                
                if let pin = userViewModel.user?.pin, !pin.isEmpty {
                    Image(systemName: "lock")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 15, height: 15)
                        .foregroundStyle(.PRIMARY_GREEN)
                }
                
                Text(userViewModel.user?.username.capitalized ?? "")
                    .font(.mBold(size: 24))
                    .foregroundStyle(.PRIMARY_GREEN)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 5)
                    .padding(.horizontal)
                
                Divider()
                    .frame(maxWidth: .infinity)
                    .frame(height: 1)
                    .background(Color.PRIMARY_BLUE)
                    .padding(.horizontal)
                
                List {
                    ForEach (listItems, id: \.self) { item in
                        NavigationLink(destination: destinationView(for: item)) {
                            Text(item)
                                .font(.mRegular(size: 16))
                                .foregroundStyle(.black)
                        }
                    }
                }
                
            }
            .onAppear() {
                if (userViewModel.user!.pin.isEmpty) {
                    listItems = ["Favorite Series", "Set PIN", "Change User"]
                }else {
                    listItems = ["Favorite Series", "Change User"]
                }
            }
            .background(.PRIMARY_BLUE)
            .toolbarBackground(.PRIMARY_BLUE, for: .tabBar)
        }
    }
    
    private func destinationView(for item: String) -> some View {
        switch item {
        case "Favorite Series":
            return AnyView(FavoriteSeriesView()
                .toolbar(.hidden, for: .tabBar))
        case "Set PIN":
            return AnyView(PINNumberView(user: userViewModel.user!, fromProfile: true))
        case "Change User":
            return AnyView(WelcomeView()
                .toolbar(.hidden, for: .tabBar))
        default:
            return AnyView(WelcomeView())
        }
    }
}

#Preview {
    ProfileView()
}
