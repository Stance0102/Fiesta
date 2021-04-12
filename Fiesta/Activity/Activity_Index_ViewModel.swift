//
//  Activity_Index_ViewModel.swift
//  Fiesta
//
//  Created by Stance Li on 2021/3/31.
//

import SwiftUI
import Combine

class Activity_Info_ViewModel: ObservableObject 
{
    private let Service = ActivityService()
    var isLoading: Bool {
        state == ResultStatus.loading
    }
    @Published var activityViewModel = [Activity_ViewModel]()
    @Published var json: [String: Any] = ["act_Id": ""]
    @Published private(set) var state: ResultStatus = .loading
    
//    @Published var arrayJson: [String] = []
    var cancellable: AnyCancellable?
    
//    Fetch Recommend Activity
    func fetch_Activity()
    {
        self.state = .loading
        cancellable = Service.fetch_Activity(JSON: json, Path: "/Activity/getRecommend")
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { value in
                switch value {
                case .finished :
                    self.state = .success
                case .failure(let error):
                    print("Ganlinniagby by:\(error.localizedDescription)")
                    self.state = .failed(error: error)
                }
            },
            receiveValue: { [weak self] fiestaContainer in
                guard let self = self else {
                    return
                }
                print(fiestaContainer.code)
                print(fiestaContainer.result)
                self.activityViewModel = fiestaContainer.result.map { Activity_ViewModel($0!) }
                print(self.activityViewModel)
            }
        )
    }
}

struct Activity_ViewModel: Hashable {
    private let activity: Activity
    
    var Id: String {
        return activity.Id
    }
    
    var Name: String {
        return activity.act_Name
    }
    
    var Image_Link: String {
        return activity.Photo!
    }
    
    var GroupImage: String {
        return activity.groupPhoto!
    }
    
    var GroupName: String {
        return activity.groupName!
    }
    
    var Tags: [String] {
        return activity.Tag
    }
    
    var Location: String {
        return activity.Location!
    }
    
    var StartTime_All: String {
        return DateAndTime.string(from: DateAndTime.date(from: activity.startTime!)!)
    }
    
    var EndTime_All: String {
        return DateAndTime.string(from: DateAndTime.date(from: activity.endTime!)!)
    }
    
    var Description: String {
        return activity.act_Description!
    }
    
    var PeopleMaxium: Int {
        return Int(activity.peopleMaxium!)!
    }
    
    var ViewStatus: String {
        return activity.viewStatus!
    }
    
    var Latitude: Double {
        return Double(activity.Latitude!)!
    }
    
    var Longitude: Double {
        return Double(activity.Longitude!)!
    }
    
    var JoinedCount: Int {
        return Int(activity.joinedCount!)!
    }
    
    var Models: String {
        return activity.Models
    }
    
    init(_ activity: Activity)
    {
        self.activity = activity
    }
} 
