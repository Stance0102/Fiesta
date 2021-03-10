//
//  _Group.swift
//  Fiesta
//
//  Created by 李慶毅 on 2020/11/17.
//

import Alamofire
import Combine
import Foundation
import SwiftyJSON

struct Group_Struct: Hashable {
    let Id: String
    let Name: String
//    let Tag: String
//    let Address: String
//    let Mail: String
//    let Phone: String
    let Photo: String
    let TimeStatus: String
//    let DeadLine: String
}

struct Group_Member: Hashable {
    let NickName: String
    let Authority: String
    let AuthId: String
    let Photo: String
}

struct Group_Activity: Hashable {
    let Act_Id: String
    let Act_Name: String
}

var GroupID: String = ""

class Group_API: ObservableObject, Identifiable {
    @Published var GroupList: [Group_Struct]
    @Published var GroupMembers: [Group_Member]
    @Published var GroupActList: [Group_Activity]

    init() {
        GroupList = []
        GroupMembers = []
        GroupActList = []
    }

    func Get_Joined_Group() {
        let url = URL(string: "http://163.18.42.222:8888/Fiestadb/Account/getJoinedGroup")!
        let json: [String: Any] = [
            "authId": UserDefaults.standard.value(forKey: "AuthID")!,
        ]
        let header: HTTPHeaders = [
            "Accept": "application/json",
            "Authorization": "Bearer \(UserDefaults.standard.value(forKey: "Token"))",
        ]
        var ErrorCode: String = ""
        var GroupCount: Int?

        print("Bearer \(String(describing: UserDefaults.standard.value(forKey: "Token")!).utf8)")

        AF.request(url, method: .post, parameters: json, encoding: JSONEncoding.default, headers: header).responseData { response in
            switch response.result {
            case .success:
                guard let data = response.data else { return }
                let DataJSON = try? JSON(data: data)
                debugPrint(DataJSON!["result"])
                ErrorCode = DataJSON!["code"].string!
                GroupCount = DataJSON!["result"].count

                if ErrorCode == "001" {
                    for i in 0 ..< GroupCount! {
                        let GroupId = DataJSON!["result"][i]["groupId"].string!
                        let GroupName = DataJSON!["result"][i]["groupName"].string!
                        let GroupPhoto = DataJSON!["result"][i]["Photo"].string!
                        let TimeStatus = DataJSON!["result"][i]["timeStatus"].string!

                        self.GroupList.append(
                            Group_Struct(
                                Id: GroupId,
                                Name: GroupName,
                                Photo: GroupPhoto,
                                TimeStatus: TimeStatus
                            )
                        )
                    }
                } else {
                    debugPrint("GroupList: \(DataJSON)")
                }
            case let .failure(error):
                print(error)
            }
        }
    }

    func PostCreateGroup(GroupName: String, Address _: String?, Mail: String, PhoneNumber _: String?, Photo _: String? = nil, DeadLine _: Date, TimeStatus _: Bool)
    {
        let today = Date()
        let formatter3 = DateFormatter()

        formatter3.dateFormat = "y-M-d HH:mm:ss"

        let url = URL(string: "http://163.18.42.222:8888/Fiestadb/Group/upload")!
        let json: [String: Any] = [
            "authId": [UserDefaults.standard.value(forKey: "AuthID")],
            "groupName": String(GroupName),
            // "Address": String(Address!),
            "Mail": String(Mail),
            // "Phone": String(PhoneNumber!),
            // "Photo": Photo,
            // "timeStatus": String(TimeStatus),
            "deadLine": String(formatter3.string(from: today)),
            "Useable": "true",
        ]

        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Authorization": "Bearer \(String(describing: UserDefaults.standard.value(forKey: "Token")!).utf8)",
        ]

