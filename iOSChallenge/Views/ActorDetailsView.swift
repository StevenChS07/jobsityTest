//
//  ActorDetailsView.swift
//  iOSChallenge
//
//  Created by Steven Chaves on 4/3/25.
//

import SwiftUI

struct ActorDetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = ActorViewModel()
    @State var actor: Actor?
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    ImageLoaderC(url: actor?.image?.original ?? "error", width: 250, height: 250)
                        .padding(.top, 20)
                        .shadow(color: Color.black.opacity(0.8), radius: 6, x: 0, y: 4)
                    
                    Divider()
                        .frame(maxWidth: .infinity)
                        .frame(height: 1)
                        .background(Color.PRIMARY_BLUE)
                        .padding(.horizontal)
                        .padding(.top, 1)
                    
                    Text(actor?.name ?? TITLE_STR)
                        .font(.mBold(size: 24))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 5)
                        .padding(.horizontal)
                    
                    Divider()
                        .frame(maxWidth: .infinity)
                        .frame(height: 1)
                        .background(Color.PRIMARY_BLUE)
                        .padding(.horizontal)
                    
                    Text(CAST_CREDITS_STR)
                        .font(.mBold(size: 16))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    LazyVStack {
                        ForEach (viewModel.actorSelected?.castCredit ?? []) { castCredit in
                            NavigationLink(destination: SerieDetailsView(serie: castCredit._embedded?.show!)){
                                VStack {
                                    Text(castCredit._links?.show?.name ?? "")
                                        .font(.mBold(size: 18))
                                        .foregroundStyle(.black)
                                    
                                    Text(castCredit._links?.character?.name ?? "")
                                        .font(.mRegular(size: 14))
                                        .foregroundStyle(.black)
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
                    
                    
                    Spacer()
                }
            }
        }
        .overlay() {
            if (viewModel.isLoading) {
                LoadingViewC()
                    .presentationDetents([.large])
                    .interactiveDismissDisabled(true)
            }
        }
        .onAppear() {
            viewModel.actorSelected = actor
            viewModel.fetchCast()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "arrow.left")
                    .foregroundColor(.PRIMARY_GREEN)
                
                Text(BACK_STR)
                    .font(.mSemiBold(size: 14))
                    .tint(Color.white)
            }
        })
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(actor?.name ?? "")
                    .font(.mBold(size: 16))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.PRIMARY_BLUE, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

#Preview {
    ActorDetailsView()
}
