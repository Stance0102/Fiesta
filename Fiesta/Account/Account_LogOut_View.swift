//
//  Account_LogOut_View.swift
//  Fiesta
//
//  Created by 李慶毅 on 2020/11/13.
//

import SwiftUI

struct Account_LogOut_View: View {
    @StateObject private var viewModel = Account_Login_ViewModel()

    var body: some View {
        Button(action: {
//
        }) {
            Text("登出")
                .foregroundColor(Color.white)
                .bold()
                .offset(x: 0, y: -12.5)
                .background(
                    Image("ShortBtn")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 55, height: 55)
                )
                .frame(width: 80, height: 55)
                .padding(.top, 20)
        }

        Spacer()

        Button(action: {
//            Account_Cls.Send_Confirm_JSON(UserId: UserDefaults.standard.value(forKey: "UserID") as! String, SendConfirmType: "1")
        }) {
            Text("驗證信箱")
                .foregroundColor(Color.white)
                .bold()
                .offset(x: 0, y: -12.5)
                .background(
                    Image("ShortBtn")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 55, height: 55)
                )
                .frame(width: 80, height: 55)
                .padding(.top, 20)
        }
    }
}

struct Account_LogOut_View_Previews: PreviewProvider {
    static var previews: some View {
        Account_LogOut_View()
    }
}
