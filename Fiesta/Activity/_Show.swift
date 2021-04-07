//
//  _Show.swift
//  Fiesta
//
//  Created by 李慶毅 on 2020/11/21.
//

import Alamofire
import Combine
import Foundation
import SwiftyJSON

struct Show: Hashable {
    let Name: String
    let Act_Id: String
    let Detail: String
    let Time: String
    let Status: String
}

// Show_Id: 452
class Show_Cls {
    init() {}

    // 還沒測試過
    func Get_ShowScore_ByAct(_ Act_Id: String) {
        let url = URL(string: "http://163.18.42.222:8888/Fiestadb/FeedBack/Show/SelectByAct")!
        var json: [String: Any] = [
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

    func Upload_Show(_ Act_Id: String, ShowName: String, ShowTime: Date, Detail: String, ShowStatus _: String)
    {
        let formatter3 = DateFormatter()
        formatter3.dateFormat = "y-M-d HH:mm:ss"
        let ShowTime_Str: String = formatter3.string(from: ShowTime)
        let url = URL(string: "http://163.18.42.222:8888/Fiestadb/Show/upload")!
        var json: [String: Any] = [
            "act_Id": Act_Id,
            "showName": ShowName,
            "Detail": Detail,
            "showTime": ShowTime_Str,
            "showStatus": "false",
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

    func Select_Show(_ Act_Id: String) {
        let url = URL(string: "http://163.18.42.222:8888/Fiestadb/Show/Select")!
        var json: [String: Any] = [
            "act_Id": Act_Id
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

    func Update_Show(ShowId: String, ShowName: String, Detail: String, ShowTime: Date, ShowStatus: Bool)
    {
        let formatter3 = DateFormatter()
        formatter3.dateFormat = "y-M-d HH:mm:ss"
        let ShowTime_Str: String = formatter3.string(from: ShowTime)
        let url = URL(string: "http://163.18.42.222:8888/Fiestadb/FeedBack/Show/update")!
        var json: [String: Any] = [
            "showId": ShowId,
            "showName": ShowName,
            "Detail": Detail,
            "showTime": ShowTime_Str,
            "showStatus": String(ShowStatus),
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

    func Delect_Show(_ ShowId: String) {
        let url = URL(string: "http://163.18.42.222:8888/Fiestadb/Show/delete")!
        var json: [String: Any] = [
            "showId": ShowId,
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
