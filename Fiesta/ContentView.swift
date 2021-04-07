////
////  ContentView.swift
////  Fiesta
////
////  Created by 李慶毅 on 2020/11/11.
////
//
//import Combine
//import SwiftUI
//
//struct ContentView: View {
//    @State private var ShowMenuView: Bool = false
//    @ObservedObject private var ActivityList = Activity_API()
//    init() {
//        UITableView.appearance().separatorStyle = .none
//        UITableViewCell.appearance().backgroundColor = .white
//        UITableView.appearance().backgroundColor = .white
//        UITableView.appearance().separatorColor = .white
//    }
//
//    var body: some View {
//        let drag = DragGesture().onEnded {
//            if $0.translation.width < -100 {
//                withAnimation {
//                    self.ShowMenuView = false
//                }
//            }
//        }
//
//        return NavigationView {
//            GeometryReader { geometry in
//                ZStack(alignment: .leading) {
////                  List Index out of Range 待解決
//                    if #available(iOS 14.0, *) {
//                        List {
//                            ForEach(self.ActivityList.InfoList, id: \.self) { Act_Item in
//                                HStack {
//                                    ZStack(alignment: .center) {
//                                        VStack(alignment: .center) {
//                                            HStack {
//                                                VStack(alignment: .center) {
//                                                    VStack(alignment: .leading) {
//                                                        HStack {
//                                                            Image("Logo")
//                                                                .resizable()
//                                                                .scaledToFill()
//                                                                .clipShape(Circle())
//                                                                .frame(width: 40, height: 40)
//                                                                .shadow(color: .gray, radius: 3, x: 1, y: 1)
//                                                                .padding(.leading, 20)
//
//                                                            VStack(alignment: .leading) {
//                                                                Text(Act_Item.View.GroupName)
//                                                                    .font(Font.system(size: 14))
//                                                                    .fontWeight(.medium)
//                                                                    .multilineTextAlignment(.center)
//
//                                                                Text(Act_Item.View.Location)
//                                                                    .font(Font.system(size: 14))
//                                                                    .foregroundColor(Color.gray)
//                                                                    .fontWeight(.medium)
//                                                                    .multilineTextAlignment(.center)
//                                                            }
//
//                                                            Spacer()
//                                                        }
//                                                    }
//                                                    .padding(.top, 15)
//
//                                                    Image("TextImg")
//                                                        .resizable()
//                                                        .scaledToFill()
//                                                        .frame(width: 310, height: 200)
//                                                        .cornerRadius(15)
//
//                                                    VStack(alignment: .leading) {
//                                                        HStack {
//                                                            VStack(alignment: .leading) {
//                                                                HStack {
//                                                                    ForEach(0 ..< Act_Item.View.Tags.count) { tag in
//                                                                        Text("#\(Act_Item.View.Tags[tag])")
//                                                                            .font(Font.system(size: 15))
//                                                                            .foregroundColor(Color.gray)
//                                                                            .multilineTextAlignment(.leading)
//                                                                            .padding(.leading, 3)
//                                                                    }
//                                                                }
//
//                                                                Text(Act_Item.View.Name)
//                                                                    .font(Font.system(size: 28))
//                                                                    .fontWeight(.medium)
//                                                                    .multilineTextAlignment(.center)
//                                                                    .padding(.leading, 10)
//
//                                                                Text(Act_Item.View.StartTime)
//                                                                    .foregroundColor(Color.gray)
//                                                                    .multilineTextAlignment(.trailing)
//                                                                    .padding(.leading, 10)
//                                                            }
//                                                            Spacer()
//                                                        }
//                                                        .padding(.leading, 10)
//                                                        .padding(.top, 30)
//                                                    }
//                                                    .frame(height: 45)
//
//                                                    Spacer()
//                                                }
//                                                .frame(width: 340, height: 365)
//                                                .overlay(
//                                                    RoundedRectangle(cornerRadius: 30)
//                                                        .stroke(Color.gray, lineWidth: 0.5)
//                                                )
//                                            }
//                                        }
//                                        .padding(.bottom, 20)
//
//                                        NavigationLink(destination: Activity_Info_View(Act_Item: Act_Item)) {
//                                            EmptyView()
//                                        }
//                                    }
//                                }
//                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
//                                .listRowInsets(EdgeInsets())
//                            }
//                        }
//                        .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
//                        .offset(x: self.ShowMenuView ? geometry.size.width / 2 : 0)
//                        .listStyle(InsetListStyle())
//                        .onAppear {
//                            UITableView.appearance().separatorStyle = .none
//                            self.ActivityList.Get_Activity_View()
//                        }
//                    } else {
//                        List {
//                            ForEach(self.ActivityList.InfoList, id: \.self) { Act_Item in
//                                HStack {
//                                    ZStack(alignment: .center) {
//                                        VStack(alignment: .center) {
//                                            HStack {
//                                                VStack(alignment: .center) {
//                                                    VStack(alignment: .leading) {
//                                                        HStack {
//                                                            Image("Logo")
//                                                                .resizable()
//                                                                .scaledToFill()
//                                                                .clipShape(Circle())
//                                                                .frame(width: 40, height: 40)
//                                                                .shadow(color: .gray, radius: 3, x: 1, y: 1)
//                                                                .padding(.leading, 20)
//
//                                                            VStack(alignment: .leading) {
//                                                                Text(Act_Item.View.GroupName)
//                                                                    .font(Font.system(size: 14))
//                                                                    .fontWeight(.medium)
//                                                                    .multilineTextAlignment(.center)
//
//                                                                Text(Act_Item.View.Location)
//                                                                    .font(Font.system(size: 14))
//                                                                    .foregroundColor(Color.gray)
//                                                                    .fontWeight(.medium)
//                                                                    .multilineTextAlignment(.center)
//                                                            }
//
//                                                            Spacer()
//                                                        }
//                                                    }
//                                                    .padding(.top, 15)
//
//                                                    Image("TextImg")
//                                                        .resizable()
//                                                        .scaledToFill()
//                                                        .frame(width: 310, height: 200)
//                                                        .cornerRadius(15)
//
//                                                    VStack(alignment: .leading) {
//                                                        HStack {
//                                                            VStack(alignment: .leading) {
//                                                                HStack {
//                                                                    ForEach(0 ..< Act_Item.View.Tags.count) { tag in
//                                                                        Text("#\(Act_Item.View.Tags[tag])")
//                                                                            .font(Font.system(size: 15))
//                                                                            .foregroundColor(Color.gray)
//                                                                            .multilineTextAlignment(.leading)
//                                                                            .padding(.leading, 3)
//                                                                    }
//                                                                }
//
//                                                                Text(Act_Item.View.Name)
//                                                                    .font(Font.system(size: 28))
//                                                                    .fontWeight(.medium)
//                                                                    .multilineTextAlignment(.center)
//                                                                    .padding(.leading, 10)
//
//                                                                Text(Act_Item.View.StartTime)
//                                                                    .foregroundColor(Color.gray)
//                                                                    .multilineTextAlignment(.trailing)
//                                                                    .padding(.leading, 10)
//                                                            }
//                                                            Spacer()
//                                                        }
//                                                        .padding(.leading, 10)
//                                                        .padding(.top, 30)
//                                                    }
//                                                    .frame(height: 45)
//
//                                                    Spacer()
//                                                }
//                                                .frame(width: 340, height: 365)
//                                                .overlay(
//                                                    RoundedRectangle(cornerRadius: 30)
//                                                        .stroke(Color.gray, lineWidth: 0.5)
//                                                )
//                                            }
//                                        }
//                                        .padding(.bottom, 20)
//
//                                        NavigationLink(destination: Activity_Info_View(Act_Item: Act_Item)) {
//                                            EmptyView()
//                                        }
//                                    }
//                                }
//                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
//                            }
//                        }
//                        .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
//                        .offset(x: self.ShowMenuView ? geometry.size.width / 2 : 0)
//                        .onAppear {
//                            UITableView.appearance().separatorStyle = .none
//                            self.ActivityList.Get_Activity_View()
//                        }
//                    }
//
//                    if self.ShowMenuView {
//                        Menu_View()
//                            .frame(width: geometry.size.width / 2)
//                            .transition(.move(edge: .leading))
//                    }
//                }
//                .navigationBarItems(leading:
//                    HStack {
//                        Button(action: {
//                            withAnimation {
//                                self.ShowMenuView.toggle()
//                            }
//                        }) {
//                            Image(systemName: "list.dash")
//                                .font(Font.system(size: 25).bold())
//                                .foregroundColor(Color.orange)
//                        }
//
//                        Image("Title")
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .scaledToFill()
//                            .frame(width: 75, height: 50, alignment: .center)
//                            .padding(UIScreen.main.bounds.size.width / 4 + 5)
//                    }
//                )
//                .gesture(drag)
//            }
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
