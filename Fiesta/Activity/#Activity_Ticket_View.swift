//
//  #Activity_Ticket_View.swift
//  Fiesta
//
//  Created by Stance Li on 2021/3/9.
//

import SwiftUI

struct _Activity_Ticket_View: View {
    var Act_Item: Activity_All
    @ObservedObject private var TicketKind = Ticket()
    @State private var HeartFill = false

    var body: some View {
        VStack {
            HStack {
                ForEach(self.TicketKind.Ticket_Array, id: \.TicketKinds) { ticket in
                    Text(ticket.TicketKinds)
                        .font(Font.system(size: 18))
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.leading)

                    Text("NT. \(ticket.Price)")
                        .font(Font.system(size: 16))
                        .foregroundColor(Color.gray)
                        .multilineTextAlignment(.leading)

                    Text("總共:\(ticket.Mounts)張")
                        .font(Font.system(size: 18))
                        .foregroundColor(Color.gray)
                        .multilineTextAlignment(.leading)
                        .padding(.top, 1)

                    Button(action: {
                        TicketKind.Post_BuyTicket(Act_Id: ticket.Act_Id, TicketKinds: ticket.TicketKinds)
                    }) {
                        Text("買票")
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
                    .buttonStyle(PlainButtonStyle())
                    .padding(.leading, 40)
                    .padding(.trailing, 15)
                }
            }
        }
        .padding(.bottom, 100)
    }
}

struct _Activity_Ticket_View_Previews: PreviewProvider {
    static var previews: some View {
        _Activity_Ticket_View(Act_Item: Activity_API().InfoList[0])
    }
}
