//
//  ScheduleModel.swift
//  MyScheduleTestApp
//
//  Created by Roman Korobskoy on 12.01.2022.
//

import RealmSwift

class ScheduleModel: Object {
    
    @Persisted var scheduleName: String = ""
    @Persisted var scheduleStartDate: Date?
    @Persisted var scheduleStartTime: Date?
    @Persisted var scheduleFinishDate: Date?
    @Persisted var scheduleFinishTime: Date? 
    @Persisted var scheduleDescription: String = ""

}
