//
//  Account_Login_View.swift
//  Fiesta
//
//  Created by 李慶毅 on 2020/11/12.
//

import SwiftUI
import Combine

struct Account_Login_View: View {
    @State var UserId: String = ""
    @State var Password: String = ""
    @State private var State = false
    @StateObject var viewModel = Account_Login_ViewModel()
    @GestureState private var dragOffset = CGSize.zero
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            HStack {
                Spacer()
                VStack {
                    Spacer()
                    
                    HStack {
                        TextField("帳號", text: $UserId)
                            .font(Font.custom("GenJyuuGothic-Bold", size: 14))
                            .autocapitalization(.none)
                            .frame(width: 250, height: 40)
                            .padding(.leading, 12)
                    }
                    .background(Color.white)
                    .cornerRadius(30)
                    .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 1.5, y: 1.5)
                    .shadow(color: Color.white.opacity(0.6), radius: 3, x: -1.5, y: -1.5)
                    .padding(.bottom, 20)
                    .padding(.top, 50)

                    Section(footer:
                                Text(viewModel.StatusMsg)
                                .foregroundColor(.red)
                                .font(Font.custom("GenJyuuGothic-Bold", size: 18))
                    ) {
                        HStack {
                            SecureField("密碼", text: $Password)
                                .font(Font.custom("GenJyuuGothic-Bold", size: 14))
                                .autocapitalization(.none)
                                .frame(width: 250, height: 40)
                                .padding(.leading, 12)
                        }
                        .background(Color.white)
                        .cornerRadius(30)
                        .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 1.5, y: 1.5)
                        .shadow(color: Color.white.opacity(0.6), radius: 3, x: -1.5, y: -1.5)
                        .padding(.bottom, 5)
                    }
                    .padding(.bottom, 10)

                    Button(action: {
                        if self.UserId != "" && self.Password != ""
                        {
                            self.viewModel.fetch_Account(UserId: self.UserId, Password: self.Password)
                            self.State.toggle()
                        }
                    }) {
                        HStack {
                            Spacer()
                            
                            Text("登入")
                                .font(Font.custom("GenJyuuGothic-Bold", size: 14))
                                .foregroundColor(Color.white)
                                .multilineTextAlignment(.center)
                            
                            Spacer()
                        }
                        .frame(width: 262, height: 40)
                    }
                    .frame(width: 262, height: 40)
                    .background(Color.white.opacity(0.0))
                    .buttonStyle(PlainButtonStyle())
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.white, lineWidth: 1)
                    )
                    Spacer()
                }
                Spacer()
            }
            .background(
                Image("LoginPage")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            )
            .edgesIgnoringSafeArea(.all)
            .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
                if(value.startLocation.x < 100 && value.translation.width > 100) {
                    self.presentationMode.wrappedValue.dismiss()
                }
            }))
            .alert(isPresented: $State){ () -> Alert in
                if viewModel.StatusMsg != ""
                {
                    return Alert(title: Text(viewModel.StatusMsg), dismissButton: .default(Text("OK"), action: {
                        self.State.toggle()
                        }))
                }else{
                    return Alert(title: Text("登入成功"), dismissButton: .default(Text("OK"), action: {
                        self.State.toggle()
                        self.presentationMode.wrappedValue.dismiss()
                        }))
                }
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}
