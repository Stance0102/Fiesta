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
    @State var alert = false
    @ObservedObject var viewModel = Account_Login_ViewModel()
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
                        }
                    }) {
                        Text("登入")
                            .font(Font.custom("GenJyuuGothic-Bold", size: 14))
                            .frame(width: 262, height: 40)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.white, lineWidth: 1)
                            )
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.center)
                    }
                    .buttonStyle(PlainButtonStyle())

                    NavigationLink(destination: EmptyView() /* School_Email_View() */ ) {
                        Text("註冊")
                            .bold()
                            .foregroundColor(Color.white)
                            .offset(x: 0, y: -12.5)
                            .background(
                                Image("ShortBtn")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 55, height: 55)
                            )
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.top, 30)

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
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}
