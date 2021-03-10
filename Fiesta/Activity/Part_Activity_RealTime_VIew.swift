//
//  Part_Activity_RealTime_VIew.swift
//  Fiesta
//
//  Created by Stance Li on 2021/3/9.
//

import SwiftUI

struct Part_Activity_RealTime_VIew: View {
    var Act_Item: Activity_All

    var body: some View {
        HStack {
            Text("活動即時資訊")
                .font(Font.custom("GenJyuuGothic-Medium", size: 24))
                // .multilineTextAlignment(.leading)
                .padding(.top, 20)
                .padding(.leading, 5)

            Spacer()

            Text("第一天(\(Act_Item.View.StartTime))")
                .font(Font.custom("GenJyuuGothic-Regular", size: 18))
        }
    }
}

struct Part_Activity_RealTime_VIew_Previews: PreviewProvider {
    static var previews: some View {
        Part_Activity_RealTime_VIew(Act_Item: Activity_API().InfoList[0])
    }
}
