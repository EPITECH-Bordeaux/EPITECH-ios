//
//  tempo.swift
//  tempo
//
//  Created by Remi Robert on 18/12/14.
//  Copyright (c) 2014 remirobert. All rights reserved.
//

import UIKit

protocol DateFormat {
    var years: Int? {get}
    var months: Int? {get}
    var days: Int? {get}
    var hours: Int? {get}
    var minutes: Int? {get}
    var seconds: Int? {get}
}

@objc
class Tempo: NSObject {
    var years: Int = 0
    var months: Int = 0
    var days: Int = 0
    var hours: Int = 0
    var minutes: Int = 0
    var seconds: Int = 0

    typealias DateFormatBuilder = (newTemp:Tempo) -> ()
    
    init(buildClosure: DateFormatBuilder) {
        super.init()
        buildClosure(newTemp: self)
    }
    
    init(date: NSDate) {
        super.init()
        self.initFromDate(date)
    }
    
    override init() {
        super.init()
        self.initFromDate(NSDate())
    }
    
    private func initFromDate(date: NSDate) {
        var calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)
        var dateComponents = calendar!.components(NSCalendarUnit.YearCalendarUnit |
            NSCalendarUnit.MonthCalendarUnit | NSCalendarUnit.DayCalendarUnit |
            NSCalendarUnit.HourCalendarUnit | NSCalendarUnit.MinuteCalendarUnit |
            NSCalendarUnit.SecondCalendarUnit, fromDate: date)
        
        self.years = dateComponents.year
        self.months = dateComponents.month
        self.days = dateComponents.day
        self.hours = dateComponents.hour
        self.minutes = dateComponents.minute
        self.seconds = dateComponents.second
    }
    
    private func formNSDate() -> NSDate? {
        var calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)
        
        var dateComponents = calendar!.components(NSCalendarUnit.WeekdayOrdinalCalendarUnit, fromDate: NSDate())
        
        dateComponents.year = self.years
        dateComponents.month = self.months
        dateComponents.day = self.days
        dateComponents.hour = self.hours
        dateComponents.minute = self.minutes
        dateComponents.second = self.seconds
        
        return calendar!.dateFromComponents(dateComponents)
    }
    
    private func formatNSDate(formatString: String, date: NSDate) -> String? {
        var dateFormater = NSDateFormatter()
        dateFormater.dateFormat = formatString
        return dateFormater.stringFromDate(date)
    }
    
    func convertToNSDate() -> NSDate? {
        return self.formNSDate()
    }
    
    func formatDate() -> String? {
        return self.formatDate("yyyy MM dd HH:mm:ss")
    }
    
    func formatDate(format: String) -> String? {
        if let dateFormated = self.formNSDate() {
            return self.formatNSDate(format, date: dateFormated)
        }
        return nil
    }
}

extension Tempo {
    
    private func diffAgoFromDate(fromDate: NSDate, toDate: NSDate, isAfter: Bool) -> String? {
        func getDiffSpecificComponent(calendar: NSCalendar, unitComponent: NSCalendarUnit) -> NSDateComponents {
            return (calendar.components(unitComponent,
                fromDate: fromDate, toDate: toDate, options: NSCalendarOptions.allZeros))
        }
        
        let calendarDate = NSCalendar(calendarIdentifier: NSGregorianCalendar)
        let unitComponent = [NSCalendarUnit.SecondCalendarUnit, NSCalendarUnit.MinuteCalendarUnit,
            NSCalendarUnit.HourCalendarUnit, NSCalendarUnit.DayCalendarUnit,
            NSCalendarUnit.MonthCalendarUnit, NSCalendarUnit.YearCalendarUnit]
        var diffComponent = Array<NSDateComponents>()
        var indexComponent = 0
        
        for currentComponent in [ComponentDate.Secondes, ComponentDate.Minutes, ComponentDate.Hours,
            ComponentDate.Days, ComponentDate.Months, ComponentDate.Years] {
            diffComponent.append(getDiffSpecificComponent(calendarDate!, unitComponent[indexComponent]))
            indexComponent++
        }
        
        if (isAfter == true) {
            (diffComponent[0] as NSDateComponents).second *= -1
            (diffComponent[1] as NSDateComponents).minute *= -1
            (diffComponent[2] as NSDateComponents).hour *= -1
            (diffComponent[3] as NSDateComponents).day *= -1
            (diffComponent[4] as NSDateComponents).month *= -1
            (diffComponent[5] as NSDateComponents).year *= -1
        }
        
        switch (diffComponent[0] as NSDateComponents).second {
        case (0...45): return(isAfter == false) ?  ("seconds ago") :  ("in seconds")
        case (45...90): return ("a minute ago")
        case (90...2700): return ("\((diffComponent[1] as NSDateComponents).minute) minutes ago")
        default: Void()
        }
        switch (diffComponent[1] as NSDateComponents).minute {
        case (45...90): return ("an hour ago")
        case (90...1320): return (isAfter == false) ? ("\(((diffComponent[2] as NSDateComponents).hour)) hours ago") :
            ("in \(((diffComponent[2] as NSDateComponents).hour)) hours")
        default: Void()
        }
        switch (diffComponent[2] as NSDateComponents).hour {
        case (22...36): return ("a day ago")
        case (36...600): return(isAfter == false) ? ("\((diffComponent[3] as NSDateComponents).day) days ago") :
            ("in \((diffComponent[3] as NSDateComponents).day) days")
        default: Void()
        }
        switch (diffComponent[3] as NSDateComponents).day {
        case (25...45): return ("a month ago")
        case (45...345): return (isAfter == false) ? ("\((diffComponent[4] as NSDateComponents).month) months ago") :
            ("in \((diffComponent[4] as NSDateComponents).month) months")
        case (345...547): return(isAfter == false) ? ("a year ago") : ("in a year")
        default: Void()
        }
        if ((diffComponent[3] as NSDateComponents).day >= 548) {
            return(isAfter == false) ? ("\((diffComponent[5] as NSDateComponents).year) years ago") :
                ("in \((diffComponent[5] as NSDateComponents).year) years")
        }
        return nil
    }
    
