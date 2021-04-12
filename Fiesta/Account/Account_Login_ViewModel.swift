//
//  Account_Login_ViewModel.swift
//  Fiesta
//
//  Created by Stance Li on 2021/4/7.
//

import SwiftUI
import Combine

class Account_Login_ViewModel: ObservableObject
{
    private let Service = AccountService()
    @Published var accountViewModel = [Account_ViewModel]()
    var isLoading: Bool {
        state == ResultStatus.loading
    }
    @Published private(set) var state: ResultStatus = .loading
    @Published var UserId: String = ""
    @Published var Password: String = ""
    @Published var StatusMsg: String = ""
    @Published var UserInfo = UserDefaults()
    
    var cancellable: AnyCancellable?
    var cancelUpdate = Set<AnyCancellable>()
    
//    Fetch Account Info
    func fetch_Account(UserId userId: String, Password password: String)
    {
        let json: [String: Any] = [
            "userId": userId,
            "userPassword": password
        ]
        
        self.state = .loading
        cancellable = Service.fetch_Account(JSON: json, Path: "/Account/select")
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { value in
                switch value {
                case .finished :
                    self.state = .success
//                    print("Get it")
                case .failure(let error) :
                    print("Ganlinniagby by:\(error.localizedDescription)")
                    self.state = .failed(error: error)
                }
            },
            receiveValue: { [weak self] fiestaContainer in
                guard let self = self else
                {
                    return
                }
                
                self.UserInfo.setValue(fiestaContainer.result[0]?.Id, forKey: "Id")
                self.UserInfo.setValue(fiestaContainer.result[0]?.userId, forKey: "UserId")
                self.UserInfo.setValue(fiestaContainer.result[0]?.userName, forKey: "UserName")
                self.UserInfo.setValue(fiestaContainer.result[0]?.nickName, forKey: "NickName")
                
                switch(fiestaContainer.code)
                {
                    case "001":
                        self.StatusMsg = ""
                    case "002":
                        self.StatusMsg = "帳號或密碼錯誤"
                    case "003":
                        self.StatusMsg = "帳號或密碼錯誤"
                    default:
                        break
                }
                
                print(self.StatusMsg)
            }
        )
    }
    
    
}

struct Account_ViewModel: Hashable {
    private let account: Account
    
    var Id: String {
        return account.Id!
    }
    
    var UserId: String {
        return account.userId!
    }
    
    var UserName: String {
        return account.userName!
    }
    
    var NickName: String {
        return account.nickName!
    }
    
    var Address: String {
        return account.Address!
    }
    
    var Birthday_All: String {
        return DateAndTime.string(from: DateAndTime.date(from: account.Birthday!)!)
    }
    
    var Department: String {
        return account.Department!
    }
    
    var Distance: String {
        return account.Distance!
    }
    
    var ID_Card: String {
        return account.ID_CARD!
    }
    
    var Latitude: Double {
        return Double(account.Latitude!)!
    }
    
    var Longitude: Double {
        return Double(account.Longitude!)!
    }
    
    var Mail_1: String {
        return account.Mail_1!
    }
    
    var Mail_2: String {
        return account.Mail_2!
    }
    
    var Phone: String {
        return account.Phone!
    }
    
    var Photo: String {
        return account.Photo!
    }
    
    var School: String {
        return account.School!
    }
    
    var Sex: String {
        return account.Sex!
    }
    
    var Tags: String {
        return account.Tag!
    }
    
    var Avg_Cost: Int {
        return Int(account.avgCost!)!
    }
    
    var DeviceToken: String {
        return account.deviceToken!
    }
    
    var Token: String {
        return account.token!
    }
    
    init(_ account: Account)
    {
        self.account = account
    }
}
