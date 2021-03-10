//
//  _Tag.swift
//  Fiesta
//
//  Created by 李慶毅 on 2020/11/18.
//

import Alamofire
import Combine
import Foundation
import SwiftyJSON

var TagName: String = ""

class TagManager: ObservableObject, Identifiable {
    @Published var Selected_Tag: [String: Bool]
    @Published var Tag_List: [String]
    var Tag_Array: [String] = []
    var TagCount: Int = 0
    var others: Int
    var row: Int

    init() {
        Selected_Tag = [:]
        Tag_List = []

        func GetTag() {
            let url = URL(string: "http://163.18.10.123:4000/Fiestadb/Tag/select")
            AF.request(url!).validate().responseJSON { response in
                switch response.result {
                case let .success(value):

                    let TagJSON = JSON(value)
                    let DataCount: Int = TagJSON["result"][0].count
                    self.TagCount = DataCount

                    for i in 0 ..< DataCount {
                        self.Tag_List.append(TagJSON["result"][0][i].string!)
                    }

                case let .failure(error):
                    print(error)
                }
            }
        }

        others = TagCount % 4
        row = TagCount / 4

        var test: Int = 0
        var _: () = {
            if others != 0 {
                row += 1
            } else {
                test = 4
                others = others - test
            }
        }()

        for tagName in Tag_List {
            Selected_Tag[tagName] = false
        }
    }

    func updateData(_ Index: Int, _ Item: Int) {
        if Selected_Tag[Tag_List[Index * 4 + Item + others]]! == false {
            Selected_Tag[Tag_List[Index * 4 + Item + others]] = true
            Add_Tag_Array(Tag_List[Index * 4 + Item + others])
            print("\n")
            print("------")
            print(Selected_Tag)
            print("------")
            print(Tag_Array)
            print("\n")
        } else {
            Selected_Tag[Tag_List[Index * 4 + Item + others]] = false
            Remove_Tag_Array(Tag_List[Index * 4 + Item + others])
            print("\n")
            print("------")
            print(Selected_Tag)
            print("------")
            print(Tag_Array)
            print("\n")
        }
    }

    func getData(_ Index: Int, _ Item: Int) -> Bool {
        return Selected_Tag[Tag_List[Index * 4 + Item + others]]!
    }

    // 新增 Tag 到 Tag Array
    func Add_Tag_Array(_ Tag: String) {
        Tag_Array.append(Tag)
        Tag_String()
    }

    // 從 Tag Array 移除 Tag
    func Remove_Tag_Array(_ Tag: String) {
        Tag_Array.removeAll { (tag) -> Bool in
            let isRemove = tag == Tag
            return isRemove
        }
        Tag_String()
    }

    // Tag Array 轉 String
    func Tag_String() {
        TagName = ""
        for i in 0 ..< Tag_Array.count {
            if TagName == "" {
                TagName = "\(Tag_Array[i])"
                print("-----")
                print(TagName)
                print("-----")
            } else {
                TagName += ",\(Tag_Array[i])"
                print("-----")
                print(TagName)
                print("-----")
            }
        }
        print(Tag_Array)
        print("I'm \(TagName)")
    }

    // 新增 Tag
    func Create_Tag(_ CreateTag: String) {
        let json: [String: Any] = [
            "TagName": CreateTag,
        ]
        let url = URL(string: "http://163.18.42.222:8888/Fiestadb/Tag/upload")!
        let headers: HTTPHeaders = [
            "Accept": "application/json",
        ]
        var ErrorCode: String?

        AF.request(url, method: .post, parameters: json, encoding: JSONEncoding.default, headers: headers).responseData { response in
            switch response.result {
            case .success:
                guard let data = response.data else { return }
                let DataJSON = try? JSON(data: data)
                ErrorCode = DataJSON!["code"].string!

                debugPrint(ErrorCode!)
            case let .failure(error):
                print("Error:\(error)")
            }
        }
    }
}
