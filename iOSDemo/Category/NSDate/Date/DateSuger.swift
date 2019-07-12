//
//  DateSuger.swift
//  iOSDemo
//
//  Created by Wuxi on 2019/7/12.
//  Copyright © 2019 Wuxi. All rights reserved.
//

import Foundation
enum DSDateComponentType {
    case era
    case year
    case month
    case day
    case hour
    case minute
    case second
    case quarter
    case weekday
    case weekdayOrdinal
    case weekOfMonth
    case weekOfYear
    case dayOfYear
}

//MARK: - Default Values

let DefaultCalendar = Calendar(identifier: Calendar.Identifier.gregorian)
let AllCalendarUnits: NSCalendar.Unit = [
    .era,
    .year,
    .quarter,
    .month,
    .day,
    .hour,
    .minute,
    .second,
    .weekOfYear,
    .weekOfMonth,
    .weekday,
    .weekdayOrdinal,
]


extension Date {
    init?(format: String, dateString: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        if let date = formatter.date(from: dateString) {
            self = date
        } else {
            return nil
        }
    }
}

// MARK: - Date Components
extension Date {
    public var era: Int {
        return componentForType(.era, calendar: nil)
    }
    public var year: Int {
        return componentForType(.year, calendar: nil)
    }
    public var month: Int {
        return componentForType(.month, calendar: nil)
    }
    public var day: Int {
        return componentForType(.day, calendar: nil)
    }
    public var hour: Int {
        return componentForType(.hour, calendar: nil)
    }
    public var minute: Int {
        return componentForType(.minute, calendar: nil)
    }
    public var second: Int {
        return componentForType(.second, calendar: nil)
    }
    public var quarter: Int {
        return componentForType(.quarter, calendar: nil)
    }
    public var weekday: Int {
        return componentForType(.weekday, calendar: nil)
    }
    public var weekdayOrdinal: Int {
        return componentForType(.weekdayOrdinal, calendar: nil)
    }
    public var weekOfMonth: Int {
        return componentForType(.weekOfMonth, calendar: nil)
    }
    public var weekOfYear: Int {
        return componentForType(.weekOfYear, calendar: nil)
    }
    public var dayOfYear: Int {
        return componentForType(.dayOfYear, calendar: nil)
    }
    public func era(withCalendar calendar: Calendar) -> Int {
        return componentForType(.era, calendar: calendar)
    }
    public func year(withCalendar calendar: Calendar) -> Int {
        return componentForType(.year, calendar: calendar)
    }
    public func month(withCalendar calendar: Calendar) -> Int {
        return componentForType(.month, calendar: calendar)
    }
    public func day(withCalendar calendar: Calendar) -> Int {
        return componentForType(.day, calendar: calendar)
    }
    public func hour(withCalendar calendar: Calendar) -> Int {
        return componentForType(.hour, calendar: calendar)
    }
    public func minute(withCalendar calendar: Calendar) -> Int {
        return componentForType(.minute, calendar: calendar)
    }
    public func second(withCalendar calendar: Calendar) -> Int {
        return componentForType(.second, calendar: calendar)
    }
    public func quarter(withCalendar calendar: Calendar) -> Int {
        return componentForType(.quarter, calendar: calendar)
    }
    public func weekday(withCalendar calendar: Calendar) -> Int {
        return componentForType(.weekday, calendar: calendar)
    }
    public func weekdayOrdinal(withCalendar calendar: Calendar) -> Int {
        return componentForType(.weekdayOrdinal, calendar: calendar)
    }
    public func weekOfMonth(withCalendar calendar: Calendar) -> Int {
        return componentForType(.weekOfMonth, calendar: calendar)
    }
    public func weekOfYear(withCalendar calendar: Calendar) -> Int {
        return componentForType(.weekOfYear, calendar: calendar)
    }
    public func dayOfYear(withCalendar calendar: Calendar) -> Int {
        return componentForType(.dayOfYear, calendar: calendar)
    }
    func componentForType(_ type: DSDateComponentType, calendar: Calendar?) -> Int {
        var myCalender = calendar
        if myCalender == nil {
            myCalender = DefaultCalendar
        }
        let dateComponents = (myCalender! as NSCalendar).components(AllCalendarUnits, from: self)
        
        switch type {
        case .era:
            return dateComponents.era!
        case .year:
            return dateComponents.year!
        case .month:
            return dateComponents.month!
        case .day:
            return dateComponents.day!
        case .hour:
            return dateComponents.hour!
        case .minute:
            return dateComponents.minute!
        case .second:
            return dateComponents.second!
        case .quarter:
            return dateComponents.quarter!
        case .weekday:
            return dateComponents.weekday!
        case .weekdayOrdinal:
            return dateComponents.weekdayOrdinal!
        case .weekOfMonth:
            return dateComponents.weekOfMonth!
        case .weekOfYear:
            return dateComponents.weekOfYear!
        case .dayOfYear:
            return (calendar! as NSCalendar).ordinality(of: .day, in: .year, for: self)
        }
    }
}