    func timeAgoFromNow() -> String? {
        if let currentDate = self.formNSDate() {
            return self.diffAgoFromDate(currentDate, toDate: NSDate(), isAfter: self.isAfter(Tempo())!)
        }
        return nil
    }
    
    func timeAgoFrom(date: Tempo) -> String? {
        if let currentDate = self.formNSDate() {
            if let testDate = date.convertToNSDate() {
                return self.diffAgoFromDate(currentDate, toDate: testDate, isAfter: self.isAfter(date)!)
            }
        }
        return nil
    }
}

extension Tempo {
    
    private func diffDate(component: ComponentDate, fromDate: NSDate, toDate: NSDate) -> Int {
        let calendarDate = NSCalendar(calendarIdentifier: NSGregorianCalendar)
        
        switch component {
        case .Years: return (calendarDate!.components(NSCalendarUnit.YearCalendarUnit,
            fromDate: fromDate, toDate: toDate, options: NSCalendarOptions.allZeros).year)
        case .Months: return (calendarDate!.components(NSCalendarUnit.MonthCalendarUnit,
            fromDate: fromDate, toDate: toDate, options: NSCalendarOptions.allZeros).month)
        case .Days: return (calendarDate!.components(NSCalendarUnit.DayCalendarUnit,
            fromDate: fromDate, toDate: toDate, options: NSCalendarOptions.allZeros).day)
        case .Hours: return (calendarDate!.components(NSCalendarUnit.HourCalendarUnit,
            fromDate: fromDate, toDate: toDate, options: NSCalendarOptions.allZeros).hour)
        case .Minutes: return (calendarDate!.components(NSCalendarUnit.MinuteCalendarUnit,
            fromDate: fromDate, toDate: toDate, options: NSCalendarOptions.allZeros).minute)
        case .Secondes: return (calendarDate!.components(NSCalendarUnit.SecondCalendarUnit,
            fromDate: fromDate, toDate: toDate, options: NSCalendarOptions.allZeros).second)
        default: return 0
        }
    }
    
    func diff(component: ComponentDate, date: Tempo) -> Int? {
        if let currentDate = self.formNSDate() {
            if let testDate = date.convertToNSDate() {
                return self.diffDate(component, fromDate: currentDate, toDate: testDate)
            }
        }
        return nil
    }
    
    func diffHour(date: Tempo) -> String {
        return "\(self.diff(ComponentDate.Hours, date: date)!)";
    }
}

extension Tempo {
    
    private func getValueDiff(date: Tempo, component: ComponentDate, isAfter: Bool) -> Bool? {
        if let valueDiff = self.diff(component, date: date) {
            if (valueDiff < 0) {
                if (isAfter == false) {
                    return false
                }
                return true
            }
            else if (valueDiff > 0) {
                if (isAfter == false) {
                    return true
                }
                return false
            }
        }
        return nil
    }
    
    private func getValueSame(date: Tempo, component: ComponentDate) -> Bool? {
        if let valueDiff = self.diff(component, date: date) {
            if (valueDiff == 0) {
                return true
            }
            return false
        }
        return nil
    }
    
    
    func isBefore(date: Tempo) -> Bool? {
        return self.getValueDiff(date, component: .Secondes, isAfter: false)
    }
    
    func isBefore(date: Tempo, component: ComponentDate) -> Bool? {
        return self.getValueDiff(date, component: component, isAfter: false)
    }
    
    func isAfter(date: Tempo) -> Bool? {
        return self.getValueDiff(date, component: .Secondes, isAfter: true)
    }
    
    func isAfter(date: Tempo, component: ComponentDate) -> Bool? {
        return self.getValueDiff(date, component: component, isAfter: true)
    }
    
    func isSame(date: Tempo) -> Bool? {
        return self.getValueSame(date, component: .Secondes)
    }
    
    func isSame(date: Tempo, component: ComponentDate) -> Bool? {
        return self.getValueSame(date, component: component)
    }
}

extension Tempo {
    
    private func changeValueDate(component: ComponentDate, value: Int) {
        switch component {
        case .Years: self.years = self.years + value
        case .Months: self.months = self.months + value
        case .Days: self.days = self.days + value
        case .Hours: self.hours = self.hours + value
        case .Minutes: self.minutes = self.minutes + value
        case .Secondes: self.seconds = self.seconds + value
        default: return
        }
    }
    
    func subtract(component: ComponentDate, value: UInt) -> Self {
        self.changeValueDate(component, value: Int(value) * -1)
        return self
    }
    
    func add(component: ComponentDate, value: UInt) -> Self {
        self.changeValueDate(component, value: Int(value))
        return self
    }
}

enum ComponentDate: Int {
    case Years, Months, Days, Hours, Minutes, Secondes
}
