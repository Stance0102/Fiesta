//
//  Formatter.swift
//  Fiesta
//
//  Created by Stance Li on 2021/3/31.
//

import Foundation

let OnlyDateFor: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy/MM/dd"
    return formatter
}()

let DateAndTime: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy/MM/dd HH:mm"
    return formatter
}()

