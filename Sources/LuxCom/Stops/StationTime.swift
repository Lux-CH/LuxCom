//
//  StationTime.swift
//  LuxCom
//
//  Created by Constantin Clerc on 05.02.2025.
//
//  Source : https://github.com/openTdataCH/ojp-ios/blob/a8dd6403f713f8c5df1c0a4ff4f6fdb9ff4333d7/SampleApp/OJPSampleApp/Helpers/OJP%2BExtensions.swift

import Foundation
import OJP

struct StationTime {
    let estimated: Date?
    let timetabled: Date

    var hasDelay: Bool {
        delay >= 60
    }

    var delay: TimeInterval {
        if let estimated {
            estimated.timeIntervalSince(timetabled)
        } else { 0 }
    }
}

extension OJPv2.ServiceArrival {
    var arrivalTime: StationTime {
        StationTime(estimated: estimatedTime, timetabled: timetabledTime)
    }
}

extension OJPv2.ServiceDeparture {
    var departureTime: StationTime {
        StationTime(estimated: estimatedTime, timetabled: timetabledTime)
    }
}
