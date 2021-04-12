//
//  Activity_Block.swift
//  Fiesta
//
//  Created by Stance Li on 2021/3/31.
//

import SwiftUI
import URLImage

struct Activity_Block: View {
    private let viewModel: Activity_ViewModel
    
    init(viewModel: Activity_ViewModel) {
        self.viewModel = viewModel
        URLImageService.shared.cleanup()
    }
    
    var body: some View {
        NavigationLink(destination: Activity_Info_View.init(act_ViewModel: viewModel))
        {
            HStack {
                Spacer()
                ZStack(alignment: .center) {
                    VStack(alignment: .center) {
                        HStack {
                            Spacer()
                            VStack(alignment: .center) {
                                VStack(alignment: .leading) {
                                    HStack {
                                        
                                        if let image = viewModel.GroupImage,
                                           let url = URL(string: image)
                                        {
                                            URLImage(url: url,
                                                     options: URLImageOptions(
                                                        identifier: viewModel.Id,
                                                        expireAfter: 600.0,
                                                        cachePolicy: .returnCacheElseLoad(cacheDelay: nil, downloadDelay: 0.25)
                                                     ),
                                                     failure: { error, retry in
                                                        Image(systemName: "photo.fill")
                                                            .resizable()
                                                            .scaledToFill()
                                                            .clipShape(Circle())
                                                            .frame(width: 45, height: 45)
                                                            .shadow(color: Color.gray.opacity(0.5), radius: 3, x: 1, y: 1)
                                                            .padding(.leading, 20)
                                                            .padding(.trailing, 5)
                                                     },
                                                     content: { image in
                                                        image
                                                            .resizable()
                                                            .scaledToFill()
                                                            .clipShape(Circle())
                                                            .frame(width: 45, height: 45)
                                                            .shadow(color: Color.gray.opacity(0.5), radius: 3, x: 1, y: 1)
                                                            .padding(.leading, 20)
                                                            .padding(.trailing, 5)
                                                     })
                                        }else{
                                            Image(systemName: "photo.fill")
                                                .resizable()
                                                .scaledToFill()
                                                .clipShape(Circle())
                                                .frame(width: 45, height: 45)
                                                .shadow(color: Color.gray.opacity(0.5), radius: 3, x: 1, y: 1)
                                                .padding(.leading, 20)
                                                .padding(.trailing, 5)
                                        }

                                        VStack(alignment: .leading) {
                                            Text(viewModel.GroupName)
                                                .font(Font.custom("GenJyuuGothic-Heavy" ,size: 13))
                                                .foregroundColor(.black)
                                                .multilineTextAlignment(.center)

                                            Text(viewModel.Location)
                                                .font(Font.custom("GenJyuuGothic-Regular" ,size: 10))
                                                .foregroundColor(Color.gray)
                                                .multilineTextAlignment(.center)
                                        }
                                        Spacer()
                                    }
                                }
                                
                                if let image = viewModel.Image_Link,
                                   let url = URL(string: image)
                                {
                                    URLImage(url: url,
                                             options: URLImageOptions(
                                                identifier: viewModel.Id,
                                                expireAfter: 600.0,
                                                cachePolicy: .returnCacheElseLoad(cacheDelay: nil, downloadDelay: 0.25)
                                             ),
                                             failure: { error, retry in
                                                Image(systemName: "photo.fill")
                                                    .renderingMode(.original)
                                                    .foregroundColor(.white)
                                                    .background(Color.gray)
                                                    .cornerRadius(15)
                                                    .padding(.horizontal, 20)
                                             },
                                             content: { image in
                                                image
                                                    .resizable()
                                                    .renderingMode(.original)
                                                    .aspectRatio(contentMode: .fit)
                                                    .cornerRadius(15)
                                                    .padding(.horizontal, 20)
                                             })
                                }else{
                                    Image(systemName: "photo.fill")
                                        .renderingMode(.original)
                                        .foregroundColor(.white)
                                        .background(Color.gray)
                                        .cornerRadius(15)
                                        .padding(.horizontal, 20)
                                }

                                VStack(alignment: .leading) {
                                    HStack {
                                        VStack(alignment: .leading, spacing: 0) {
                                            HStack {
                                                ForEach(0 ..< viewModel.Tags.count, id: \.self) { tag in
                                                    Text("#\(viewModel.Tags[tag])")
                                                        .font(Font.custom("GenJyuuGothic-Regular" ,size: 11))
                                                        .foregroundColor(Color.gray)
                                                        .multilineTextAlignment(.leading)
                                                }
                                            }

                                            Text(viewModel.Name)
                                                .font(Font.custom("GenJyuuGothic-Heavy" ,size: 17))
                                                .foregroundColor(.black)
                                                .multilineTextAlignment(.center)

                                            Text(viewModel.StartTime_All)
                                                .font(Font.custom("GenJyuuGothic-Regular" ,size: 14))
                                                .foregroundColor(Color.gray)
                                                .multilineTextAlignment(.trailing)
                                        }
                                        Spacer()
                                    }
                                    .padding(.horizontal, 25)
                                    .padding(.top, 30)
                                    .padding(.bottom, 12)
                                }
                                .frame(height: 45)

                                Spacer()
                            }
                            .padding(.vertical, 20)
                            .background(Color.white)
                            .cornerRadius(30)
                            .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 1.5, y: 1.5)
                            .shadow(color: Color.white.opacity(0.6), radius: 3, x: -1.5, y: -1.5)
                            
                            Spacer()
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 15)
                }
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .listRowInsets(EdgeInsets())
        }
    }
}