// MARK: - Other Infomation
extension Date {
    public var daysInMonth: Int {
        let calendar = DefaultCalendar
        let days = (calendar as NSCalendar).range(of: .day, in: .month, for: self)
        return days.length
    }
    public var daysInYear: Int {
        if self.isInLeapYear {
            return 366
        }
        return 365
    }
    public var isInLeapYear: Bool {
        let dateComponents = (DefaultCalendar as NSCalendar).components(.year, from: self)
        if dateComponents.year! % 400 == 0 {
            return true
        }
        else if dateComponents.year! % 100 == 0 {
            return false
        }
        else if dateComponents.year! % 4 == 0 {
            return true
        }
        return false
    }
    public var isToday: Bool {
        return self.isSameDay(Date())
    }
    public var isTomorrow: Bool {
        let tomorrow = Date() + .day(1)
        return self.isSameDay(tomorrow)
    }
    public var isYesterday: Bool {
        let yesterday = Date() - .day(1)
        return self.isSameDay(yesterday)
    }
    public func isSameDay(_ date: Date) -> Bool {
        return Date.isSameDay(self, asDate: date)
    }
    public static func isSameDay(_ date: Date, asDate otherDate: Date) -> Bool {
        let firstComp = (DefaultCalendar as NSCalendar).components([.era,.year,.month,.day], from: date)
        let secondComp = (DefaultCalendar as NSCalendar).components([.era,.year,.month,.day], from: otherDate)
        
        let firstDate = DefaultCalendar.date(from: firstComp)!
        let secondDate = DefaultCalendar.date(from: secondComp)!
        
        return (firstDate == secondDate)
    }
}
// MARK: - Date Creating
extension Date {
    public static func dateWithYear(_ year: Int, month: Int, day: Int) -> Date? {
        return dateWithYear(year, month: month, day: day, hour: 0, minute: 0, second: 0)
    }
    public static func dateWithYear(_ year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int) -> Date? {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        components.minute = minute
        components.second = second
        
        return DefaultCalendar.date(from: components)
    }
}
// MARK: - Date Editing
extension Date {
    public func dateByAddingYears(_ years: Int) -> Date {
        var components = DateComponents()
        components.year = years
        
        return (DefaultCalendar as NSCalendar).date(byAdding: components, to: self, options: [])!
    }
    public func dateByAddingMonths(_ months: Int) -> Date {
        var components = DateComponents()
        components.month = months
        
        return (DefaultCalendar as NSCalendar).date(byAdding: components, to: self, options: [])!
    }
    public func dateByAddingWeeks(_ weeks: Int) -> Date {
        var components = DateComponents()
        components.weekOfYear = weeks
        
        return (DefaultCalendar as NSCalendar).date(byAdding: components, to: self, options: [])!
    }
    public func dateByAddingDays(_ days: Int) -> Date {
        var components = DateComponents()
        components.day = days
        
        return (DefaultCalendar as NSCalendar).date(byAdding: components, to: self, options: [])!
    }
    public func dateByAddingHours(_ hours: Int) -> Date {
        var components = DateComponents()
        components.hour = hours
        
        return (DefaultCalendar as NSCalendar).date(byAdding: components, to: self, options: [])!
    }
    public func dateByAddingMinutes(_ minutes: Int) -> Date {
        var components = DateComponents()
        components.minute = minutes
        
        return (DefaultCalendar as NSCalendar).date(byAdding: components, to: self, options: [])!
    }
    public func dateByAddingSeconds(_ seconds: Int) -> Date {
        var components = DateComponents()
        components.second = seconds
        
        return (DefaultCalendar as NSCalendar).date(byAdding: components, to: self, options: [])!
    }
    public func dateBySubtractingYears(_ years: Int) -> Date {
        return dateByAddingYears(-years)
    }
    public func dateBySubtractingMonths(_ months: Int) -> Date {
        return dateByAddingMonths(-months)
    }
    public func dateBySubtractingWeeks(_ weeks: Int) -> Date {
        return dateByAddingWeeks(-weeks)
    }
    public func dateBySubtractingDays(_ days: Int) -> Date {
        return dateByAddingDays(-days)
    }
    public func dateBySubtractingHours(_ hours: Int) -> Date {
        return dateByAddingHours(-hours)
    }
    public func dateBySubtractingMinutes(_ minutes: Int) -> Date {
        return dateByAddingMinutes(-minutes)
    }
    public func dateBySubtractingSeconds(_ seconds: Int) -> Date {
        return dateByAddingSeconds(-seconds)
    }
}

