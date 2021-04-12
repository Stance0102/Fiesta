//
//  Activity_Info_View.swift
//  Fiesta
//
//  Created by Stance Li on 2020/11/12.
//

import SwiftUI
import URLImage

struct Activity_Info_View: View {
    @ObservedObject private var TicketKind = Ticket()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @GestureState private var dragOffset = CGSize.zero
    @State private var HeartFill = false
    private let act_ViewModel: Activity_ViewModel
    
    init(act_ViewModel: Activity_ViewModel) {
        self.act_ViewModel = act_ViewModel
    }

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            GeometryReader { reader in
                if reader.frame(in: .global).minY > -480 {
                    if let image = act_ViewModel.Image_Link,
                       let url = URL(string: image)
                    {
                        URLImage(url: url,
                                 options: URLImageOptions(
                                    identifier: act_ViewModel.Id,
                                    expireAfter: 600.0,
                                    cachePolicy: .returnCacheElseLoad(cacheDelay: nil, downloadDelay: 0.25)
                                 ),
                                 failure: { error, retry in
                                    Image(systemName: "photo.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .offset(y: -reader.frame(in: .global).minY)
                                        .frame(width: UIScreen.main.bounds.width, height:
                                                reader.frame(in: .global).minY > 0 ?
                                               reader.frame(in: .global).minY + 480 : 480)
                                 },
                                 content: { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .offset(y: -reader.frame(in: .global).minY)
                                        .frame(width: UIScreen.main.bounds.width, height:
                                                reader.frame(in: .global).minY > 0 ?
                                               reader.frame(in: .global).minY + 480 : 480)
                                 })
                    }else{
                        Image(systemName: "photo.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .offset(y: -reader.frame(in: .global).minY)
                            .frame(width: UIScreen.main.bounds.width, height:
                                    reader.frame(in: .global).minY > 0 ?
                                   reader.frame(in: .global).minY + 480 : 480)
                    }
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
                .padding(.horizontal, 16)
                .padding(.bottom, 5)

                HStack {
                    if let image = act_ViewModel.GroupImage,
                       let url = URL(string: image)
                    {
                        URLImage(url: url,
                                 options: URLImageOptions(
                                    identifier: act_ViewModel.Id,
                                    expireAfter: 600.0,
                                    cachePolicy: .returnCacheElseLoad(cacheDelay: nil, downloadDelay: 0.25)
                                 ),
                                 failure: { error, retry in
                                    Image(systemName: "photo.fill")
                                        .resizable()
                                        .scaledToFill()
                                        .clipShape(Circle())
                                        .frame(width: 45, height: 45)
                                        .shadow(color: .gray, radius: 3, x: 1, y: 1)
                                 },
                                 content: { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .clipShape(Circle())
                                        .frame(width: 45, height: 45)
                                        .shadow(color: .gray, radius: 3, x: 1, y: 1)
                                 })
                    }else{
                        Image(systemName: "photo.fill")
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                            .frame(width: 45, height: 45)
                            .shadow(color: .gray, radius: 3, x: 1, y: 1)
                    }   

                    Text(act_ViewModel.GroupName)
                        .font(Font.custom("GenJyuuGothic-Regular", size: 18))
                        .multilineTextAlignment(.center)
                        .padding(.leading, 5)
                }
                .padding(.horizontal, 14)

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
                .padding(.horizontal, 20)

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
                .padding(.horizontal, 20)

                Image("TestMap")
                    .resizable()
                    .scaledToFill()
                
                Divider()
                    .padding(.top, 30)
                
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
                
                Divider()
                    .padding(.bottom, 30)
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
        .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
            if(value.startLocation.x < 100 && value.translation.width > 100) {
                self.presentationMode.wrappedValue.dismiss()
            }
        }))
        .navigationBarTitle(act_ViewModel.Name)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(true)
    }
}
