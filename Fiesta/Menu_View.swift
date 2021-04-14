//
//  Menu_View.swift
//  Fiesta
//
//  Created by Stance Li on 2021/4/8.
//
 
import SwiftUI

struct Menu: View {
    @StateObject var viewModel = Account_Login_ViewModel()
//    @State private var State = false
    @Binding var show: Bool
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Button(action: {
                        withAnimation(.default)
                        {
                            self.show.toggle()
                        }
                    })
                    {
                        Image(systemName: "chevron.backward")
                            .resizable()
                            .foregroundColor(Color.white)
                            .frame(width: 12, height: 20)
                    }
                    
                    Spacer()
                    
                    if UserDefaults.standard.value(forKey: "UserId") != nil {
                        Button(action: {
                            UserDefaults.standard.set(nil, forKey: "Id")
                            UserDefaults.standard.set(nil, forKey: "UserId")
                            UserDefaults.standard.set(nil, forKey: "UserName")
                            UserDefaults.standard.set(nil, forKey: "Email_1")
                            UserDefaults.standard.set(nil, forKey: "NickName")
                            UserDefaults.standard.set(nil, forKey: "Token")
                            
                            withAnimation(.default)
                            {
                                self.show = false
                            }
                        }){
                            HStack {
                                Image(systemName: "figure.walk")
                                    .resizable()
                                    .foregroundColor(Color.white)
                                    .frame(width: 12, height: 20)
                                
                                Text("LogOut")
                                    .font(Font.custom("GenJyuuGothic-Bold", size: 16))
                            }
                        }
                    }
                }
                .padding(.top)
                .padding(.bottom, 25)
        
                if UserDefaults.standard.value(forKey: "UserId") != nil
                {
                    NavigationLink(destination: EmptyView()) {
                        HStack {
                            Image("Header")
                                .resizable()
                                .frame(width: 80, height: 80)
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading, spacing: 3) {
                                
                                Text("\(UserDefaults.standard.string(forKey: "NickName") ?? "")")
                                    .font(Font.custom("GenJyuuGothic-Bold", size: 26))
                                
                                Text("@\(UserDefaults.standard.string(forKey: "UserId") ?? "")")
                                    .font(Font.custom("GenJyuuGothic-Medium", size: 13))
                                    
                            }
                            .padding(.leading, 10)
                            
                            Spacer()
                        }
                    }
                }else{
                    NavigationLink(destination: Account_Login_View()) {
                        HStack {
                            Image("Header")
                                .resizable()
                                .frame(width: 80, height: 80)
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading, spacing: 3) {
                                
                                Text("登入")
                                    .font(Font.custom("GenJyuuGothic-Bold", size: 26))
                            }
                            .padding(.leading, 10)
                            
                            Spacer()
                        }
                    }
                    .onAppear {
                        withAnimation(.default)
                        {
                            self.show = false
                        }
                    }
                }
                
                Divider()
                    .padding(.top, 25)
            }
            .foregroundColor(Color.white)
            .padding(.horizontal, 20)
            .background(Color.orange.edgesIgnoringSafeArea(.all))
            
            MenuItem()
            
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width / 1.5)
        .background(
            Color.white.edgesIgnoringSafeArea(.all)
        )
        .overlay(
            Rectangle()
                .stroke(Color.gray.opacity(0.2), lineWidth: 2)
                .shadow(radius: 3)
                .edgesIgnoringSafeArea(.all)
        )
    }
}

struct MenuItem: View {
    var body: some View {
        LazyVGrid(columns: Array(repeating:GridItem(.flexible(), spacing: 0), count: 1)) {
            NavigationLink(destination: Activity_Index_View()) {
                VStack {
                    HStack {
                        Text("首頁")
                            .font(Font.custom("GenJyuuGothic-Bold", size: 20))
                            .foregroundColor(Color.black)
                            .padding(.leading, 10)

                        Spacer()
                    }
                    .padding(.vertical, 8)
                    
                    Divider().background(Color.black.opacity(0.7))
                }
            }

            NavigationLink(destination: EmptyView()) {
                VStack {
                    HStack {
                        Text("創建活動")
                            .font(Font.custom("GenJyuuGothic-Bold", size: 20))
                            .foregroundColor(Color.black)
                            .padding(.leading, 10)

                        Spacer()
                    }
                    .padding(.vertical, 8)
                    
                    Divider().background(Color.black.opacity(0.7))
                }
            }

            NavigationLink(destination: EmptyView()) {
                VStack {
                    HStack {
                        Text("編輯活動")
                            .font(Font.custom("GenJyuuGothic-Bold", size: 20))
                            .foregroundColor(Color.black)
                            .padding(.leading, 10)

                        Spacer()
                    }
                    .padding(.vertical, 8)
                    
                    Divider().background(Color.black.opacity(0.7))
                }
            }
            

            NavigationLink(destination: EmptyView()) {
                VStack {
                    HStack {
                        Text("管理群組")
                            .font(Font.custom("GenJyuuGothic-Bold", size: 20))
                            .foregroundColor(Color.black)
                            .padding(.leading, 10)

                        Spacer()
                    }
                    .padding(.vertical, 8)
                    
                    Divider().background(Color.black.opacity(0.7))
                }
            }
            
            

            NavigationLink(destination: EmptyView()) {
                VStack {
                    HStack {
                        Text("票據")
                            .font(Font.custom("GenJyuuGothic-Bold", size: 20))
                            .foregroundColor(Color.black)
                            .padding(.leading, 10)

                        Spacer()
                    }
                    .padding(.vertical, 8)
                    
                    Divider().background(Color.black.opacity(0.7))
                }
            }
            

            NavigationLink(destination: EmptyView()) {
                VStack {
                    HStack {
                        Text("設定")
                            .font(Font.custom("GenJyuuGothic-Bold", size: 20))
                            .foregroundColor(Color.black)
                            .padding(.leading, 10)

                        Spacer()
                    }
                    .padding(.vertical, 8)
                    
                    Divider().background(Color.black.opacity(0.7))
                }
            }
        }
        .padding(.bottom, 3)
        .padding(.horizontal, 15)
    }
}
