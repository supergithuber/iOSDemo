//
//  DateOperators.swift
//  iOSDemo
//
//  Created by Wuxi on 2019/7/12.
//  Copyright © 2019 Wuxi. All rights reserved.
//

import Foundation
// MARK: - Calculation
public func + (left: Date, right: TimeInterval) -> Date {
    return Date(timeInterval: right, since: left)
}
public func - (left: Date, right: TimeInterval) -> Date {
    return Date(timeInterval: -right, since: left)
}

public enum DateCane {
    case year(Int)
    case month(Int)
    case week(Int)
    case day(Int)
    case hour(Int)
    case minute(Int)
    case second(Int)
}

public func + (left: Date, right: DateCane) -> Date {
    switch right {
        
    case .year(let years):
        return left.dateByAddingYears(years)
    case .month(let months):
        return left.dateByAddingMonths(months)
    case .week(let weeks):
        return left.dateByAddingWeeks(weeks)
    case .day(let days):
        return left.dateByAddingDays(days)
    case .hour(let hours):
        return left.dateByAddingHours(hours)
    case .minute(let minutes):
        return left.dateByAddingMinutes(minutes)
    case .second(let seconds):
        return left.dateByAddingSeconds(seconds)
    }
}
public func - (left: Date, right: DateCane) -> Date {
    switch right {
    case .year(let years):
        return left.dateBySubtractingYears(years)
    case .month(let months):
        return left.dateBySubtractingMonths(months)
    case .week(let weeks):
        return left.dateBySubtractingWeeks(weeks)
    case .day(let days):
        return left.dateBySubtractingDays(days)
    case .hour(let hours):
        return left.dateBySubtractingHours(hours)
    case .minute(let minutes):
        return left.dateBySubtractingMinutes(minutes)
    case .second(let seconds):
        return left.dateBySubtractingSeconds(seconds)
    }
}
