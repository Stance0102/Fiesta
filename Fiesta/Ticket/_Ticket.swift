//
//  _Ticket.swift
//  Fiesta
//
//  Created by 李慶毅 on 2020/11/12.
//

import Alamofire
import Combine
import Foundation
import SwiftyJSON

struct Ticket_Kinds: Hashable {
    let Id: String
    let Mounts: String
    let Price: String
    let Remainder: String
    let Useable: String
    let Act_Id: String
    let TicketKinds: String
}

struct Unexpired_Activity: Hashable {
    let Act_Id: String
    let Act_Name: String
    let Act_Description: String
    let Photo: String
    let StartTime: String
    let TicketKinds: String
    let TicketStatus: String
    let Location: String
    let GroupId: String
}

struct Input_to_API: Encodable {
    let Auth_Id: String
    let Act_Id: String
}

//    Ticket_Id: 196 # Delete
var Ticket_Alert: String = "購票前，請務必確認票種！"

class Ticket: ObservableObject, Identifiable {
    @Published var Ticket_Array: [Ticket_Kinds]
    @Published var MyTicket_Array: [Unexpired_Activity]
    @Published var TicketStatus: String
    @Published var QRcodeImg: UIImage

    init() {
        Ticket_Array = []
        MyTicket_Array = []
        TicketStatus = ""
        QRcodeImg = UIImage()
    }

    func Get_Ticker_By_Act(ActId: String) {
        let url = URL(string: "http://163.18.42.222:8888/Fiestadb/Ticket/SelectByAct")!
        let json: [String: Any] = [
            "act_Id": ActId,
        ]

        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Authorization": "Bearer \(UserDefaults.standard.value(forKey: "Token"))",
        ]

