////
////  Activity_SelectGroup_View.swift
////  Fiesta
////
////  Created by 李慶毅 on 2020/11/18.
////
//
//import SwiftUI
//
//struct Activity_SelectGroup_View: View {
//    @ObservedObject private var Group_Selected = Group_API()
//    @State var selectedIndex = 0
//    @State private var PopAlert: Bool = false
//    @State private var Selected_Group: String = ""
//
//    var body: some View {
//        NavigationView {
//            ScrollView(.vertical) {
//                ZStack {
//                    HStack {
//                        Spacer()
//                        VStack {
//                            Text("選擇主辦活動群組")
//                                .foregroundColor(Color.black)
//                                .bold()
//                                .font(Font.system(size: 25))
//
//                            Picker(selection: $Selected_Group, label: Text("")) {
//                                ForEach(self.Group_Selected.GroupList, id: \.Id) { Group in
//                                    Text(Group.Name)
//                                }
//                            }
//                            .labelsHidden()
//
//                            NavigationLink(destination:
//                                ContentView()
//                            ) {
//                                Text("下一步")
//                                    .bold()
//                                    .foregroundColor(Color.white)
//                                    .offset(x: 0, y: -12.5)
//                                    .background(
//                                        Image("ShortBtn")
//                                            .resizable()
//                                            .scaledToFill()
//                                            .frame(width: 55, height: 55)
//                                    )
//                            }
//                            .buttonStyle(PlainButtonStyle())
//
//                            Divider()
//                                .padding([.top, .bottom], 40)
//
//                            NavigationLink(destination: ContentView()) {
//                                Text("建立群組")
//                                    .bold()
//                                    .foregroundColor(Color.white)
//                                    .offset(x: 0, y: -8)
//                                    .background(
//                                        Image("LongBtn")
//                                            .resizable()
//                                            .scaledToFill()
//                                            .frame(width: 55, height: 55)
//                                    )
//                            }
//                            .buttonStyle(PlainButtonStyle())
//                            .padding(.top, 20)
//                        }
//                        .onAppear { Group_Selected.Get_Joined_Group() }
//                        .padding(.top, -80)
//                        Spacer()
//                    }
//                }
//            }
//        }
//        .navigationBarTitle("")
//        .navigationBarHidden(true)
//    }
//}
//
//struct Activity_SelectGroup_View_Previews: PreviewProvider {
//    static var previews: some View {
//        Activity_SelectGroup_View()
//    }
//}
