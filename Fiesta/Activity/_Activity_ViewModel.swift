//
//  _Activity_ViewModel.swift
//  Fiesta
//
//  Created by Stance Li on 2021/3/17.
//

import Foundation
import Combine
import SwiftyJSON

struct T_Activity_View: Hashable, Identifiable, Decodable { // 視圖
    var id: String
    var Name: String
    var Image: String
//    var GroupImage: String
    var GroupName: String
    var Tags: [String]
    var Location: String
    var StartTime: String
    var EndTime: String
    var Description: String
}

struct T_Activity_Data: Hashable, Decodable { // 設定
    var People_Maxium: String
    var ViewStatus: String
    var Latitude: String
    var Longitude: String
    var JoinedCount: String
    var Models: String
}

struct T_Activity_All: Hashable, Decodable { // 全部
    let View: T_Activity_View
    let Data: T_Activity_Data
}

struct T_Activity_Decoder: Decodable {
    var Info: [T_Activity_All]
}

class T_Activity_API: ObservableObject, Identifiable {
    // 非同步資料定義
    @Published var T_InfoList = [T_Activity_All]()
    @Published var T_Act_ID_Array: [String]
    @Published var T_Act_Only_Data: T_Activity_All
    @Published var T_Models: [String]
    @Published var T_Model_String: String
    
    var T_urlComponents = URLComponents(string: "http://163.18.42.222:8888/Fiestadb/Activity")!
    
    private var T_ActivityCancellable: Cancellable?
    {
        didSet { oldValue?.cancel() }
    }
    
    deinit {
        T_ActivityCancellable?.cancel()
    }

    // 初始化
    init() {
        T_Act_ID_Array = []
        T_Act_Only_Data = T_Activity_All(
            View:
                T_Activity_View(
                    id: "",
                    Name: "",
                    Image: "",
                    GroupName: "",
                    Tags: [""],
                    Location: "",
                    StartTime: "",
                    EndTime: "",
                    Description: ""
                )
            ,
            Data:
                T_Activity_Data(
                    People_Maxium: "",
                    ViewStatus: "",
                    Latitude: "",
                    Longitude: "",
                    JoinedCount: "",
                    Models: ""
                )
        )
        T_Models = []
        T_Model_String = ""
    }

    // Act_Id: 310

    // 拿取推薦活動
    func T_Get_Activity_View() {
        let json: [String: Any] = [
            "act_Id": T_Act_ID_Array,
        ]
        T_urlComponents.path = "/getRecommend"
        
        var request = URLRequest(url: T_urlComponents.url!)
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        T_ActivityCancellable = URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: T_Activity_Decoder.self, decoder: JSONDecoder())
            .map { $0.Info }
            .replaceError(with: [])
            .receive(on: RunLoop.main)
            .assign(to: \.T_InfoList, on: self)
        
        print(T_InfoList)
    }
}
