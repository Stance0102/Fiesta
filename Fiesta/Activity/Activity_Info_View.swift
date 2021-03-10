//
//  Activity_Info_View.swift
//  Fiesta
//
//  Created by 李慶毅 on 2020/11/12.
//

import SwiftUI

struct Activity_Info_View: View {
    var Act_Item: Activity_All
    @ObservedObject private var TicketKind = Ticket()
    @State private var HeartFill = false

    var body: some View {
        ScrollView(.vertical) {
            VStack {
                Image("TextImg")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2, alignment: .top)
                    .zIndex(1)

                VStack(alignment: .leading) {
                    HStack {
                        Text(Act_Item.View.Name)
                            .font(Font.custom("GenJyuuGothic-Bold", size: 24))
                            .multilineTextAlignment(.center)
                            .padding(.leading, 12)
                        Spacer()
                    }
                    .padding(.bottom, 5)

                    HStack {
                        Image("Logo")
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                            .frame(width: 45, height: 45)
                            .shadow(color: .gray, radius: 3, x: 1, y: 1)
                            .padding(.leading, 10)
                            .padding(.trailing, 10)

                        Text(Act_Item.View.GroupName)
                            .font(Font.custom("GenJyuuGothic-Regular", size: 18))
                            .multilineTextAlignment(.center)
                    }

                    Divider()

                    HStack {
                        Image("DateIcon")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 30, height: 30)
                            .padding(.leading, 12)
                            .padding(.trailing, 3)

                        Text("\(Act_Item.View.StartTime) ~ \(Act_Item.View.EndTime)")
                            .font(Font.custom("GenJyuuGothic-Regular", size: 16))
                            .foregroundColor(Color.black)
                            .multilineTextAlignment(.leading)
                            .frame(width: UIScreen.main.bounds.width - 100, height: 50)
                    }

                    HStack {
                        Image("LocationIcon")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 30, height: 30)
                            .padding(.leading, 12)
                            .padding(.trailing, 3)

                        Text(Act_Item.View.Location)
                            .font(Font.custom("GenJyuuGothic-Regular", size: 16))
                            .foregroundColor(Color.black)
                            .multilineTextAlignment(.leading)
                            .frame(width: UIScreen.main.bounds.width - 100, height: 50)
                    }

                    Image("TestMap")
                        .resizable()
                        .scaledToFill()

                    Part_Activity_RealTime_VIew(Act_Item: Act_Item)

                    Text("活動簡介")
                        .font(Font.custom("GenJyuuGothic-Medium", size: 24))
                        .multilineTextAlignment(.leading)
                        .padding(.top, 20)
                        .padding(.leading, 5)

                    Text(Act_Item.View.Description)
                        .foregroundColor(Color.black)
                        .frame(width: UIScreen.main.bounds.width - 100, height: 300, alignment: .topLeading)
                        .padding(.top, 15)
                }
                .padding(15)
                .background(Color.white)
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.white, lineWidth: 1)
                )
                .frame(width: UIScreen.main.bounds.width - 15, alignment: .top)
                .zIndex(2)
                .offset(y: -130)
            }
        }
        .onAppear {
            TicketKind.Get_Ticker_By_Act(ActId: Act_Item.View.Id)
        }
    }
}

struct Activity_Info_View_Previews: PreviewProvider {
    static var previews: some View {
        Activity_Info_View(Act_Item: Activity_API().InfoList[0])
    }
}