        AF.request(url, method: .post, parameters: json, encoding: JSONEncoding.default, headers: headers).responseData { response in
            switch response.result {
            case .success:
                guard let data = response.data else { return }
                let DataJSON = try? JSON(data: data)
                let ErrorCode: String = DataJSON!["code"].string!
                let Result_Count: Int = DataJSON!["result"].count
                self.Ticket_Array.removeAll()

                if ErrorCode == "001" {
                    for i in 0 ..< Result_Count {
                        let Id = DataJSON!["result"][i]["Id"].string!
                        let Mounts = DataJSON!["result"][i]["Mounts"].string!
                        let Price = DataJSON!["result"][i]["Price"].string!
                        let Remainder = DataJSON!["result"][i]["Remainder"].string!
                        let Useable = DataJSON!["result"][i]["Useable"].string!
                        let Act_Id = DataJSON!["result"][i]["act_Id"].string!
                        let TicketKind = DataJSON!["result"][i]["ticketKinds"].string!

                        self.Ticket_Array.append(Ticket_Kinds(Id: Id, Mounts: Mounts, Price: Price, Remainder: Remainder, Useable: Useable, Act_Id: Act_Id, TicketKinds: TicketKind))
                    }
                } else if ErrorCode == "013" {
                    Ticket_Alert = "此活動僅提供免費票"
                }
            case let .failure(error):
                print("Error:\(error)")
            }
        }
    }

    func Post_BuyTicket(Act_Id: String, TicketKinds: String? = nil, Notes: String = "") {
        let url = URL(string: "http://163.18.42.222:8888/Fiestadb/Activity/setJoinedList")!
        var json: [String: Any] = [
            "authId": "\(String(describing: UserDefaults.standard.value(forKey: "AuthID")!))",
            "act_Id": Act_Id,
            "Notes": Notes,
        ]

        if TicketKinds != nil {
            json["ticketKinds"] = TicketKinds
        }

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
                let ErrorCode: String = DataJSON!["code"].string!

                if ErrorCode == "001" {
                    //
                } else if ErrorCode == "013" {
                    Ticket_Alert = "此活動僅提供免費票"
                }
            case let .failure(error):
                print("Error:\(error)")
            }
        }
    }

    // 下面這個Func要改
    func Get_MyTicker_Info() {
        let url = URL(string: "http://163.18.42.222:8888/Fiestadb/Account/getUnexpiredAct")!
        let json: [String: Any] = [
            "authId": "\(UserDefaults.standard.value(forKey: "AuthID")!)",
        ]

        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Authorization": "Bearer \(String(describing: UserDefaults.standard.value(forKey: "Token")!).utf8)",
        ]

        print(json)

        AF.request(url, method: .post, parameters: json, encoding: JSONEncoding.default, headers: headers).responseData { response in
            switch response.result {
            case .success:
                guard let data = response.data else { return }
                let DataJSON = try? JSON(data: data)
                debugPrint(DataJSON!)
                let ErrorCode: String = DataJSON!["code"].string!
                let Result_Count: Int = DataJSON!["result"].count

                if ErrorCode == "001" {
                    for i in 0 ..< Result_Count {
                        let Act_Id = DataJSON!["result"][i]["act_Id"].string!
                        let Act_Name = DataJSON!["result"][i]["act_Name"].string!
                        let Act_Description = DataJSON!["result"][i]["act_Description"].string!
                        let Photo = DataJSON!["result"][i]["Photo"].string!
                        let StartTime = DataJSON!["result"][i]["startTime"].string!
                        let TicketKinds = DataJSON!["result"][i]["ticketKinds"].string!
                        let TicketStatusCode = DataJSON!["result"][i]["ticketStatus"].string!
                        let Location = DataJSON!["result"][i]["Location"].string!
                        let GroupId = DataJSON!["result"][i]["groupId"].string!

                        if TicketStatusCode == "0" {
                            self.TicketStatus = "未使用"
                        } else {
                            self.TicketStatus = "已使用"
                        }

                        self.MyTicket_Array.append(
                            Unexpired_Activity(
                                Act_Id: Act_Id,
                                Act_Name: Act_Name,
                                Act_Description: Act_Description,
                                Photo: Photo,
                                StartTime: StartTime,
                                TicketKinds: TicketKinds,
                                TicketStatus: self.TicketStatus,
                                Location: Location,
                                GroupId: GroupId
                            )
                        )
                    }
                } else if ErrorCode == "013" {
                    Ticket_Alert = "無活動"
                }
            case let .failure(error):
                print("Error:\(error)")
            }
        }
    }

    func Upload_Ticket(Ticket_Kinds: String, Act_Id: String, Mounts: String, Price: String) {
        let url = URL(string: "http://163.18.42.222:8888/Fiestadb/Ticket/upload")!
        var json: [String: Any] = [
            "ticketKinds": Ticket_Kinds,
            "act_Id": Act_Id,
            "Mounts": Mounts,
            "Remainder": Mounts,
            "Price": Price,
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
                let ErrorCode: String = DataJSON!["code"].string!

                if ErrorCode == "001" {
                    //
                } else if ErrorCode == "013" {
                    Ticket_Alert = "此活動僅提供免費票"
                }
            case let .failure(error):
                print("Error:\(error)")
            }
        }
    }

    func Ticket_To_QRcode(_ Act_Id: String) {
        let url = URL(string: "http://163.18.42.222:8888/Fiestadb/QRcode")!
        let Encoder = JSONEncoder()
        var Input_Data = Input_to_API(
            Auth_Id: "\(UserDefaults.standard.value(forKey: "AuthID")!)",
            Act_Id: Act_Id
        )
        var Sec_Json = try? Encoder.encode(Input_Data)
        var json: [String: Any] = [
            "Input": Sec_Json,
        ]
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Authorization": "Bearer \(String(describing: UserDefaults.standard.value(forKey: "Token")!).utf8)",
        ]

        AF.request(url, method: .post, parameters: json, encoding: JSONEncoding.default, headers: headers).responseData { response in
            switch response.result {
            case .success:
                guard let data = response.data else { return }

                let QRcodeData = Data(base64Encoded: data)
                self.QRcodeImg = UIImage(data: QRcodeData!)!

            case let .failure(error):
                print("Error:\(error)")
            }
        }
    }

    func Get_Ticket_Info(_ Ticket_Id: String) {
        let url = URL(string: "http://163.18.42.222:8888/Fiestadb/Ticket/Select")!
        var json: [String: Any] = [
            "authId": "\(String(describing: UserDefaults.standard.value(forKey: "AuthID")!))",
            "ticketId": Ticket_Id,
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
                let ErrorCode: String = DataJSON!["code"].string!

                if ErrorCode == "001" {
                    //
                } else if ErrorCode == "013" {
                    Ticket_Alert = "此活動僅提供免費票"
                }
            case let .failure(error):
                print("Error:\(error)")
            }
        }
    }

    func Update_Ticket(_ Ticket_Id: String, Ticket_Kind: String, Mounts: String, Price: String) {
        let url = URL(string: "http://163.18.42.222:8888/Fiestadb/Ticket/update")!
        var json: [String: Any] = [
            "ticketId": Ticket_Id,
            "ticketKinds": Ticket_Kind,
            "Mounts": Mounts,
            "Price": Price,
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
                let ErrorCode: String = DataJSON!["code"].string!

                if ErrorCode == "001" {
                    //
                } else if ErrorCode == "013" {
                    Ticket_Alert = "此活動僅提供免費票"
                }
            case let .failure(error):
                print("Error:\(error)")
            }
        }
    }

    func Delect_Ticket(_ Ticket_Id: String) {
        let url = URL(string: "http://163.18.42.222:8888/Fiestadb/Ticket/delete")!
        var json: [String: Any] = [
            "ticketId": Ticket_Id,
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
                let ErrorCode: String = DataJSON!["code"].string!

                if ErrorCode == "001" {
                    //
                } else if ErrorCode == "013" {
                    Ticket_Alert = "此活動僅提供免費票"
                }
            case let .failure(error):
                print("Error:\(error)")
            }
        }
    }

//    func Vaild_Ticket()
//    {
//
//    }

//    func Vaild_Ticket_QRcode()
//    {
//
//    }

    func Update_Ticket_Note(Act_Id: String, Notes: String) {
        let url = URL(string: "http://163.18.42.222:8888/Fiestadb/Ticket/updateTicketNotes")!
        var json: [String: Any] = [
            "act_Id": Act_Id,
            "auth_Id": "\(UserDefaults.standard.value(forKey: "AuthId"))",
            "Notes": Notes,
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
                let ErrorCode: String = DataJSON!["code"].string!

                if ErrorCode == "001" {
                    //
                } else if ErrorCode == "013" {
                    Ticket_Alert = "此活動僅提供免費票"
                }
            case let .failure(error):
                print("Error:\(error)")
            }
        }
    }

    func Update_Ticket_Status(Act_Id: String) {
        let url = URL(string: "http://163.18.42.222:8888/Fiestadb/Ticket/updateTicketStatusFalse")!
        var json: [String: Any] = [
            "act_Id": Act_Id,
            "auth_Id": "\(UserDefaults.standard.value(forKey: "AuthId"))",
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
                let ErrorCode: String = DataJSON!["code"].string!

                if ErrorCode == "001" {
                    //
                } else if ErrorCode == "013" {
                    Ticket_Alert = "此活動僅提供免費票"
                }
            case let .failure(error):
                print("Error:\(error)")
            }
        }
    }
}
