//
//  RealmManager.swift
//  MyScheduleTestApp
//
//  Created by Roman Korobskoy on 12.01.2022.
//

import RealmSwift

class RealmManager {
    
    static let shared = RealmManager()
    
    private init() {}
    
    let localRealm = try! Realm()
    
    func saveScheduleModel(model: ScheduleModel) {
        try! localRealm.write {
            localRealm.add(model)
        }
    }
    
    func deleteScheduleModel(model: ScheduleModel) {
        try! localRealm.write {
            localRealm.delete(model)
        }
    }
    
    func updateScheduleModel(model: ScheduleModel, nameArray: [[String]], scheduleStartDate: Date?, scheduleStartTime: Date?, scheduleFinishDate: Date?, scheduleFinishTime: Date?) {
        try! localRealm.write {
            model.scheduleName = nameArray[0][0]
            model.scheduleStartDate = scheduleStartDate
            model.scheduleStartTime = scheduleStartTime
            model.scheduleFinishDate = scheduleFinishDate
            model.scheduleFinishTime = scheduleFinishTime
            model.scheduleDescription = nameArray[3][0]
        }
    }
}
