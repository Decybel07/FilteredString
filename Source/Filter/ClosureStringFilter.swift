//
//  ClosureStringFilter.swift
//  FilteredString
//
//  Created by Adrian Bobrowski on 03.06.2017.
//  Copyright © 2017 Coding lifestyle. All rights reserved.
//

public class ClosureStringFilter: StringFilter {

    private let closure: (String, [CVarArg]) -> String

    public init(_ closure: @escaping (String, [CVarArg]) -> String) {
        self.closure = closure
    }

    public func filter(text: String, with arguments: [CVarArg]) -> String {
        return self.closure(text, arguments)
    }
}
