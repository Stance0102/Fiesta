//
//  Account_Login_View.swift
//  Fiesta
//
//  Created by 李慶毅 on 2020/11/12.
//

import SwiftUI

struct Account_Login_View: View {
    @State var UserId: String = ""
    @State var Password: String = ""
    @State private var ShowAlert = false
    @ObservedObject var viewModel = Account_Login_ViewModel()
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            HStack {
                Spacer()
                VStack {
                    Spacer()
                    TextField("帳號", text: $UserId)
                        .frame(width: 250, height: 40)
                        .multilineTextAlignment(.center)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.white, lineWidth: 1)
                        )
                        .padding(.top, 50)
                        .padding(.bottom, 20)

                    SecureField("密碼", text: $Password)
                        .multilineTextAlignment(.center)
                        .frame(width: 250, height: 40)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.white, lineWidth: 1)
                        )
                        .padding(.bottom, 20)

                    Button(action: {
                        if self.UserId != "" && self.Password != ""
                        {
                            self.viewModel.fetch_Account(UserId: self.UserId, Password: self.Password)
                        }
                        else
                        {
                            self.ShowAlert = true
                        }
                    }) {
                        Text("登入")
                            .frame(width: 250, height: 40)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.white, lineWidth: 1)
                            )
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.center)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .alert(isPresented: $ShowAlert) { () -> Alert in
                        return Alert(title: Text("帳號和密碼不得為空喔！"))
                    }

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
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct Account_Login_View_Previews: PreviewProvider {
    static var previews: some View {
        Account_Login_View()
    }
}
