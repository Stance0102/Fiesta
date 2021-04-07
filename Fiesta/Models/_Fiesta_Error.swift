//
//  _Fiesta_Error.swift
//  Fiesta
//
//  Created by Stance Li on 2021/3/31.
//

import Foundation

enum Fiesta_Error: Error {
    case parsing(description: Error)
    case network(description: String)
}
