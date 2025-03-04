//
//  PINNumberView.swift
//  iOSChallenge
//
//  Created by Steven Chaves on 2/3/25.
//

import SwiftUI

struct PINNumberView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var user: User
    @State private var pin: [String] = ["", "", "", ""]
    @FocusState private var focusedIndex: Int?
    @StateObject private var viewModel = UserViewModel()
    @State private var nextView: Bool = false
    var fromProfile: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text(SKIP_STR)
                    .font(.mRegular(size: 14))
                    .foregroundStyle(.PRIMARY_GREEN)
                    .padding(.trailing, 20)
                    .onTapGesture {
                        if (fromProfile) {
                            presentationMode.wrappedValue.dismiss()
                        }else {
                            self.nextView = true
                        }
                    }
            }
            
            Image(user.iconPath)
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .clipShape(.circle)
                .padding(.top, 50)
            
            Text(user.username.capitalized)
                .font(.mSemiBold(size: 14))
                .foregroundStyle(.white)
                .padding(.top, 5)
                .padding(.bottom, 50)
            
            Text(CREATE_PIN_STR)
                .font(.mBold(size: 24))
                .foregroundStyle(.white)
            
            HStack(spacing: 16) {
                ForEach(0..<4, id: \.self) { index in
                    Text(pin[index].isEmpty ? "•" : "●")
                        .font(.mSemiBold(size: 30))
                        .foregroundStyle(.white)
                        .frame(width: 40, height: 40)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        .overlay(
                            TextField("", text: $pin[index])
                                .keyboardType(.numberPad)
                                .textContentType(.oneTimeCode)
                                .frame(width: 1, height: 1)
                                .opacity(0.01)
                                .focused($focusedIndex, equals: index)
                                .onChange(of: pin[index], initial: true)
                            { oldcount, newValue in
                                if !newValue.isEmpty {
                                    moveToNextField(from: index)
                                }
                            }
                        )
                        .onTapGesture {
                            pin = ["", "", "", ""]
                            focusedIndex = 0
                        }
                }
            }
            .padding(.top, 30)
            
            Spacer()
            
            Button(action: {
                checkPIN()
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
            .disabled(!pinCompletado())
        }
        .navigationBarBackButtonHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.PRIMARY_BLUE)
        .fullScreenCover(isPresented: $nextView) {
            TabBarView()
        }
    }
    
    private func moveToNextField(from index: Int) {
        if index < 3 && !pin[index].isEmpty {
            focusedIndex = index + 1
        } else if index == 3 {
            focusedIndex = nil
        }
    }
    
    private func pinCompletado() -> Bool {
        return pin.allSatisfy { !$0.isEmpty }
    }
    
    private func checkPIN() {
        let finalPin = pin.joined()
        viewModel.saveUserPin(pin: finalPin, id: user.id)
        self.nextView = true
    }
}

#Preview {
    PINNumberView(user: User())
}
