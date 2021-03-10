//
//  _Score.swift
//  Fiesta
//
//  Created by 李慶毅 on 2020/11/24.
//

import Alamofire
import Combine
import Foundation
import SwiftyJSON

struct Score: Hashable {
    let Act_Id: String
    let AccountId: String
    let Detail: String
    let Score_Date: String
    let Stars: String
    let Price: String
    let Music: String
    let Flow: String
    let Vibe: String
    let Light: String
    let MoveLine: String
    let Site: String
    let Staff: String
}

// Score_Id: 122
class Score_Cls: ObservableObject, Identifiable {
    init() {}

    func Account_ActScore(_ Act_Id: String) {
        let url = URL(string: "http://163.18.42.222:8888/Fiestadb/FeedBack/Score/Act/SelectByAct")!
        let json: [String: Any] = [
            "auth_Id": UserDefaults.standard.value(forKey: "AuthID"),
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
                } else if ErrorCode == "013" {
                    Ticket_Alert = "此活動僅提供免費票"
                }
            case let .failure(error):
                print("Error:\(error)")
            }
        }
    }

    func Upload_Score(Act_Id: String, Detail: String, Score_Date: Date, Stars: String, Price: String, Music: String, Flow: String, Vibe: String, Light: String, MoveLine: String, Site: String, Staff: String)
    {
        let formatter3 = DateFormatter()
        formatter3.dateFormat = "y-M-d HH:mm:ss"
        let ScoreTime_Str: String = formatter3.string(from: Score_Date)
        let url = URL(string: "http://163.18.42.222:8888/Fiestadb/FeedBack/Score/Act/upload")!
        let json: [String: Any] = [
            "act_Id": Act_Id,
            "authId": UserDefaults.standard.value(forKey: "AuthID"),
            "Detail": Detail,
            "score_Date": ScoreTime_Str,
            "Stars": Stars,
            "Price": Price,
            "Music": Music,
            "Flow": Flow,
            "Vibe": Vibe,
            "Light": Light,
            "Moveline": MoveLine,
            "Site": Site,
            "Staff": Staff,
            "Useable": "true",
        ]
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Authorization": "Bearer \(UserDefaults.standard.value(forKey: "Token")!)",
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

    func Update_Score(ScoreId: String, Detail: String, Score_Date: Date, Stars: String, Price: String, Music: String, Flow: String, Vibe: String, Light: String, MoveLine: String, Site: String, Staff: String)
    {
        let formatter3 = DateFormatter()
        formatter3.dateFormat = "y-M-d HH:mm:ss"
        let ScoreTime_Str: String = formatter3.string(from: Score_Date)
        let url = URL(string: "http://163.18.42.222:8888/Fiestadb/FeedBack/Score/Act/update")!
        let json: [String: Any] = [
            "actScoreId": ScoreId,
            "Detail": Detail,
            "score_Date": ScoreTime_Str,
            "Stars": Stars,
            "Price": Price,
            "Music": Music,
            "Flow": Flow,
            "Vibe": Vibe,
            "Light": Light,
            "Moveline": MoveLine,
            "Site": Site,
            "Staff": Staff,
        ]
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Authorization": "Bearer \(UserDefaults.standard.value(forKey: "Token")!)",
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

    func Delete_Score(_ ScoreId: String) {
        let url = URL(string: "http://163.18.42.222:8888/Fiestadb/FeedBack/Score/Act/delete")!
        let json: [String: Any] = [
            "actScoreId": ScoreId,
        ]
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Authorization": "Bearer \(UserDefaults.standard.value(forKey: "Token")!)",
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
