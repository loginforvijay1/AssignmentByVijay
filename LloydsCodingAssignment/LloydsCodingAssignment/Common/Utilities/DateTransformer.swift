//
//  DateTransformer.swift
//  LloydsCodingAssignment
//
//  Created by Vemireddy Vijayasimha Reddy on 02/01/24.
//

import Foundation

struct DateTransformer {
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_US")
        return formatter
    }()

    static func transform(_ decoded: String) -> Date {
        return Self.dateFormatter.date(from: decoded) ?? Date(timeIntervalSince1970: 0)
    }
}

extension DateFormatter {
    static private let customDateFormatter = DateFormatter()
    static func string(from date: Date, format: String) -> String {
        customDateFormatter.dateFormat = format
        return customDateFormatter.string(from: date)
    }
}
