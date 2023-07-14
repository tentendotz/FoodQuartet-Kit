//
//  DateFormatter+MonthName.swift
//  FoodQuartet-Kit
//
//  Created by tetsuta matsuyama on 2023/07/14.
//

import Foundation

extension DateFormatter {
    
    /// Returns the full name of the month for the given month number.
    /// - The `monthNumber` should be between 1 and 12 (inclusive).
    ///   If the `monthNumber` is out of range, a fatalError is raised.
    /// - Note: The month names are localized based on the current locale.
    static func fullNameOfMonth(from monthNumber: Int) -> String {
        guard (1...12).contains(monthNumber) else { fatalError("Error getting month string, '\(monthNumber)' is out of range.") }
        // 1...12 ~= monthNumber is true.
        let formatter = DateFormatter()
        formatter.locale = .autoupdatingCurrent
        
        let monthName = formatter.standaloneMonthSymbols[monthNumber - 1]
        return monthName
    }
}
