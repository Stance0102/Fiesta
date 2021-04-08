//
//  AccountService.swift
//  Fiesta
//
//  Created by Stance Li on 2021/4/7.
//

import Foundation
import Combine


final class AccountService {
    func fetch_Account(JSON json: [String: Any], Path path: String) -> AnyPublisher<DataContainer_Account, Error> {
        
        var components: URLComponents {
            var components = URLComponents()
            components.scheme = "http"
            components.host = "163.18.42.222"
            components.port = 8888
            components.path = "/Fiestadb" + path
            
            return components
        }
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try! JSONSerialization.data(withJSONObject: json, options: [])
        
        print(json)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: DataContainer_Account.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

struct DataContainer_Account: Decodable, Hashable {
    let code: String
    let result: [Account?]
}

struct Account: Decodable, Hashable {
    var Id: String? //"Id": "44"
    var Address: String? //"Address": "None",
    var Birthday: String? //"Birthday": "None"
    var Department: String? //"Department": "None"
    var Distance: String? //"Distance": "25"
    var ID_CARD: String? //"ID_CARD": "None"
    var Latitude: String? //"Latitude": "None"
    var Tag: String? //"Tag": "None"
    var Mail_1: String? //"Mail_1": "c107118143@nkust.edu.tw"
    var Mail_2: String? //"Mail_2": "None"
    var Phone: String? //"Phone": "090909090909"
    var Photo: String? //"Photo": "https://imgur.com/iNGnle2.jpg"
    var School: String? //"School": "國立高雄科技大學"
    var Sex: String? //"Sex": "None"
    var Longitude: String? //"Longitude": "None"
    var Useable: String? //"Useable": "1"
    var avgCost: String? //"avgCost": "None"
    var deviceToken: String? //"deviceToken": "None"
    var nickName: String? //"nickName": "測試一"
    var token: String? //"token": ""
    var userName: String? //"userName": "測試一"
    var userId: String? //"userId": "test0001"
}











