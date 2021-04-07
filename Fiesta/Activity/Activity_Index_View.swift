//
//  Activity_Index_View.swift
//  Fiesta
//
//  Created by Stance Li on 2021/3/31.
//

import SwiftUI
import Combine

struct Activity_Index_View: View {
    @State var show = false
    @ObservedObject var viewModel = Activity_Info_ViewModel()
    
    init()
    {
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().backgroundColor = .white
        UITableView.appearance().backgroundColor = .white
        UITableView.appearance().separatorColor = .white
    }

    var body: some View {
        NavigationView {
            ZStack {
                Color.white
                Activity_Content
                
            }
            .navigationBarTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
        }
    }
}

private extension Activity_Index_View
{
    var Activity_Content: some View {
        ZStack(alignment: .leading)
        {
            GeometryReader { _ in
                VStack {
                    ZStack {
                        HStack {
                            Button(action: {
                                withAnimation(.default)
                                {
                                    self.show.toggle()
                                }
                            }){
                                Image("Menu")
                                    .resizable()
                                    .frame(width: 65, height: 65)
                            }
                            Spacer()
                        }

                        Image("Title")
                            .resizable()
                            .frame(width: 110, height: 50)
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    ScrollView(.vertical, showsIndicators: false)
                    {
                        LazyVGrid(columns: Array(repeating:GridItem(.flexible(), spacing: 0), count: 1))
                        {
                            if viewModel.activityViewModel.isEmpty {
                                EmptySection
                            }else{
                                Activity_Section
                            }
                        }
                        .onAppear {
                            UITableView.appearance().separatorStyle = .none
                            self.viewModel.fetch_Activity()
                        }
                    }
                }
            }
            HStack {
                Menu(show: self.$show)
                    .offset(x: self.show ? 0 : -UIScreen.main.bounds.width / 1.5)
                
                Spacer(minLength: 0)
            }
            .background(
                Color.primary.opacity(self.show ? 0.2 : 0 )
                    .edgesIgnoringSafeArea(.all)
            )
        }
    }
    
    var Activity_Section: some View {
        ForEach(viewModel.activityViewModel, id: \.self, content: Activity_Block.init(viewModel: ))
    }

    var EmptySection: some View {
        HStack(alignment: .center) {
            Text("目前尚無活動喔！")
                .foregroundColor(.gray)
        }
    }
}

struct Menu: View {
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
                    
                    Button(action: {
                        
                    }){
                        Image(systemName: "square.and.pencil")
                            .font(.title)
                    }
                }
                .padding(.top)
                .padding(.bottom, 25)
                
                HStack {
                    Image("Header")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 3) {
                        Text("小毅")
                            .font(Font.custom("GenJyuuGothic-Bold", size: 26))
                        
                        Text("@stance0102")
                            .font(Font.custom("GenJyuuGothic-Medium", size: 13))
                            
                    }
                    .padding(.leading, 10)
                    
                    Spacer()
                }
                
                Divider()
                    .padding(.top, 25)
            }
            .foregroundColor(Color.white)
            .padding(.horizontal, 20)
            .background(
                Color
                    .orange
                    .edgesIgnoringSafeArea(.all)
            )
            
            Group
            {
                Button(action: {
                    
                }){
                    HStack {
                        Image(systemName: "house")
                            .font(.title)
                            .foregroundColor(Color.black)
                        
                        Text("首頁")
                            .font(Font.custom("GenJyuuGothic-Bold", size: 20))
                            .foregroundColor(Color.black)
                            .padding(.leading, 5)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 15)
                }
                .padding(.bottom, 3)
                Divider().frame(width: 245,height: 1).background(Color.gray.opacity(0.8))
            }
            
            Group
            {
                Button(action: {
                    
                }){
                    HStack {
                        Image(systemName: "plus")
                            .font(.title)
                            .foregroundColor(Color.black)
                        
                        Text("創建活動")
                            .font(Font.custom("GenJyuuGothic-Bold", size: 20))
                            .foregroundColor(Color.black)
                            .padding(.leading, 5)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 15)
                }
                .padding(.bottom, 3)
                Divider().frame(width: 245,height: 1).background(Color.gray.opacity(0.8))
            }
            
            Group
            {
                Button(action: {
                    
                }){
                    HStack {
                        Image(systemName: "square.and.pencil")
                            .font(.title)
                            .foregroundColor(Color.black)
                        
                        Text("編輯活動")
                            .font(Font.custom("GenJyuuGothic-Bold", size: 20))
                            .foregroundColor(Color.black)
                            .padding(.leading, 5)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 15)
                }
                .padding(.bottom, 3)
                Divider().frame(width: 245,height: 1).background(Color.gray.opacity(0.8))
            }
            
            Group
            {
                Button(action: {
                    
                }){
                    HStack {
                        Image(systemName: "square.grid.2x2")
                            .font(.title)
                            .foregroundColor(Color.black)
                        
                        Text("管理群組")
                            .font(Font.custom("GenJyuuGothic-Bold", size: 20))
                            .foregroundColor(Color.black)
                            .padding(.leading, 5)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 15)
                }
                .padding(.bottom, 3)
                Divider().frame(width: 245,height: 1).background(Color.gray.opacity(0.8))
            }
            
            Group
            {
                Button(action: {
                    
                }){
                    HStack {
                        Image(systemName: "ticket")
                            .font(.title)
                            .foregroundColor(Color.black)
                        
                        Text("我的票據")
                            .font(Font.custom("GenJyuuGothic-Bold", size: 20))
                            .foregroundColor(Color.black)
                            .padding(.leading, 5)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 15)
                }
                .padding(.bottom, 3)
                Divider().frame(width: 245,height: 1).background(Color.gray.opacity(0.8))
            }
            
            Group
            {
                Button(action: {
                    
                }){
                    HStack {
                        Image(systemName: "gearshape")
                            .font(.title)
                            .foregroundColor(Color.black)
                        
                        Text("設定")
                            .font(Font.custom("GenJyuuGothic-Bold", size: 20))
                            .foregroundColor(Color.black)
                            .padding(.leading, 5)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 15)
                }
                .padding(.bottom, 3)
                Divider().frame(width: 245,height: 1).background(Color.gray.opacity(0.8))
            }
            
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
