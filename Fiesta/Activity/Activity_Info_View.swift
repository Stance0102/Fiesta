//
//  Activity_Info_View.swift
//  Fiesta
//
//  Created by Stance Li on 2020/11/12.
//

import SwiftUI

struct Activity_Info_View: View {
    @ObservedObject private var TicketKind = Ticket()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var HeartFill = false
    private let act_ViewModel: Activity_ViewModel
    
    init(act_ViewModel: Activity_ViewModel) {
        self.act_ViewModel = act_ViewModel
    }

    var body: some View {
        
//        ZStack {
//            HStack {
//                Button(action: {
//                    self.presentationMode.wrappedValue.dismiss()
//                }){
//                    Image(systemName: "arrow.backward")
//                        .renderingMode(.template)
//                        .foregroundColor(.white)
//                        .font(.title)
//                        .frame(width: 80, height: 80)
//                }
//
//                Spacer()
//            }
//        }
                
        ScrollView(.vertical, showsIndicators: false) {
            GeometryReader { reader in
                if reader.frame(in: .global).minY > -480 {
                    Image("paper")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .offset(y: -reader.frame(in: .global).minY)
                        .frame(width: UIScreen.main.bounds.width, height:
                                reader.frame(in: .global).minY > 0 ?
                               reader.frame(in: .global).minY + 480 : 480)
                }
            }
            .frame(height: 480)
            
            VStack(alignment: .leading) {
                HStack {
                    Text(act_ViewModel.Name)
                        .font(Font.custom("GenJyuuGothic-Bold", size: 24))
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                .padding(.horizontal, 22)
                .padding(.bottom, 5)

                HStack {
                    Image("Logo")
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 45, height: 45)
                        .shadow(color: .gray, radius: 3, x: 1, y: 1)
                        

                    Text(act_ViewModel.GroupName)
                        .font(Font.custom("GenJyuuGothic-Regular", size: 18))
                        .multilineTextAlignment(.center)
                        .padding(.leading, 5)
                }
                .padding(.horizontal, 22)

                Divider()

                HStack {
                    Image("DateIcon")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 30, height: 30)

                    Text("\(act_ViewModel.StartTime_All) ~ \(act_ViewModel.EndTime_All)")
                        .font(Font.custom("GenJyuuGothic-Regular", size: 16))
                        .foregroundColor(Color.black)
                        .padding(.leading, 5)
                }
                .padding(.horizontal, 25)

                HStack {
                    Image("LocationIcon")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 30, height: 30)
                        

                    Text(act_ViewModel.Location)
                        .font(Font.custom("GenJyuuGothic-Regular", size: 16))
                        .foregroundColor(Color.black)
                        .padding(.leading, 5)
                }
                .padding(.horizontal, 25)

                Image("TestMap")
                    .resizable()
                    .scaledToFill()
                
                HStack {
                    Spacer()
                    
                    Text("活動簡介")
                        .font(Font.custom("GenJyuuGothic-Medium", size: 24))
                        .multilineTextAlignment(.center)
                        .padding(.top, 20)
                    
                    Spacer()
                }

                Text(act_ViewModel.Description)
                    .font(Font.custom("GenJyuuGothic-Regular", size: 16))
                    .foregroundColor(Color.black)
                    .frame(width: UIScreen.main.bounds.width - 100, height: 300, alignment: .topLeading)
                    .padding(.top, 15)
                    .padding(.leading, 5)
            }
            .background(Color.white)
            .padding(.vertical, 20)
            .padding(.horizontal)
            .background(Color.white)
            .cornerRadius(30)
            .shadow(color: Color.gray.opacity(0.9), radius: 3, x: -2.5, y: -2.5)
            .shadow(color: Color.white.opacity(0.9), radius: 3, x: 2.5, y: 2.5)
            .offset(y: -35)
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarTitle(act_ViewModel.Name)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(true)
    }
}
