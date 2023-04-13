//
//  Date+Extension.swift
//  MovieApp
//
//  Created by FVHG4CV1Q05D on 13/04/2023.
//

import UIKit
public extension Date {
    static var defaultFormat: DateFormat {
        return DateFormat.isoDate
    }
    
    static var defaultFormatter: DateFormatter {
        let defaultFormatter = dateFormatter(using: defaultFormat)
        defaultFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        return defaultFormatter
    }
    
    static func dateFormatter(using format: DateFormat) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale =  Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = format.value
        
        return dateFormatter
    }
    
    /// Convert String to Date
      /// - Parameter dateString: Date in string format.
      /// - Parameter format: Format to cast string into date.
      /// - Returns: Formatted Date.
    static func date(using string: String, and format: DateFormat = .isoDate) -> Date? {
          if let originalDate = defaultFormatter.date(from: string) {
              let formatter = dateFormatter(using: format)
              return formatter.date(from: formatter.string(from: originalDate))
          }
          
          return nil
      }
    
    /// Convert String to year
      /// - Parameter dateString: Date in string format.
      /// - Parameter format: Format to cast string into date.
      /// - Returns: year.
    static func getYear(using date: String, and format: DateFormat = .isoDate) -> Int? {
        guard let date = Date.date(using: date, and: format) else{
            return nil
        }
        let components = date.get(.year)
        return components
    }
    
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}

public enum DateFormat {
    case isoTime
    case isoDate
    case isoDateStandard
    case isoDateTime
    case isoDateTime24
    case notification
    case shortDate
    case shortDateTime
    case standard
    case timestampInMillisecond
    case custom(String)
    
    internal var value: String {
        switch self {
        case .isoTime:
            return "hh:mm a"
        case .isoDate:
            return "yyyy-MM-dd"
        case .isoDateStandard:
            return "dd/MM/YYYY"
        case .isoDateTime:
            return "yyyy-MM-dd hh:mm a"
        case .isoDateTime24:
            return "yyyy-MM-dd kk:mm:ss"
        case .notification:
            return "MMM dd, hh:mm a"
        case .shortDate:
            return "E, MMM dd, yyyy"
        case .shortDateTime:
            return "E, MMM dd, yyyy hh:mm a"
        case .standard:
            return "EEEE, MMM dd, yyyy hh:mm a"
        case .timestampInMillisecond:
            return "yyyy-MM-dd H:m:ss.SSSS"
        case .custom(let type):
            return type
        }
    }
}
