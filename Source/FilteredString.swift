//
//  FilteredString.swift
//  FilteredString
//
//  Created by Adrian Bobrowski on 17.05.2017.
//
//

import Foundation

public class FilteredString {

    public init(_ text: String) {
        let parser = FilteredStringParser(text)

        print(parser.value)
        print(parser.filters)
    }
}
