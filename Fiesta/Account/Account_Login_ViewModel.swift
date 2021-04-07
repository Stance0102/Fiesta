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
    private let fiestaService = AccountService()
    @Published var accountViewModel: [Account_ViewModel] = []
    @Published var UserId: String = ""
    @Published var Password: String = ""
//    @Published var arrayJson: [String] = []
    var cancellable: AnyCancellable?
    
//    Fetch Recommend Activity
    func fetch_Account(UserId userId: String, Password password: String)
    {
        let json: [String: Any] = [
            "userId": userId,
            "userPassword": password
        ]
        
        cancellable = fiestaService.fetch_Account(JSON: json, Path: "/Account/select")
            .sink(receiveCompletion: { value in
                switch value {
                case .finished :
                    print("OK Cool")
                case .failure(let error) :
                    print("Ganlinniagby by:\(error.localizedDescription)")
                }
            },
            receiveValue: { fiestaContainer in
                    print(fiestaContainer.code)
                    print(fiestaContainer.result)
                    self.accountViewModel = fiestaContainer.result.map { Account_ViewModel($0!) }
                    print(self.accountViewModel)
            }
        )
    }
}

struct Account_ViewModel: Hashable {
    private let account: Account
    
    var Id: String {
        return account.Id
    }
    
    var UserId: String {
        return account.userId
    }
    
    var UserName: String {
        return account.userName
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
        return account.Mail_1
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
