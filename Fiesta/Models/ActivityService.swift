//
//  ActivityService.swift
//  Fiesta
//
//  Created by Stance Li on 2021/4/6.
//

import Foundation
import Combine

final class ActivityService {
    func fetch_Activity(JSON json: [String: Any], Path path: String) -> AnyPublisher<DataContainer_Activity, Error> {
        
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
            .decode(type: DataContainer_Activity.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

struct DataContainer_Activity: Decodable {
    let code: String
    let result: [Activity?]
}

struct Activity: Decodable, Hashable {
    var Id: String
    var Latitude: String?
    var Location: String?
    var Longitude: String?
    var Models: String
    var Photo: String?
    var Price: String?
    var Tag: [String]
    var Useable: String
    var act_Description: String?
    var act_Name: String
    var act_Status: String
    var endTime: String?
    var groupId: String?
    var groupName: String?
    var groupPhoto: String?
    var joinedCount: String?
    var peopleMaxium: String?
    var startTime: String?
    var viewStatus: String?
}