// MARK: - Interval
extension Date {
    public static func yearsFrom(_ date: Date, toDate: Date) -> Int {
        let components = (DefaultCalendar as NSCalendar).components(.year, from: date, to: toDate, options: [])
        return components.year!
    }
    public static func monthsFrom(_ date: Date, toDate: Date) -> Int {
        let components = (DefaultCalendar as NSCalendar).components(.month, from: date, to: toDate, options: [])
        return components.month!
    }
    public static func weeksFrom(_ date: Date, toDate: Date) -> Int {
        let components = (DefaultCalendar as NSCalendar).components(.weekOfYear, from: date, to: toDate, options: [])
        return components.weekOfYear!
    }
    public static func daysFrom(_ date: Date, toDate: Date) -> Int {
        let components = (DefaultCalendar as NSCalendar).components(.day, from: date, to: toDate, options: [])
        return components.day!
    }
    public static func hoursFrom(_ date: Date, toDate: Date) -> Int {
        let components = (DefaultCalendar as NSCalendar).components(.hour, from: date, to: toDate, options: [])
        return components.hour!
    }
    public static func minutesFrom(_ date: Date, toDate: Date) -> Int {
        let components = (DefaultCalendar as NSCalendar).components(.minute, from: date, to: toDate, options: [])
        return components.minute!
    }
    public static func secondsFrom(_ date: Date, toDate: Date) -> Int {
        let components = (DefaultCalendar as NSCalendar).components(.second, from: date, to: toDate, options: [])
        return components.second!
    }
    
    public func yearsFrom(_ date: Date) -> Int{
        return Date.yearsFrom(date, toDate: self)
    }
    public func monthsFrom(_ date: Date) -> Int {
        return Date.monthsFrom(date, toDate: self)
    }
    public func weeksFrom(_ date: Date) -> Int {
        return Date.weeksFrom(date, toDate: self)
    }
    public func daysFrom(_ date: Date) -> Int {
        return Date.daysFrom(date, toDate: self)
    }
    public func hoursFrom(_ date: Date) -> Int {
        return Date.hoursFrom(date, toDate: self)
    }
    public func minutesFrom(_ date: Date) -> Int {
        return Date.minutesFrom(date, toDate: self)
    }
    public func secondsFrom(_ date: Date) -> Int {
        return Date.secondsFrom(date, toDate: self)
    }
}
