//
//  DateExtensions.swift
//  Citadel
//
//  Cretated by Shohin Tagev
//  Edited by Yunuskhuja Tuygunkhujaev on 3/16/20.
//

import Foundation

extension Date {
    public static func date(from dateString: String,
                            format: String,
                            locale: Locale = Locale.current) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = locale
        return dateFormatter.date(from: dateString)
    }
    
    public static func turn(dateString: String,
                            fromFormat: String,
                            toFormat: String,
                            locale: Locale = Locale.current) -> String? {
        guard let date = Date.date(from: dateString,
                                   format: fromFormat,
                                   locale: locale) else {
                                    return nil
        }
        
        return date.toString(format: toFormat)
    }
    
    public func toString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    public func dayBeetween(first date1: Date,
                            second date2: Date) -> Int {
        let calendar = NSCalendar.current
        
        // Replace the hour (time) of both dates with 00:00
        let d1 = calendar.startOfDay(for: date1)
        let d2 = calendar.startOfDay(for: date2)
        
        guard let start = calendar.ordinality(of: .day, in: .era, for: d1) else {
            return 0
        }
        
        guard let end = calendar.ordinality(of: .day, in: .era, for: d2) else {
            return 0
        }
        
        return end - start
    }
}

extension Date {
    public var era: Int {
        return self.component(.era)
    }
    
    public var year: Int {
        return self.component(.year)
    }
    
    public var month: Int {
        return self.component(.month)
    }
    
    public var day: Int {
        return self.component(.day)
    }
    
    public var hour: Int {
        return self.component(.hour)
    }
    
    public var minute: Int {
        return self.component(.minute)
    }
    
    public var second: Int {
        return self.component(.second)
    }
    
    public var weekday: Int {
        return self.component(.weekday)
    }
    
    public var weekdayOrdinal: Int {
        return self.component(.weekdayOrdinal)
    }
    
    public var quarter: Int {
        return self.component(.quarter)
    }
    
    public var weekOfMonth: Int {
        return self.component(.weekOfMonth)
    }
    
    public var weekOfYear: Int {
        return self.component(.weekOfYear)
    }
    
    public var yearForWeekOfYear: Int {
        return self.component(.yearForWeekOfYear)
    }
    
    public var nanosecond: Int {
        return self.component(.nanosecond)
    }
    
    public var calendar: Int {
        return self.component(.calendar)
    }
    
    public var timeZone: Int {
        return self.component(.timeZone)
    }
    
    private func component(_ component: Calendar.Component) -> Int {
        return Calendar.current.component(component, from: self)
    }
    
    public func startOfMonth() -> Date? {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))
    }
    
    public func endOfMonth() -> Date? {
        guard let start = self.startOfMonth() else {
            return nil
        }
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: start)
    }
}

extension Date {
    /// Returns the amount of years from another date
    public func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    public func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    public func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfYear], from: date, to: self).weekOfYear ?? 0
    }
    /// Returns the amount of days from another date
    public func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    public func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    public func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    public func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    /// Returns the a custom time interval description from another date
    public func offset(from date: Date) -> String {
        if years(from: date)   > 0 { return "\(years(from: date))y"   }
        if months(from: date)  > 0 { return "\(months(from: date))M"  }
        if weeks(from: date)   > 0 { return "\(weeks(from: date))w"   }
        if days(from: date)    > 0 { return "\(days(from: date))d"    }
        if hours(from: date)   > 0 { return "\(hours(from: date))h"   }
        if minutes(from: date) > 0 { return "\(minutes(from: date))m" }
        if seconds(from: date) > 0 { return "\(seconds(from: date))s" }
        return ""
    }
    
    public func offsetLong(from date: Date) -> String {
        if years(from: date)   > 0 { return years(from: date) > 1 ? "\(years(from: date)) years ago" : "\(years(from: date)) year ago" }
        if months(from: date)  > 0 { return months(from: date) > 1 ? "\(months(from: date)) months ago" : "\(months(from: date)) month ago" }
        if weeks(from: date)   > 0 { return weeks(from: date) > 1 ? "\(weeks(from: date)) weeks ago" : "\(weeks(from: date)) week ago"   }
        if days(from: date)    > 0 { return days(from: date) > 1 ? "\(days(from: date)) days ago" : "\(days(from: date)) day ago" }
        if hours(from: date)   > 0 { return hours(from: date) > 1 ? "\(hours(from: date)) hours ago" : "\(hours(from: date)) hour ago"   }
        if minutes(from: date) > 0 { return minutes(from: date) > 1 ? "\(minutes(from: date)) minutes ago" : "\(minutes(from: date)) minute ago" }
        if seconds(from: date) > 0 { return seconds(from: date) > 1 ? "\(seconds(from: date)) seconds ago" : "\(seconds(from: date)) second ago" }
        return "recently"
    }
}

