//
//  FilteredString.swift
//  FilteredString
//
//  Created by Adrian Bobrowski on 17.05.2017.
//  Copyright © 2017 Coding lifestyle. All rights reserved.
//

import Foundation

public class FilteredString {

    let text: String
    let arguments: [CVarArg]
    let filters: [FilteredStringParser.Filter]

    public init(_ text: String, parser: FilteredStringParser = DefaultFilteredStringParser()) {
        (self.text, self.arguments, self.filters) = parser.parse(text)
    }
}

extension FilteredString: CustomStringConvertible {

    public func description(using filterManager: StringFilterManager = .default) -> String {
        var result = filterManager.baseFilter.filter(text: self.text, with: self.arguments)
        self.filters.forEach { filter in
            result = filterManager[filter.name].filter(text: result, with: filter.arguments)
        }
        return result
    }

    public var description: String {
        return self.description()
    }
}
