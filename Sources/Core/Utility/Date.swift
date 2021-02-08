//
//  File.swift
//  
//
//  Created by Damodar, Namala (623-Extern) on 08/02/21.
//

import Foundation

public extension Date {
    func days(between otherDate: Date) -> Int {
        let calendar = Calendar.current

        let startOfSelf = calendar.startOfDay(for: self)
        let startOfOther = calendar.startOfDay(for: otherDate)
        let components = calendar.dateComponents([.day], from: startOfSelf, to: startOfOther)

        return abs(components.day ?? 0)
    }

    static var today: String {
        let today = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "E, dd MMM yyyy"
        return formatter.string(from: today)
    }

     func date(with formate: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, dd MMM yyyy"
        return formatter.string(from: self)
    }

    func dateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, dd MMM yyyy"
        return formatter.string(from: self)
    }

    static func after(days: Int) -> TimeInterval {
        var dayComponent    = DateComponents()
        dayComponent.day    = days // For removing one day (yesterday): -1
        let theCalendar     = Calendar.current
        guard let date = theCalendar.date(byAdding: dayComponent,
                                          to: Date())
        else { return Date().timeIntervalSince1970}
        return date.timeIntervalSince1970
    }
}
