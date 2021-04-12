//
//  Activity_Index_View.swift
//  Fiesta
//
//  Created by Stance Li on 2021/3/31.
//

import SwiftUI
import Combine
import URLImage

struct Activity_Index_View: View {
    @State var show = false
    @StateObject var viewModel = Activity_Info_ViewModel()
    
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
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 0), count: 1))
                        {
                            switch viewModel.state
                            {
                            case .failed:
                                EmptySection() {
                                    self.viewModel.fetch_Activity()
                                }
                            default:
                                Activity_Section
                                    .redacted(reason: viewModel.isLoading ? .placeholder: [])
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

    struct EmptySection: View {
        typealias EmptySectionAction = () -> Void
        let Action: EmptySectionAction
        
        internal init(Action: @escaping EmptySection.EmptySectionAction)
        {
            self.Action = Action
        }
        
        var body: some View {
            HStack(alignment: .center) {
                Text("目前尚無活動喔！")
                    .foregroundColor(.gray)
            }
        }
    }
    
    struct EmptySection_Previews: PreviewProvider {
        static var previews: some View {
            EmptySection() {}
        }
    }
    
    
}
