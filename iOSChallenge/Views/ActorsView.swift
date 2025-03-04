//
//  ActorsView.swift
//  iOSChallenge
//
//  Created by Steven Chaves on 2/3/25.
//

import SwiftUI

struct ActorsView: View {
    @StateObject private var viewModel = ActorViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(.PRIMARY_GREEN)
                        .padding(.leading, 10)
                    
                    TextField(SEARCH_STR, text: $viewModel.searchText)
                        .font(.mRegular(size: 14))
                        .padding(5)
                        .disableAutocorrection(true)
                        .background(Color(.systemGray6))
                        .cornerRadius(5)
                    
                    Button(action: {
                        viewModel.searchText = ""
                    }){
                        Image(systemName: "xmark")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(.PRIMARY_GREEN)
                            .padding(.trailing, 10)
                    }
                }
                .frame(height: 50)
                .background(Color.PRIMARY_BLUE)
                
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.filteredActors) { actor in
                            NavigationLink(destination: ActorDetailsView(actor: actor)) {
                                HStack {
                                    ImageLoaderC(url: actor.image?.original ?? "", width: 50, height: 50)
                                        .cornerRadius(25)
                                        .padding(.leading)
                                    
                                    Text(actor.name ?? "")
                                        .font(.mSemiBold(size: 16))
                                        .foregroundStyle(.black)
                                        .padding(.trailing)
                                        .padding(.leading)
                                    
                                    Spacer()
                                }
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                            }
                                
                            Divider()
                                .frame(maxWidth: .infinity)
                                .frame(height: 1)
                                .background(Color.PRIMARY_BLUE)
                                .padding(.horizontal)
                            
                        }
                    }
                }
                .padding(.vertical)
            }
            .overlay() {
                if (viewModel.isLoading) {
                    LoadingViewC()
                        .presentationDetents([.large])
                        .interactiveDismissDisabled(true)
                }
            }
            .toolbarBackground(.PRIMARY_BLUE, for: .tabBar)
        }
    }
}

#Preview {
    ActorsView()
}
