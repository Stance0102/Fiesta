//
//  ResultStatus.swift
//  Fiesta
//
//  Created by Stance Li on 2021/4/13.
//

import Foundation

enum ResultStatus: Equatable
{
    case loading
    case failed(error: Error)
    case success
    
    static func == (lhs: ResultStatus, rhs: ResultStatus) -> Bool
    {
        switch (lhs, rhs)
        {
        case (.loading, .loading):
            return true
        case (.failed(error: let lhsType), .failed(error: let rhsType)):
            return lhsType.localizedDescription == rhsType.localizedDescription
        case (.success, .success):
            return false
        default:
            return false
        }
    }
}
