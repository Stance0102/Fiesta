//
//  _Fiesta_Response.swift
//  Fiesta
//
//  Created by Stance Li on 2021/3/30.
//

import Foundation

struct ActivityResponse: Codable {
  let list: [Item]
  
  struct Item: Codable {
    let id: String
    let Name: String
    let Image: String
//    let GroupImage: String
    let GroupName: String
    let Tags: [String]
    let Location: String
    let StartTime: String
    let EndTime: String
    let Description: String
    let People_Maxium: String
    let ViewStatus: String
    let Latitude: String
    let Longitude: String
    let JoinedCount: String
    let Models: String
  }
}
