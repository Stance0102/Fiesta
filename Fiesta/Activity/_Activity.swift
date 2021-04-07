////
////  _Activity.swift
////  Fiesta
////
////  Created by 李慶毅 on 2020/11/11.
////
//
//import Alamofire
//import Combine
//import Foundation
//import SwiftyJSON
//
//struct Activity_View: Hashable, Identifiable, Decodable { // 視圖
//    var id: String
//    var Name: String
//    var Image: String
////    var GroupImage: String
//    var GroupName: String
//    var Tags: [String]
//    var Location: String
//    var StartTime: String
//    var EndTime: String
//    var Description: String
//}
//
//struct Activity_Data: Hashable, Decodable { // 設定
//    var People_Maxium: String
//    var ViewStatus: String
//    var Latitude: String
//    var Longitude: String
//    var JoinedCount: String
//    var Models: String
//}
//
//struct Activity_All: Hashable, Decodable { // 全部
//    let View: Activity_View
//    let Data: Activity_Data
//}
//
//struct Activity_Decoder: Decodable {
//    var Items = [Activity_All]()
//}
//
//class Activity_API: ObservableObject, Identifiable {
//    // 非同步資料定義
//    @Published var InfoList: [Activity_All]
//    @Published var Act_ID_Array: [String]
//    @Published var Act_Only_Data: Activity_All
//    @Published var Models: [String]
//    @Published var Model_String: String
//    
//    var urlComponents = URLComponents(string: "http://163.18.42.222:8888/Fiestadb/Activity")!
//    
//    private var ActivityCancellable: Cancellable?
//    {
//        didSet { oldValue?.cancel() }
//    }
//    
//    deinit {
//        ActivityCancellable?.cancel()
//    }
//
//    // 初始化
//    init() {
//        InfoList = []
//        Act_ID_Array = []
////        Act_Only_Data = Activity_All(
////            View:
////            Activity_View(
////                id: "",
////                Name: "",
////                Image: "",
////                GroupName: "",
////                Tags: [""],
////                Location: "",
////                StartTime: "",
////                EndTime: "",
////                Description: ""
////            ),
////            Data:
////            Activity_Data(
////                People_Maxium: "",
////                ViewStatus: "",
////                Latitude: "",
////                Longitude: "",
////                JoinedCount: "",
////                Models: ""
////            )
////        )
////        Models = []
////        Model_String = ""
////    }
//
//    // Act_Id: 310
//
//    // 拿取推薦活動
//    func Get_Activity_View() {
//        let json: [String: Any] = [
//            "act_Id": Act_ID_Array,
//        ]
//        urlComponents.path = "/getRecommend"
//        let headers: HTTPHeaders = [
//            "Accept": "application/json",
//        ]
//        
//        var request = URLRequest(url: urlComponents.url!)
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//
//        ActivityCancellable = URLSession.shared.dataTaskPublisher(for: request)
//            .map { $0.data }
//            .decode(type: Activity_Decoder.self, decoder: JSONDecoder())
//            .map { $0.Items }
//            .replaceError(with: [])
//            .receive(on: RunLoop.main)
//            .assign(to: \.InfoList, on: self)
//        
//        AF.request(urlComponents.url!, method: .post, parameters: json, encoding: JSONEncoding.default, headers: headers).responseData { response in
//            switch response.result {
//            case .success:
//                guard let data = response.data else { return }
//                let DataJSON = try? JSON(data: data)
//                let ErrorCode: String = DataJSON!["code"].string!
//                let Result_Count: Int = DataJSON!["result"].count
//
//                if ErrorCode == "001" {
//                    for i in 0 ..< Result_Count {
//                        let Act_ID = DataJSON!["result"][i]["Id"].string!
//                        let Act_Name = DataJSON!["result"][i]["act_Name"].string!
//                        let Act_Image = DataJSON!["result"][i]["Photo"].string!
////                            let GroupImage = DataJSON!["result"][i]["groupPhoto"].string!
//                        let GroupName = DataJSON!["result"][i]["groupName"].string!
//                        let Location = DataJSON!["result"][i]["Location"].string!
//                        let StartTime = DataJSON!["result"][i]["startTime"].string!
//                        let EndTime = DataJSON!["result"][i]["endTime"].string!
//                        let Act_Description = DataJSON!["result"][i]["act_Description"].string!
//                        let ViewStatus = DataJSON!["result"][i]["viewStatus"].string!
//                        let Latitude = DataJSON!["result"][i]["Latitude"].string!
//                        let Longitude = DataJSON!["result"][i]["Longitude"].string!
//                        let Models = DataJSON!["result"][i]["Models"].string!
//                        let PeopleMaxium = DataJSON!["result"][i]["peopleMaxium"].string!
//                        let Joined_Count = DataJSON!["result"][i]["joinedCount"].string!
//                        var Tag: String = ""
//                        var Tags: [String] = []
//                        var ReadTagCount_Tag: Int = 0
//
//                        for ReadTagCount_Tags in 0 ..< DataJSON!["result"][i]["Tag"].count {
//                            Tags.append(DataJSON!["result"][i]["Tag"][ReadTagCount_Tags].string!)
//                        }
//
//                        self.InfoList.append(
//                            Activity_All(
//                                View:
//                                Activity_View(
//                                    id: Act_ID,
//                                    Name: Act_Name,
//                                    Image: Act_Image,
////                                          GroupImage: GroupImage,
//                                    GroupName: GroupName,
//                                    Tags: Tags,
//                                    Location: Location,
//                                    StartTime: StartTime,
//                                    EndTime: EndTime,
//                                    Description: Act_Description
//                                ),
//                                Data:
//                                Activity_Data(
//                                    People_Maxium: PeopleMaxium,
//                                    ViewStatus: ViewStatus,
//                                    Latitude: Latitude,
//                                    Longitude: Longitude,
//                                    JoinedCount: Joined_Count,
//                                    Models: Models
//                                )
//                            )
//                        )
//
//                        self.Act_ID_Array.append(Act_ID)
//                        print(Act_ID)
//                    }
//                    UserDefaults.standard.set(self.Act_ID_Array, forKey: "Act_ID")
//                } else if ErrorCode == "013" {
////                        Ticket_Alert = "此活動僅提供免費票"
//                }
//
//            case let .failure(error):
//                print("Error:\(error)")
//            }
//        }
//    }
//
//    // 建立活動(未發布狀態)
//    func PostCreateAct(GroupId: String, Act_Name: String, StartTime: Date, EndTime: Date, Act_Des: String, PeopleMaxium: String)
//    {
//        let Selected_Tag_String: String = TagName
//        let formatter3 = DateFormatter()
//        formatter3.dateFormat = "y-M-d HH:mm:ss"
//        let StartTime_Str: String = formatter3.string(from: StartTime)
//        let EndTime_Str: String = formatter3.string(from: EndTime)
//        let url = URL(string: "http://163.18.42.222:8888/Fiestadb/Activity/upload")!
//
//        let json: [String: Any] = [
//            "act_Name": String(Act_Name),
//            "groupId": String(GroupId),
//            "Tag": Selected_Tag_String,
//            "act_Description": Act_Des,
//            "startTime": StartTime_Str,
//            "endTime": EndTime_Str,
//            "act_Status": "true",
//            "viewStatus": "false",
//            "peopleMaxium": String(PeopleMaxium),
//            "joinedCount": "0",
//            "Models": Model_String,
//            "Useable": "true",
//        ]
//
//        let headers: HTTPHeaders = [
//            "Accept": "application/json",
//            "Authorization": "Bearer \(UserDefaults.standard.value(forKey: "Token"))",
//        ]
//
//        print(json)
//
//        AF.request(url, method: .post, parameters: json, encoding: JSONEncoding.default, headers: headers).responseData { response in
//            switch response.result {
//            case .success:
//                guard let data = response.data else { return }
//                let DataJSON = try? JSON(data: data)
//                GroupID = DataJSON!["result"][0]["groupId"].string!
//
//            case let .failure(error):
//                print("Error:\(error)")
//            }
//        }
//    }
//
//    // 選擇活動(目前未使用)
//    func Select_Activity(Act_Id: String) {
//        let json: [String: Any] = [
//            "act_Id": Act_Id,
//        ]
//        let url = URL(string: "http://163.18.42.222:8888/Fiestadb/Activity/select")!
//        let headers: HTTPHeaders = [
//            "Accept": "application/json",
//        ]
//
//        AF.request(url, method: .post, parameters: json, encoding: JSONEncoding.default, headers: headers).responseData { response in
//            switch response.result {
//            case .success:
//                guard let data = response.data else { return }
//                let DataJSON = try? JSON(data: data)
//                let ErrorCode: String = DataJSON!["code"].string!
//
//                if ErrorCode == "001" {
//                    let Act_ID = DataJSON!["result"][0]["Id"].string!
//                    let Act_Name = DataJSON!["result"][0]["act_Name"].string!
//                    let Act_Image = DataJSON!["result"][0]["Photo"].string!
////                            let GroupImage = DataJSON!["result"][0]["groupPhoto"].string!
//                    let GroupName = DataJSON!["result"][0]["groupName"].string!
//                    let Location = DataJSON!["result"][0]["Location"].string!
//                    let StartTime = DataJSON!["result"][0]["startTime"].string!
//                    let EndTime = DataJSON!["result"][0]["endTime"].string!
//                    let Act_Description = DataJSON!["result"][0]["act_Description"].string!
//                    let ViewStatus = DataJSON!["result"][0]["viewStatus"].string!
//                    let Latitude = DataJSON!["result"][0]["Latitude"].string!
//                    let Longitude = DataJSON!["result"][0]["Longitude"].string!
//                    let Models = DataJSON!["result"][0]["Models"].string!
//                    let PeopleMaxium = DataJSON!["result"][0]["peopleMaxium"].string!
//                    let Joined_Count = DataJSON!["result"][0]["joinedCount"].string!
//                    var Tag: String = ""
//                    var Tags: [String] = []
//                    var ReadTagCount_Tag: Int = 0
//
//                    for ReadTagCount_Tags in 0 ..< DataJSON!["result"][0]["Tag"].count {
//                        Tags.append(DataJSON!["result"]["Tag"][ReadTagCount_Tags].string!)
//                    }
//
////                    self.Act_Only_Data = Activity_All(
////                        View:
////                        Activity_View(
////                            id: Act_ID,
////                            Name: Act_Name,
////                            Image: Act_Image,
////                            //                            GroupImage: GroupImage,
////                            GroupName: GroupName,
////                            Tags: Tags,
////                            Location: Location,
////                            StartTime: StartTime,
////                            EndTime: EndTime,
////                            Description: Act_Description
////                        ),
////                        Data:
////                        Activity_Data(
////                            People_Maxium: PeopleMaxium,
////                            ViewStatus: ViewStatus,
////                            Latitude: Latitude,
////                            Longitude: Longitude,
////                            JoinedCount: Joined_Count,
////                            Models: Models
////                        )
////                    )
//                } else if ErrorCode == "013" {
////                        Ticket_Alert = "此活動僅提供免費票"
//                }
//
//            case let .failure(error):
//                print("Error:\(error)")
//            }
//        }
//    }
//
//    // 更新活動(需修改，目前未能指定修改類別，一次修改全部。內含發佈活動)
//    func Update_Activity(Act_Id: String, Act_Name: String, Tags: [String], PeopleMaxium: String, Location: String, StartTime: Date, endTime: Date, act_Description: String, Photo: UIImage, Models _: String, viewStatus: String)
//    {
//        let json: [String: Any] = [
//            "Id": Act_Id,
//            "act_Name": Act_Name,
//            "Tag": Tags,
//            "peopleMaxium": PeopleMaxium,
//            "Location": Location,
//            "startTime": StartTime,
//            "endTime": endTime,
//            "act_Description": act_Description,
//            "Photo": Photo,
//            "Models": Model_String,
//            "viewStatus": viewStatus,
//        ]
//        let url = URL(string: "http://163.18.42.222:8888/Fiestadb/Activity/update")!
//        let headers: HTTPHeaders = [
//            "Accept": "application/json",
//        ]
//
//        AF.request(url, method: .post, parameters: json, encoding: JSONEncoding.default, headers: headers).responseData { response in
//            switch response.result {
//            case .success:
//                guard let data = response.data else { return }
//                let DataJSON = try? JSON(data: data)
//                let ErrorCode: String = DataJSON!["code"].string!
//
//                if ErrorCode == "001" {
//                } else if ErrorCode == "013" {
////                        Ticket_Alert = "此活動僅提供免費票"
//                }
//
//            case let .failure(error):
//                print("Error:\(error)")
//            }
//        }
//    }
//
////    func Upload_Act_Image()
////    {
////
////    }
//
//    // 進階活動模組選擇(不包含傳輸)
//    func Models_Add(Model: String) {
//        Models.append(Model)
//        Models_to_String(Models)
//    }
//
//    func Models_Del(Model: String) {
//        for i in 0 ..< Models.count {
//            if Model == Models[i] {
//                Models.remove(at: i)
//                Models_to_String(Models)
//            }
//        }
//    }
//
//    func Models_to_String(_ Models: [String]) {
//        Model_String = ""
//
//        for i in 0 ..< Models.count {
//            if Model_String == "" {
//                Model_String = Models[i]
//            } else {
//                Model_String += ",\(Models[i])"
//            }
//        }
//    }
//}
