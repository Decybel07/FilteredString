//
//  DefaultFilteredStringParser.swift
//  FilteredString
//
//  Created by Adrian Bobrowski on 03.06.2017.
//  Copyright © 2017 Coding lifestyle. All rights reserved.
//

import Foundation

open class DefaultFilteredStringParser: FilteredStringParser {

    open func parse(_ text: String) -> Result {
        var filters = self.parseFilters(text)
        let (base, arguments) = filters.remove(at: 0)
        return (text: base, arguments: arguments, filters: filters)
    }

    public func parseFilters(_ text: String) -> [Filter] {
        return self.separate(text: text, by: "|").map { self.parseFilter($0) }
    }

    open func parseFilter(_ text: String) -> Filter {
        let parts = self.separate(text: text, by: "(")
        let parameters = self.separate(text: (parts.count == 1) ? "" : parts[1], by: ")").first!
        return (parts[0], self.parseParameters(parameters))
    }

    public func parseParameters(_ text: String) -> [CVarArg] {
        guard !text.trimmingCharacters(in: CharacterSet.whitespaces).isEmpty else {
            return []
        }
        let rawParameters = self.separate(text: text, by: ",")
        return rawParameters.map { self.parseParameter($0.trimmingCharacters(in: CharacterSet.whitespaces)) }
    }

    open func parseParameter(_ text: String) -> CVarArg {
        if let numericValue = Double(text) {
            return text.contains(".") ? numericValue : Int(numericValue)
        }
        return self.parseString(text)
    }

    public func parseString(_ text: String) -> String {
        var buffer = ""
        var isEncapsulate = false

        text.characters.forEach { char in
            if isEncapsulate {
                isEncapsulate = false
            } else if char == "\\" {
                isEncapsulate = true
                return
            } else if char == "\"" {
                return
            }
            buffer.append(char)
        }
        return buffer
    }

    public func separate(text: String, by separator: Character) -> [String] {
        var components = [String]()
        var buffer = ""
        var isEncapsulate = false
        var isString = false

        text.characters.forEach { char in
            if isEncapsulate {
                isEncapsulate = false
            } else if char == "\\" {
                isEncapsulate = true
            } else if char == "\"" {
                isString = !isString
            } else if !isString && char == separator {
                components.append(buffer)
                buffer = ""
                return
            }
            buffer.append(char)
        }
        components.append(buffer)
        return components
    }
}
