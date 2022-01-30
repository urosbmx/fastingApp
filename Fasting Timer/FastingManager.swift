//
//  FastingManager.swift
//  Fasting Timer
//
//  Created by Uroš Katanić on 27.1.22..
//

import Foundation
import SwiftUI

enum FastingState{
    case notStarted
    case fasting
    case feeding
}

enum FastingPlan: String{
    case beginer  = "12:12"
    case intermediate = "16:8"
    case advance = "20:4"
    
    var fastingPeriond: Double {
        switch self {
        case .beginer:
            return 12
        case .intermediate:
            return 16
        case .advance:
            return 20
        }
    }
}

class FastingManager: ObservableObject{
    @Published private(set) var fastingState: FastingState = .notStarted
    @Published private(set) var fastingPlan: FastingPlan = .intermediate
    @Published private(set) var  startTime: Date{
        didSet {
            print("staritngTime",
                  startTime.formatted(.dateTime.month().day().hour().minute().second()))
            
            if fastingState == .fasting{
                endTime = startTime.addingTimeInterval(fastingTime)
            }else{
                endTime = startTime.addingTimeInterval(feadingTime)
            }
        }
        
    }
    @Published private(set) var  endTime: Date{
        didSet{
            print("endTime",
                  endTime.formatted(.dateTime.month().day().hour().minute().second()))
        }
    }
    
    @Published private(set) var elapse: Bool = false
    @Published private(set) var elapseTime: Double = 0.0
    @Published private(set) var progress: Double = 0.0
    
    
    var fastingTime: Double{
        return fastingPlan.fastingPeriond * 60 * 60
    }
    
    var feadingTime:Double{
        return (24 - fastingPlan.fastingPeriond) * 60 * 60
    }
    
    init(){
        let calendar = Calendar.current
        
//        var components = calendar.dateComponents([.year, .month, .day, .hour ], from: Date())
//
//        components.hour = 20
//        print(components)
//
//        let scheduledTime = calendar.date(from: components) ?? Date.now
//        print("scheduledTime", scheduledTime.formatted(.dateTime.day().hour().minute().second()))
        
        let components = DateComponents(hour:20)
        let scheduledTime = calendar.nextDate(after: .now , matching:  components, matchingPolicy: .nextTime)!
        print("schedualedTime", scheduledTime.formatted(.dateTime.month().day().hour().minute().second()))
        
        
        startTime = scheduledTime
        endTime = scheduledTime.addingTimeInterval(FastingPlan.intermediate.fastingPeriond * 60 * 60)
    }
    
    func toogleFastingState(){
        fastingState = fastingState == .fasting ? .feeding : .fasting
        startTime = Date()
        elapseTime = 0.0
    }
    func track(){
        guard fastingState != .notStarted else{return}
        if endTime >= Date(){
            print("Not elspe")
            elapse = false
        }else{
            print("Elapse")
            elapse = true
        }
        elapseTime += 1
//        print(elapseTime)
        
        let totalTime = fastingState  == .fasting ? fastingTime: feadingTime
        progress = (elapseTime / totalTime  * 100).rounded() / 100
        print(progress)
    }
    
}