extension Date {
    public func weekDay() -> Int {
        let weekday = Calendar.current.component(.weekday, from: self)
        return weekday
    }
    
    public func dayOfTheWeek() -> String? {
        let weekdays = [
            "Sunday",
            "Monday",
            "Tuesday",
            "Wednesday",
            "Thursday",
            "Friday",
            "Satudrday,"
        ]
        
        return weekdays[self.weekDay() - 1]
    }
    
    public static func datePeriod(from date: Date) -> String {
        let diff: TimeInterval = Date().timeIntervalSince(date)
        var period = "recently"
        if diff < 60 { //small from minute
            period = "\(Int(diff)) seconds ago"
        } else if diff < 3600 { //small from hour
            let min = Int(round(Double(diff / 60)))
            if min <= 1 {
                period = "a minute ago"
            } else {
                period = "\(min) minutes ago"
            }
        } else if diff < 86400 { //small from a day
            let h = Int(round(Double(diff / 3600)))
            if h <= 1 {
                period = "an hour ago"
            } else {
                period = "\(h) hours ago"
            }
        } else if diff < 604800 { // small from a week
            let d = Int(round(Double(diff / 86400)))
            if d <= 1 {
                period = "a day ago"
            } else {
                period = "\(d) days ago"
            }
        } else {
            period = date.toString(format: "EEEE, hh:mm a")
        }
        
        return period
    }
}

extension Date {
    public func timeIsBetween(from: String, to: String) -> Bool {
        let date  = self
        let startString = from
        let endString   = to
        
        // convert strings to `NSDate` objects
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        guard let startTime = formatter.date(from: startString),
            let endTime = formatter.date(from: endString) else {
                return false
        }
        
        // extract hour and minute from those `NSDate` objects
        
        let calendar = NSCalendar.current
        
        var startComponents = calendar.dateComponents([.hour, .minute], from: startTime)
        var endComponents = calendar.dateComponents([.hour, .minute], from: endTime)
        
        // extract day, month, and year from `todaysDate`
        
        let nowComponents = calendar.dateComponents([.month, .day, .year], from: date)
        
        // adjust the components to use the same date
        
        startComponents.year  = nowComponents.year
        startComponents.month = nowComponents.month
        startComponents.day   = nowComponents.day
        
        endComponents.year  = nowComponents.year
        endComponents.month = nowComponents.month
        endComponents.day   = nowComponents.day
        
        // combine hour/min from date strings with day/month/year of `todaysDate`
        
        let startDate = calendar.date(from: startComponents)
        let endDate = calendar.date(from: endComponents)
        
        // now we can see if today's date is inbetween these two resulting `NSDate` objects
        
        let isInRange = date.compare(startDate!) != .orderedAscending && date.compare(endDate!) != .orderedDescending
        return isInRange
    }
}

extension Date {
    public func dayNumberOfWeek() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday
    }
    
    public func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).capitalized
    }
}