        AF.request(url, method: .post, parameters: json, encoding: JSONEncoding.default, headers: headers).responseData { response in
            switch response.result {
            case .success:
                guard let data = response.data else { return }
                let DataJSON = try? JSON(data: data)
                debugPrint(DataJSON!)
                GroupID = DataJSON!["result"][0]["groupId"].string!
            case let .failure(error):
                print("Error:\(error)")
            }
        }
    }

    func Search_Account(_ UserId: String) {
        let url = URL(string: "http://163.18.42.222:8888/Fiestadb/Account/Search")!
        let json: [String: Any] = [
            "Search": UserId,
        ]
        let header: HTTPHeaders = [
            "Accept": "application/json",
            "Authorization": "Bearer \(UserDefaults.standard.value(forKey: "Token"))",
        ]
        var ErrorCode: String = ""
        var GroupCount: Int?

        print("Bearer \(String(describing: UserDefaults.standard.value(forKey: "Token")!).utf8)")

        AF.request(url, method: .post, parameters: json, encoding: JSONEncoding.default, headers: header).responseData { response in
            switch response.result {
            case .success:
                guard let data = response.data else { return }
                let DataJSON = try? JSON(data: data)
                debugPrint(DataJSON!["result"])
                ErrorCode = DataJSON!["code"].string!
                GroupCount = DataJSON!["result"].count

                if ErrorCode == "001" {
//                        Unready Method
                } else {
                    debugPrint("GroupList: \(DataJSON)")
                }
            case let .failure(error):
                print(error)
            }
        }
    }

    func Update_Group_Info(GroupId: String, GroupName _: String, Address: String?, Mail: String, PhoneNumber: String?, Photo: String? = nil, DeadLine _: Date, TimeStatus _: Bool)
    {
        let url = URL(string: "http://163.18.42.222:8888/Fiestadb/Group/update")!
        let json: [String: Any] = [
            "groupId": GroupId,
            "Address": String(Address!),
            "Mail": String(Mail),
            "Phone": String(PhoneNumber!),
            "Photo": Photo!,
        ]

        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Authorization": "Bearer \(String(describing: UserDefaults.standard.value(forKey: "Token")!).utf8)",
        ]

        AF.request(url, method: .post, parameters: json, encoding: JSONEncoding.default, headers: headers).responseData { response in
            switch response.result {
            case .success:
                guard let data = response.data else { return }
                let DataJSON = try? JSON(data: data)
                debugPrint(DataJSON!)
            case let .failure(error):
                print("Error:\(error)")
            }
        }
    }

    func Get_Member_Select(GroupId: String) {
        let url = URL(string: "http://163.18.42.222:8888/Fiestadb/Group/Member/select")!
        let json: [String: Any] = [
            "groupId": GroupId,
        ]
        let header: HTTPHeaders = [
            "Accept": "application/json",
            "Authorization": "Bearer \(UserDefaults.standard.value(forKey: "Token"))",
        ]
        var ErrorCode: String = ""

        AF.request(url, method: .post, parameters: json, encoding: JSONEncoding.default, headers: header).responseData { response in
            switch response.result {
            case .success:
                guard let data = response.data else { return }
                let DataJSON = try? JSON(data: data)
                debugPrint(DataJSON!["result"])
                ErrorCode = DataJSON!["code"].string!

                if ErrorCode == "001" {
                    for i in 0 ..< DataJSON!["result"].count {
                        let NickName = DataJSON!["result"][i]["nickName"].string!
                        let AuthId = DataJSON!["result"][i]["authId"].string!
                        let Photo = DataJSON!["result"][i]["Photo"].string!
                        let Ahthority = DataJSON!["result"][i]["Authority"].string!

                        self.GroupMembers.append(
                            Group_Member(
                                NickName: NickName,
                                Authority: Ahthority,
                                AuthId: AuthId,
                                Photo: Photo
                            )
                        )
                    }
                } else {
                    debugPrint("GroupList: \(DataJSON)")
                }
            case let .failure(error):
                print(error)
            }
        }
    }

    func Add_Group_Member(GroupId: String, AuthId: String, Authority: String) {
        let url = URL(string: "http://163.18.42.222:8888/Fiestadb/Group/Member/upload")!
        let json: [String: Any] = [
            "groupId": GroupId,
            "authId": AuthId,
            "Authority": Authority,
        ]
        let header: HTTPHeaders = [
            "Accept": "application/json",
            "Authorization": "Bearer \(UserDefaults.standard.value(forKey: "Token"))",
        ]
        var ErrorCode: String = ""

        AF.request(url, method: .post, parameters: json, encoding: JSONEncoding.default, headers: header).responseData { response in
            switch response.result {
            case .success:
                guard let data = response.data else { return }
                let DataJSON = try? JSON(data: data)
                debugPrint(DataJSON!["result"])
                ErrorCode = DataJSON!["code"].string!

                if ErrorCode == "001" {
                } else {
                    debugPrint("GroupList: \(DataJSON)")
                }
            case let .failure(error):
                print(error)
            }
        }
    }

    func Update_GroupMember_Authority(GroupId: String, AuthId: String, Authority: String) {
        let url = URL(string: "http://163.18.42.222:8888/Fiestadb/Group/Member/update")!
        let json: [String: Any] = [
            "groupId": GroupId,
            "authId": AuthId,
            "Authority": Authority,
        ]
        let header: HTTPHeaders = [
            "Accept": "application/json",
            "Authorization": "Bearer \(UserDefaults.standard.value(forKey: "Token"))",
        ]
        var ErrorCode: String = ""

        AF.request(url, method: .post, parameters: json, encoding: JSONEncoding.default, headers: header).responseData { response in
            switch response.result {
            case .success:
                guard let data = response.data else { return }
                let DataJSON = try? JSON(data: data)
                debugPrint(DataJSON!["result"])
                ErrorCode = DataJSON!["code"].string!

                if ErrorCode == "001" {
                } else {
                    debugPrint("GroupList: \(DataJSON)")
                }
            case let .failure(error):
                print(error)
            }
        }
    }

    func Delect_Group_Member(GroupId: String, AuthId: String) {
        let url = URL(string: "http://163.18.42.222:8888/Fiestadb/Group/Member/delete")!
        let json: [String: Any] = [
            "groupId": GroupId,
            "authId": AuthId,
        ]
        let header: HTTPHeaders = [
            "Accept": "application/json",
            "Authorization": "Bearer \(UserDefaults.standard.value(forKey: "Token"))",
        ]
        var ErrorCode: String = ""

        AF.request(url, method: .post, parameters: json, encoding: JSONEncoding.default, headers: header).responseData { response in
            switch response.result {
            case .success:
                guard let data = response.data else { return }
                let DataJSON = try? JSON(data: data)
                debugPrint(DataJSON!["result"])
                ErrorCode = DataJSON!["code"].string!

                if ErrorCode == "001" {
                } else {
                    debugPrint("GroupList: \(DataJSON)")
                }
            case let .failure(error):
                print(error)
            }
        }
    }

    func Find_Group_Name(GroupName: String) {
        let url = URL(string: "http://163.18.42.222:8888/Fiestadb/Group/FindName")!
        let json: [String: Any] = [
            "groupName": GroupName,
        ]
        let header: HTTPHeaders = [
            "Accept": "application/json",
            "Authorization": "Bearer \(UserDefaults.standard.value(forKey: "Token"))",
        ]
        var ErrorCode: String = ""

        AF.request(url, method: .post, parameters: json, encoding: JSONEncoding.default, headers: header).responseData { response in
            switch response.result {
            case .success:
                guard let data = response.data else { return }
                let DataJSON = try? JSON(data: data)
                debugPrint(DataJSON!["result"])
                ErrorCode = DataJSON!["code"].string!

                if ErrorCode == "005" {
                } else {
                    debugPrint("GroupList: \(DataJSON)")
                }
            case let .failure(error):
                print(error)
            }
        }
    }

    func Search_Group_Act(GroupId: String) {
        let url = URL(string: "http://163.18.42.222:8888/Fiestadb/Group/getAct")!
        let json: [String: Any] = [
            "groupId": GroupId,
        ]
        let header: HTTPHeaders = [
            "Accept": "application/json",
            "Authorization": "Bearer \(UserDefaults.standard.value(forKey: "Token"))",
        ]
        var ErrorCode: String = ""

        AF.request(url, method: .post, parameters: json, encoding: JSONEncoding.default, headers: header).responseData { response in
            switch response.result {
            case .success:
                guard let data = response.data else { return }
                let DataJSON = try? JSON(data: data)
                debugPrint(DataJSON!["result"])
                ErrorCode = DataJSON!["code"].string!

                if ErrorCode == "001" {
                    for i in 0 ..< DataJSON!["result"].count {
                        let Act_Id = DataJSON!["result"][i]["Id"].string!
                        let Act_Name = DataJSON!["result"][i]["act_Name"].string!

                        self.GroupActList.append(
                            Group_Activity(
                                Act_Id: Act_Id,
                                Act_Name: Act_Name
                            )
                        )
                    }
                } else {
                    debugPrint("GroupList: \(DataJSON)")
                }
            case let .failure(error):
                print(error)
            }
        }
    }

//    func Upload_Group_Image()
//    {
//
//    }
}
