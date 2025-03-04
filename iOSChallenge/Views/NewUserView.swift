//
//  NewUserView.swift
//  iOSChallenge
//
//  Created by Steven Chaves on 1/3/25.
//

import SwiftUI

struct NewUserView: View {
    
    @StateObject private var viewModel = UserViewModel()
    @Environment(\.presentationMode) var presentationMode
    private let fIcon  = "fIcon"
    private let sIcon  = "sIcon"
    private let tIcon  = "tIcon"
    private let foIcon = "foIcon"
    @State private var iconFSelected = false
    @State private var iconSSelected = false
    @State private var iconTSelected = false
    @State private var iconFoSelected = false
    @State private var username: String = ""
    @State private var iconSelected: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Text(ICON_STR)
                    .font(.mSemiBold(size: 25))
                    .foregroundStyle(.white)
                
                HStack {
                    
                    Image(fIcon)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(.circle)
                        .overlay(
                            iconFSelected ? Circle().stroke(Color.PRIMARY_GREEN, lineWidth: 2) : nil
                        )
                        .padding(.trailing, 30)
                        .onTapGesture {
                            self.iconFSelected.toggle()
                            self.iconSSelected = false
                            self.iconTSelected = false
                            self.iconFoSelected = false
                            self.iconSelected = self.fIcon
                        }
                    
                    Image(sIcon)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(.circle)
                        .overlay(
                            iconSSelected ? Circle().stroke(Color.PRIMARY_GREEN, lineWidth: 2) : nil
                        )
                        .onTapGesture {
                            self.iconSSelected.toggle()
                            self.iconFSelected = false
                            self.iconTSelected = false
                            self.iconFoSelected = false
                            self.iconSelected = self.sIcon
                        }
                }
                .padding(.top, 10)
                
                HStack {
                    Image(tIcon)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(.circle)
                        .overlay(
                            iconTSelected ? Circle().stroke(Color.PRIMARY_GREEN, lineWidth: 2) : nil
                        )
                        .padding(.trailing, 30)
                        .onTapGesture {
                            self.iconTSelected.toggle()
                            self.iconSSelected = false
                            self.iconFSelected = false
                            self.iconFoSelected = false
                            self.iconSelected = self.tIcon
                        }
                    
                    Image(foIcon)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(.circle)
                        .overlay(
                            iconFoSelected ? Circle().stroke(Color.PRIMARY_GREEN, lineWidth: 2) : nil
                        )
                        .onTapGesture {
                            self.iconFoSelected.toggle()
                            self.iconSSelected = false
                            self.iconTSelected = false
                            self.iconFSelected = false
                            self.iconSelected = self.foIcon
                        }
                }
                .padding(.top, 30)
                
                ZStack {
                    
                    if username.isEmpty {
                        Text(USERNAME_STR)
                            .font(.mSemiBold(size: 16))
                            .foregroundColor(Color.white)
                            .padding(.top, 17.5)
                    }
                    
                    TextField("", text: $username)
                        .padding(.horizontal, 20)
                        .frame(height: 50)
                        .cornerRadius(25)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.white, lineWidth: 1)
                        )
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .multilineTextAlignment(.center)
                        .font(.mSemiBold(size: 16))
                        .foregroundColor(.white)
                        .padding(.horizontal)
                        .padding(.top, 20)
                }
                .padding(.top, 50)
                
                Spacer()
                
                Button(action: {
                    viewModel.addUser(username: username, iconPath: iconSelected)
                }) {
                    Text(NEXT_STR)
                        .font(.mSemiBold(size: 18))
                        .foregroundStyle(.white)
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(LinearGradient(gradient: Gradient(colors: [.green, .PRIMARY_GREEN]),
                                                   startPoint: .leading,
                                                   endPoint: .trailing))
                        .cornerRadius(25)
                        .padding(.horizontal)
                        .padding(.bottom, 50)
                }
                    
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.PRIMARY_BLUE)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "arrow.left")
                    .foregroundColor(.PRIMARY_GREEN)
                    .font(.mSemiBold(size: 14))
                Text(BACK_STR)
                    .font(.mSemiBold(size: 14))
                    .tint(Color.white)
            }
        })
        .overlay() {
            if (viewModel.isLoading) {
                LoadingViewC()
                    .presentationDetents([.large])
                    .interactiveDismissDisabled(true)
            }
        }
        .alert(isPresented: Binding (
            get: { !viewModel.errorMessage.isEmpty },
            set: { _ in viewModel.errorMessage = "" }
        )) {
            Alert(
                title: Text(ERROR_STR),
                message: Text(viewModel.errorMessage),
                dismissButton: .default(Text(OK_STR))
            )
        }
        .fullScreenCover(isPresented: $viewModel.userSaved) {
            PINNumberView(user: viewModel.user!)
        }
        
    }
}

#Preview {
    NewUserView()
}
