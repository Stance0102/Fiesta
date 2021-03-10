//
//  #Activity_RealTime_View.swift
//  Fiesta
//
//  Created by Stance Li on 2021/3/9.
//

import SwiftUI

struct _Activity_RealTime_Show: View {
    HStack {
        Text("活動即時資訊")
            .font(Font.custom("GenJyuuGothic-Medium", size: 24))
            .multilineTextAlignment(.leading)

        Spacer()

        Text("第一天(\(Act_Item.View.StartTime))")
            .font(Font.custom("GenJyuuGothic-Regular", size: 16))
            .multilineTextAlignment(.trailing)
    }
    .padding([.leading, .trailing], 5)
}

struct _Activity_RealTime_Show_Previews: PreviewProvider {
    static var previews: some View {
        _Activity_RealTime_Show()
    }
}
