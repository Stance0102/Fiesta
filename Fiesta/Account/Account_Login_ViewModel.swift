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
    @Published var accountStatus: [Account_Status] = []
    @Published var UserId: String = ""
    @Published var Password: String = ""
    @Published var StatusMsg: String = ""
    var cancellable: AnyCancellable?
    var cancelUpdate = Set<AnyCancellable>()
    
//    Fetch Recommend Activity
    func fetch_Account(UserId userId: String, Password password: String)
    {
        let json: [String: Any] = [
            "userId": userId,
            "userPassword": password
        ]
        
        cancellable = fiestaService.fetch_Account(JSON: json, Path: "/Account/select")
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { value in
                switch value {
                case .finished :
                    print("OK Cool")
                case .failure(let error) :
                    print("Ganlinniagby by:\(error.localizedDescription)")
                }
            },
            receiveValue: { [weak self] fiestaContainer in
                guard let self = self else
                {
                    return
                }
                
                self.accountStatus.removeAll()
                self.accountStatus.insert((Account_Status(DataContainer_Account(code: fiestaContainer.code, result: fiestaContainer.result))), at: 0)
                
                switch(self.accountStatus[0].StatusCode)
                {
                    case "001":
                        self.accountViewModel = fiestaContainer.result.map { Account_ViewModel($0!) }
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
    
    private var StatusUpdate: AnyPublisher<String, Never>
    {
        $StatusMsg
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { $0 }
            .eraseToAnyPublisher()
    }
    
    init() {
        StatusUpdate
            .receive(on: RunLoop.main)
            .assign(to: \.StatusMsg, on: self)
            .store(in: &cancelUpdate)
    }
}

struct Account_Status: Hashable {
    private let account_Status: DataContainer_Account
    
    var StatusCode: String {
        return account_Status.code
    }
    
    init(_ account_Status: DataContainer_Account)
    {
        self.account_Status = account_Status
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
