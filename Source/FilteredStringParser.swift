//
//  FilteredStringParser.swift
//  FilteredString
//
//  Created by Adrian Bobrowski on 28.05.2017.
//
//

import Foundation

struct FilteredStringParser {

    private(set) var value = ""
    private(set) var filters = [(String, [CVarArg])]()

    public init(_ rawText: String) {
        self.filters = self.parseFilters(rawText)
        self.value = self.parseString(self.filters.first?.0 ?? "")
        self.filters[0] = ("", self.filters[0].1)
    }

    private func parseFilters(_ text: String) -> [(String, [CVarArg])] {
        return self.separate(text: text, by: "|").map { self.parseFilter($0) }
    }

    private func parseFilter(_ text: String) -> (String, [CVarArg]) {
        let parts = self.separate(text: text, by: "(")
        let parameters = self.separate(text: (parts.count == 1) ? "" : parts[1], by: ")").first!
        return (parts[0], self.parseParameters(parameters))
    }

    private func parseParameters(_ text: String) -> [CVarArg] {
        guard !self.trimWhitespaces(text).isEmpty else {
            return []
        }
        let rawParameters = self.separate(text: text, by: ",")
        return rawParameters.map { self.parseParameter($0) }
    }

    private func parseParameter(_ text: String) -> CVarArg {
        let rawValue = self.trimWhitespaces(text)
        if let numericValue = Double(rawValue) {
            return rawValue.contains(".") ? numericValue : Int(numericValue)
        }
        return self.parseString(rawValue)
    }

    private func parseString(_ text: String) -> String {
        var buffer = ""
        var isEncapsulate = false

        text.characters.forEach { char in
            if isEncapsulate {
                isEncapsulate = false
            } else {
                if char == "\\" {
                    isEncapsulate = true
                    return
                }
                if char == "\"" {
                    return
                }
            }
            buffer.append(char)
        }
        return buffer
    }

    private func trimWhitespaces(_ text: String) -> String {
        return text.trimmingCharacters(in: CharacterSet.whitespaces)
    }

    private func separate(text: String, by separator: Character) -> [String] {
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
