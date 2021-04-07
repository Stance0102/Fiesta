//
//  Account_SchoolEmail_View.swift
//  Fiesta
//
//  Created by 李慶毅 on 2020/11/13.
//

import SwiftUI

//struct Account_SchoolEmail_View: View {
//    @State var Email = ""
//    @State var SelectedIndex = 0
//    @State private var ShowAlert = false
//    @ObservedObject private var Account_Cls = Account()
//
//    var body: some View {
//        NavigationView {
//            HStack {
//                Spacer()
//                VStack {
//                    Text("以學校信箱註冊")
//                        .foregroundColor(Color.black)
//                        .bold()
//                        .font(Font.system(size: 25))
//
//                    Divider()
//                        .padding([.top, .bottom], 20)
//
//                    Picker(selection: $SelectedIndex,
//                           label: Text("學校")
//                               .foregroundColor(Color.black)
//                               .font(Font.system(size: 18))
//                               .bold()) {
//                        ForEach(0 ..< Account_Cls.School_C_Email.count) { index in
//                            Text(Account_Cls.School_C_Email[index])
//                        }
//                    }
//
//                    HStack {
//                        Text("Email")
//                            .foregroundColor(Color.black)
//                            .font(Font.system(size: 18))
//                            .bold()
//
//                        TextField("@\(Account_Cls.School_E_Email[SelectedIndex]).edu.tw", text: $Email)
//                            .multilineTextAlignment(.center)
//                            .frame(width: 250, height: 40)
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 20)
//                                    .stroke(Color.gray, lineWidth: 1)
//                            )
//                    }
//
//                    NavigationLink(destination: Account_SignIn_View(Skl_Email: self.Email)) {
//                        Text("下一步")
//                            .bold()
//                            .foregroundColor(Color.white)
//                            .offset(x: 0, y: -12.5)
//                            .background(
//                                Image("ShortBtn")
//                                    .resizable()
//                                    .scaledToFill()
//                                    .frame(width: 55, height: 55)
//                            )
//                    }
//                    .buttonStyle(PlainButtonStyle())
//                    .padding(.top, 50)
//
//                    Spacer()
//                }
//                Spacer()
//            }
//        }
//        .onAppear {
//            Account_Cls.GetEmail()
//        }
//        .navigationBarTitle("")
//        .navigationBarHidden(true)
//    }
//}
//
//struct Account_SchoolEmail_View_Previews: PreviewProvider {
//    static var previews: some View {
//        Account_SchoolEmail_View()
//    }
//}
