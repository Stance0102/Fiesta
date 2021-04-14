//
//  _Account_Signin_ViewModel.swift
//  Fiesta
//
//  Created by Stance Li on 2021/4/14.
//
import SwiftUI
import Combine

class Account_Signin_ViewModel: ObservableObject
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
    
    var cancellable: AnyCancellable?
    
//    Fetch Account Info
    func fetch_Account(
        UserId userId: String,
        Password password: String?,
        UserName userName: String?,
        Email_1 mail_1: String,
        Email_2 mail_2: String?,
        Tags tags: [String]?,
        AvgCost avgCost: String?,
        Birthday birthday: String?,
        Address address: String?,
        Phone phone: String?,
        ID_CARD ID_card: String?,
        Sex sex: String?,
        School school: String?,
        Latitude latitude: String?,
        Longitude longitude: String?,
        Distance distance: String?,
        DeviceToken deviceToken: String?,
        Photo photo: String?,
        Department department: String?
    ){
        var json: [String: Any] = [:]
        
        let JsonReady: [String: Any] = [
            "userName": userName!,
            "userId": userId,
            "userPassword": password!,
            "Mail_1": mail_1,
            "Mail_2": mail_2!,
            "Tag": tags!,
            "avgCost": avgCost!,
            "Birthday": birthday!,
            "Address": address!,
            "Phone": phone!,
            "ID_CARD": ID_card!,
            "Sex": sex!,
            "School": school!,
            "Latitude": latitude!,
            "Longitude": longitude!,
            "Distance": distance!,
            "deviceToken": deviceToken!,
            "Photo": photo!,
            "department": department!,
            "Useable": "true"
        ]
        
        for (k, v) in JsonReady
        {
            let value = v as! String
            if value != ""
            {
                json[k] = value
            }
        }
        
        self.state = .loading
        cancellable = Service.fetch_Account(JSON: json, Path: "/Account/upload")
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
                
                switch(fiestaContainer.code)
                {
                    case "001":
                        self.StatusMsg = ""
                    case "005":
                        self.StatusMsg = "已有重複帳號"
                    default:
                        break
                }
                
                print(self.StatusMsg)
            }
        )
    }
    
    
}
