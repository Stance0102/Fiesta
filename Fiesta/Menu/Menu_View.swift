//
//  Menu_View.swift
//  Fiesta
//
//  Created by 李慶毅 on 2020/11/12.
//

import SwiftUI

struct Menu_View: View {
    @ObservedObject private var viewModel = Account_Login_ViewModel()
    @Environment(\.presentationMode) var presentationMode
    init() {
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().backgroundColor = .white
        UITableView.appearance().backgroundColor = .white
        UITableView.appearance().separatorColor = .white
    }

    var body: some View {
        VStack(alignment: .leading) {
            List {
                ZStack(alignment: .leading) {
                    VStack {
                        HStack {
                            Image("Header")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 120, height: 120)
                            Spacer()
                        }
                        HStack {
                            if viewModel.accountViewModel.isEmpty
                            {
                                Text("點擊以登入")
                                    .foregroundColor(Color.black)
                                    .font(Font.system(size: 20))
                                    .bold()
                            }
                            else
                            {
                                Account_Menu_Section
                            }
                            Spacer()
                        }
                        HStack {
                            if UserDefaults.standard.value(forKey: "Email") != nil {
                                Text(UserDefaults.standard.value(forKey: "Email") as! String)
                                    .foregroundColor(Color.gray)
                                    .font(Font.system(size: 22))
                            } else {
                                Text("Email")
                                    .foregroundColor(Color.gray)
                                    .font(Font.system(size: 22))
                            }
                            Spacer()
                        }
                        .padding(.bottom, 15)
                    }
                    if viewModel.accountViewModel .isEmpty {
                        NavigationLink(destination: Account_Login_View()) {
                            EmptyView()
                        }
                    } else {
                        NavigationLink(destination: Activity_Index_View()) {
                            EmptyView()
                        }
                    }
                }

                NavigationLink(destination: EmptyView()) {
                    VStack {
                        HStack {
                            Image("Add")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 20, height: 20)

                            Text("建立活動")
                                .font(Font.system(size: 20))
                                .padding(.leading, 5)

                            Spacer()
                            Spacer()
                        }
                        .frame(width: (UIScreen.main.bounds.size.width / 10) * 6)
                    }
                }

                NavigationLink(destination: EmptyView()) {
                    VStack {
                        HStack {
                            Image(systemName: "doc.text.magnifyingglass")
                                .font(Font.system(size: 20).bold())
                                .foregroundColor(Color.gray)

                            Text("管理活動")
                                .font(Font.system(size: 20))
                                .padding(.leading, 2)

                            Spacer()
                            Spacer()
                        }
                        .frame(width: (UIScreen.main.bounds.size.width / 10) * 6)
                    }
                }

                NavigationLink(destination: EmptyView()) {
                    VStack {
                        HStack {
                            Image("Heart")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 20, height: 20)

                            Text("收藏活動")
                                .font(Font.system(size: 20))
                                .padding(.leading, 5)

                            Spacer()
                            Spacer()
                        }
                        .frame(width: (UIScreen.main.bounds.size.width / 10) * 6)
                    }
                }

                NavigationLink(destination: EmptyView()) {
                    VStack {
                        HStack {
                            Image("Ticket")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 20, height: 20)

                            Text("票匣")
                                .font(Font.system(size: 20))
                                .padding(.leading, 5)

                            Spacer()
                            Spacer()
                        }
                        .frame(width: (UIScreen.main.bounds.size.width / 10) * 6)
                    }
                }

                NavigationLink(destination: EmptyView()) {
                    VStack {
                        HStack {
                            Image("Setting")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 20, height: 20)

                            Text("設定")
                                .font(Font.system(size: 20))
                                .padding(.leading, 5)

                            Spacer()
                            Spacer()
                        }
                        .frame(width: (UIScreen.main.bounds.size.width / 10) * 6)
                    }
                }
            }
            .listRowBackground(Color.green)
        }
//          .navigationBarHidden(true)
        .frame(width: .infinity, alignment: .leading)
    }
}

struct Menu_View_Previews: PreviewProvider {
    static var previews: some View {
        Menu_View()
    }
}

private extension Menu_View
{
    var Account_Menu_Section: some View {
        Text(viewModel.accountViewModel[0].UserName)
            .foregroundColor(Color.black)
            .font(Font.system(size: 20))
            .bold()
    }
}
