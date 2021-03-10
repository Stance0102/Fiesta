//
//  _Lotte.swift
//  Fiesta
//
//  Created by 李慶毅 on 2020/11/24.
//

import Alamofire
import Combine
import Foundation
import SwiftyJSON

struct Lotte: Hashable {
    let Act_Id: String
    let Account_Id: String
    let Prize: String
    let LotteTime: String
}

class Lotte_Cls {
    init() {}

//    lotteId: 116
    func Get_Lotte(_ Act_Id: String) {
        let url = URL(string: "http://163.18.42.222:8888/Fiestadb/Lotte/select")!
        let json: [String: Any] = [
            "act_Id": Act_Id,
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
                let Result_Count: Int = DataJSON!["result"].count

                if ErrorCode == "001" {
                    for i in 0 ..< Result_Count {}
                } else if ErrorCode == "013" {
                    Ticket_Alert = "此活動僅提供免費票"
                }
            case let .failure(error):
                print("Error:\(error)")
            }
        }
    }

    func Upload_Lotte(Act_Id: String, Prize: String, LotteTime _: String) {
        let url = URL(string: "http://163.18.42.222:8888/Fiestadb/Lotte/upload")!
        let json: [String: Any] = [
            "act_Id": Act_Id,
            "Prize": Prize,
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
                let Result_Count: Int = DataJSON!["result"].count

                if ErrorCode == "001" {
                    for i in 0 ..< Result_Count {}
                } else if ErrorCode == "013" {
                    Ticket_Alert = "此活動僅提供免費票"
                }
            case let .failure(error):
                print("Error:\(error)")
            }
        }
    }

    func Update_Lotte(Lotte_Id: String, Prize: String) {
        let url = URL(string: "http://163.18.42.222:8888/Fiestadb/Lotte/update")!
        let json: [String: Any] = [
            "lotteId": Lotte_Id,
            "Prize": Prize,
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
                let Result_Count: Int = DataJSON!["result"].count

                if ErrorCode == "001" {
                } else if ErrorCode == "013" {
                    Ticket_Alert = "此活動僅提供免費票"
                }
            case let .failure(error):
                print("Error:\(error)")
            }
        }
    }

    func Delect_Lotte(_ Lotte_Id: String) {
        let url = URL(string: "http://163.18.42.222:8888/Fiestadb/Lotte/update")!
        let json: [String: Any] = [
            "lotteId": Lotte_Id,
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
                let Result_Count: Int = DataJSON!["result"].count

                if ErrorCode == "001" {
                } else if ErrorCode == "013" {
                    Ticket_Alert = "此活動僅提供免費票"
                }
            case let .failure(error):
                print("Error:\(error)")
            }
        }
    }

    func Rand_Lotte(Act_Id: String, Lotte_Id: String, LotteTime: Date) {
        let formatter3 = DateFormatter()
        formatter3.dateFormat = "y-M-d HH:mm:ss"
        let LotteTime_Str: String = formatter3.string(from: LotteTime)
        let url = URL(string: "http://163.18.42.222:8888/Fiestadb/Lotte/rand")!
        let json: [String: Any] = [
            "act_Id": Act_Id,
            "lotteId": Lotte_Id,
            "lotteTime": LotteTime_Str,
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
                let Result_Count: Int = DataJSON!["result"].count

                if ErrorCode == "001" {
                } else if ErrorCode == "013" {
                    Ticket_Alert = "此活動僅提供免費票"
                }
            case let .failure(error):
                print("Error:\(error)")
            }
        }
    }
}
