//
//  _Fiesta_Fetcher.swift
//  Fiesta
//
//  Created by Stance Li on 2021/3/30.
//

import Foundation
import Combine

class Fiesta_Fetcher
{
    private let session: URLSession
    
    init(session: URLSession = .shared)
    {
        self.session = session
    }
}

private extension Fiesta_Fetcher
{
    struct FiestaAPI
    {
        static let scheme = "http"
        static let host = "163.18.42.222"
        static let port = 8888
        static let path = "/Fiestadb"
    }
    
    func connet_FiestaDB_Components(Path byPath: String, postJSON Json: [String: Any]) -> URLRequest
    {
        var components = URLComponents()
        components.scheme = FiestaAPI.scheme
        components.host = FiestaAPI.host
        components.port = FiestaAPI.port
        components.path = FiestaAPI.path + "/Activity/getRecommend"
        
        print("I'm \(components.url!)")
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try? JSONSerialization.data(withJSONObject: Json, options: [])
//        let JsonData = Json.flatMap { key, value -> [URLQueryItem] in
//            if let strings = value as? [String] {
//                return strings.map{ URLQueryItem(name: key, value: $0) }
//            }else{
//                return [URLQueryItem(name: key, value: value as? String)]
//            }
//        }
//        components.queryItems = JsonData
        return request
    }
}

protocol Fiesta_Fetchable
{
    func Activity_getRecommend(Path byPath: String, postJSON Json: [String: Any]) -> AnyPublisher<ActivityResponse, Fiesta_Error>
}

extension Fiesta_Fetcher: Fiesta_Fetchable
{
    private func getActivity<T>(Request request: URLRequest) -> AnyPublisher<T, Fiesta_Error> where T: Decodable
    {
//        guard let url = components.url else {
//            let error = Fiesta_Error.network(description: "API連結有誤")
//            return Fail(error: error).eraseToAnyPublisher()
//        }
        
        return session.dataTaskPublisher(for: request)
            .mapError { error in
                .network(description: error.localizedDescription)
            }
            .flatMap(maxPublishers: .max(10)) { act_Item in
                decode(act_Item.data)
            }
            .eraseToAnyPublisher()
    }
    
    func Activity_getRecommend(Path byPath: String, postJSON Json: [String: Any]) -> AnyPublisher<ActivityResponse, Fiesta_Error>
    {
        return getActivity(Request: connet_FiestaDB_Components(Path: byPath, postJSON: Json))
    }
}
