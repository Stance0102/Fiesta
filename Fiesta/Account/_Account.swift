//
//  _Account.swift
//  Fiesta
//
//  Created by 李慶毅 on 2020/11/12.
//

import Alamofire
import Combine
import Foundation
import SwiftyJSON

//struct Account_Info: Hashable {
//    let AuthId: String
//    let UserId: String
//    let Name: String
//    let Password: String
//    let Email: String
//    let Token: String
//    let Photo: String
//}
//
//
//
//class Account: ObservableObject, Identifiable {
//    @Published var AccountInfo: [Account_Info]
//    @Published var School_C_Email: [String]
//    @Published var School_E_Email: [String]
//    @Published var School_Class: [String]
//
//    init() {
//        AccountInfo = []
//        School_C_Email = []
//        School_E_Email = []
//        School_Class = []
//    }
//
//    func Post_Login_JSON(UserId MyUserId: String, Password MyPassword: String) {
//        let json: [String: Any] = [
//            "userId": MyUserId,
//            "userPassword": MyPassword,
//        ]
//        let url = URL(string: "http://163.18.42.222:8888/Fiestadb/Account/select")!
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
//                debugPrint(DataJSON!)
//                self.AccountInfo.removeAll()
//
//                if ErrorCode == "001" {
//                    let AuthID: String = DataJSON!["result"][0]["Id"].string!
//                    let UserID: String = DataJSON!["result"][0]["userId"].string!
//                    let UserName: String = DataJSON!["result"][0]["userName"].string!
//                    let Email: String = DataJSON!["result"][0]["Mail_1"].string!
//                    let Token: String = DataJSON!["result"][0]["token"].string!
//                    let Photo: String = DataJSON!["result"][0]["Photo"].string!
//
//                    self.AccountInfo.append(
//                        Account_Info(
//                            AuthId: AuthID,
//                            UserId: UserID,
//                            Name: UserName,
//                            Password: MyPassword,
//                            Email: Email,
//                            Token: Token,
//                            Photo: Photo
//                        )
//                    )
//
//                    UserDefaults.standard.set(AuthID, forKey: "AuthID")
//                    UserDefaults.standard.set(UserID, forKey: "UserID")
//                    UserDefaults.standard.set(UserName, forKey: "UserName")
//                    UserDefaults.standard.set(UserName, forKey: "Password")
//                    UserDefaults.standard.set(Email, forKey: "Email")
//                    UserDefaults.standard.set(Token, forKey: "Token")
//
//                    print("\(UserDefaults.standard.value(forKey: "Token"))")
//                } else if ErrorCode == "013" {
////                        6Ticket_Alert = "此活動僅提供免費票"
//                }
//
//            case let .failure(error):
//                print("Error:\(error)")
//            }
//        }
//    }
//
//    func GetEmail() {
//        let url = URL(string: "http://163.18.42.222:8888/Fiestadb/getSchool")
//        AF.request(url!).validate().responseJSON { response in
//            switch response.result {
//            case let .success(value):
//                let SchoolJSON = JSON(value)
//                let DataCount: Int? = SchoolJSON["result"][0].count
//                self.School_C_Email.removeAll()
//                self.School_E_Email.removeAll()
//
//                for i in 0 ..< DataCount! {
//                    self.School_E_Email.insert(SchoolJSON["result"][0][i].string!, at: i)
//                    self.School_C_Email.insert(SchoolJSON["result"][1][i].string!, at: i)
//                }
//            case let .failure(error):
//                print(error)
//            }
//        }
//    }
//
//    func Get_School_Class(_ SklClass: String) {
//        let url = URL(string: "http://163.18.42.222:8888/Fiestadb/getSchoolClass")
//        let School = [
//            "school": SklClass,
//        ]
//
//        AF.request(url!, parameters: School).validate().responseJSON { response in
//            switch response.result {
//            case let .success(value):
//                let SchoolJSON = JSON(value)
//                let DataCount: Int? = SchoolJSON["result"][0].count
//                self.School_Class.removeAll()
//
//                for i in 0 ..< DataCount! {
//                    self.School_Class.append(SchoolJSON["result"][i].string!)
//                }
//            case let .failure(error):
//                print(error)
//            }
//        }
//    }
//
//    func Post_SignUp_JSON(UserName MyUserName: String, UserId MyUserId: String, Password MyPassword: String, Email: String)
//    {
//        let json: [String: Any] = [
//            "userName": MyUserName,
//            "userId": MyUserId,
//            "userPassword": MyPassword,
//            "Mail_1": Email,
//            "Useable": "true",
//        ]
//        let url = URL(string: "http://163.18.42.222:8888/Fiestadb/Account/upload")!
//        let headers: HTTPHeaders = [
//            "Accept": "application/json",
//        ]
//        var ErrorCode: String?
//
//        AF.request(url, method: .post, parameters: json, encoding: JSONEncoding.default, headers: headers).responseData { response in
//            switch response.result {
//            case .success:
//                guard let data = response.data else { return }
//                let DataJSON = try? JSON(data: data)
//                ErrorCode = DataJSON!["code"].string!
//                debugPrint(ErrorCode!)
//            case let .failure(error):
//                print("Error:\(error)")
//            }
//        }
//    }
//
//    func Send_Confirm_JSON(UserId MyUserId: String, SendConfirmType Type: String) {
//        let json: [String: Any] = [
//            "userId": "\(MyUserId)",
//            "type": "\(Type)",
//        ]
//        let url = URL(string: "http://163.18.42.222:8888/Fiestadb/Account/SendConfirm")!
//        let headers: HTTPHeaders = [
//            "Accept": "application/json",
//        ]
//        var ErrorCode: String?
//
//        AF.request(url, method: .post, parameters: json, encoding: JSONEncoding.default, headers: headers).responseData { response in
//            switch response.result {
//            case .success:
//                guard let data = response.data else { return }
//                let DataJSON = try? JSON(data: data)
//                ErrorCode = DataJSON!["code"].string!
//                debugPrint(ErrorCode!)
//            case let .failure(error):
//                print("Error:\(error)")
//            }
//        }
//    }
//
//    func Update_Account(nickName NickName: String = "", tag Tag: String = "", avgCost AvgCost: String = "15", mail_2 Mail_2: String = "", birthday Birthday: String = "", sex Sex: String = "", photo Photo: String = "", phone Phone: String = "")
//    {
//        let json: [String: Any] = [
//            "userId": "\(UserDefaults.standard.value(forKey: "UserID"))",
//            "nickName": NickName,
//            "Tag": Tag,
//            "avgCost": AvgCost,
//            "Mail_2": Mail_2,
//            "Birthday": Birthday,
//            "Sex": Sex,
//            "Photo": Photo,
//            "Phone": Phone,
//        ]
//        let url = URL(string: "http://163.18.42.222:8888/Fiestadb/Account/update")!
//        let headers: HTTPHeaders = [
//            "Accept": "application/json",
//        ]
//        var ErrorCode: String?
//
//        AF.request(url, method: .post, parameters: json, encoding: JSONEncoding.default, headers: headers).responseData { response in
//            switch response.result {
//            case .success:
//                guard let data = response.data else { return }
//                let DataJSON = try? JSON(data: data)
//                ErrorCode = DataJSON!["code"].string!
//                debugPrint(ErrorCode!)
//
//                let NickName: String = DataJSON![0]["result"]["nickName"].string!
//                let Password: String = DataJSON![0]["result"]["userPassword"].string!
//                let Photo: String = DataJSON![0]["result"]["Photo"].string!
//
//                UserDefaults.standard.set(NickName, forKey: "NickName")
//                UserDefaults.standard.set(Photo, forKey: "Photo")
//
//            case let .failure(error):
//                print("Error:\(error)")
//            }
//        }
//    }
//
//    func Get_Confirm_Status() {
//        let json: [String: Any] = [
//            "userId": "\(UserDefaults.standard.value(forKey: "UserID"))",
//        ]
//        let url = URL(string: "http://163.18.42.222:8888/Fiestadb/Account/getReviewStatus")!
//        let headers: HTTPHeaders = [
//            "Accept": "application/json",
//            "Authorization": "Bearer \(UserDefaults.standard.value(forKey: "Token")!)",
//        ]
//        var ErrorCode: String?
//
//        AF.request(url, method: .post, parameters: json, encoding: JSONEncoding.default, headers: headers).responseData { response in
//            switch response.result {
//            case .success:
//                guard let data = response.data else { return }
//                let DataJSON = try? JSON(data: data)
//                ErrorCode = DataJSON!["code"].string!
//
//                let ReviewStatus: String = DataJSON!["result"][0]["reviewStatus"].string!
//
//                if ReviewStatus == "1" {
//                    print("已驗證")
//                } else {
//                    print("尚未驗證")
//                }
//
//                debugPrint(ErrorCode!)
//            case let .failure(error):
//                print("Error:\(error)")
//            }
//        }
//    }
//
//    func Change_Password(_ Password: String) {
//        let json: [String: Any] = [
//            "userId": "\(UserDefaults.standard.value(forKey: "UserID"))",
//            "userPassword": Password,
//        ]
//        let url = URL(string: "http://163.18.42.222:8888/Fiestadb/Account/changePassword")!
//        let headers: HTTPHeaders = [
//            "Accept": "application/json",
//        ]
//        var ErrorCode: String?
//
//        AF.request(url, method: .post, parameters: json, encoding: JSONEncoding.default, headers: headers).responseData { response in
//            switch response.result {
//            case .success:
//                guard let data = response.data else { return }
//                let DataJSON = try? JSON(data: data)
//                ErrorCode = DataJSON!["code"].string!
//                debugPrint(ErrorCode!)
//
//                if ErrorCode == "001" {
//                    print("更改成功")
//                }
//
//            case let .failure(error):
//                print("Error:\(error)")
//            }
//        }
//    }
//
//    //    func Upload_Account_Image()
//    //    {
//    //
//    //    }
//}
