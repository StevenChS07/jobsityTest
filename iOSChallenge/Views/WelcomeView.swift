//
//  ContentView.swift
//  iOSChallenge
//
//  Created by Steven Chaves on 1/3/25.
//

import SwiftUI

struct WelcomeView: View {
    
    @StateObject private var viewModel = UserViewModel()
    
    var body: some View {
        var gridItems: [GridItem] {
            viewModel.users.count > 1 ? [GridItem(.fixed(125)), GridItem(.fixed(125))] : [GridItem(.fixed(125))]
        }
        
        NavigationStack {
            VStack {
                ScrollView {
                    Text(USERS_STR)
                        .font(.mSemiBold(size: 25))
                        .foregroundStyle(.white)
                        .padding(.top, 50)
                    
                    Spacer()
                    
                    LazyVGrid(columns: gridItems) {
                        ForEach(viewModel.users, id: \.self) { user in
                            NavigationLink(destination: Group {
                                    if user.pin.isEmpty {
                                        TabBarView(id: user.id)
                                            .toolbarBackground(.hidden, for: .navigationBar)
                                    } else {
                                        EnterPINNumberView(user: user)
                                    }
                                }) {
                                VStack {
                                    Image(user.iconPath)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 100, height: 100)
                                        .clipShape(.circle)
                                    
                                    HStack(alignment: .center, spacing: 5) {
                                        Text(user.username.capitalized)
                                            .font(.mSemiBold(size: 14))
                                            .foregroundStyle(.white)
                                        if (!user.pin.isEmpty) {
                                            Image(systemName: "lock")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 15, height: 15)
                                                .foregroundStyle(.white)
                                        }
                                    }
                                    .padding(.vertical, 5)
                                }
                            }
                        }
                    }
                    .padding()
                    
                    NavigationLink(destination: NewUserView()) {
                        ZStack {
                            Circle()
                                .fill(LinearGradient(gradient: Gradient(colors: [.green, .PRIMARY_GREEN]),
                                                     startPoint: .top,
                                                     endPoint: .bottom))
                                .frame(width: 100, height: 100)
                            
                            Image(systemName: "plus")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .foregroundStyle(.white)
                        }
                    }
                    
                    Text(CREATE_USER_STR)
                        .font(.mSemiBold(size: 14))
                        .foregroundStyle(.white)
                        .padding(.top, 5)
                        .padding(.bottom, 50)
                }
                .padding()
                
                
                Spacer()
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.PRIMARY_BLUE)
        }
        .onAppear() {
            viewModel.fetchUsers()
        }
    }
    
}

#Preview {
    WelcomeView()
}
