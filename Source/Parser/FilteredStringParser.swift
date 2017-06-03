//
//  FilteredStringParser.swift
//  FilteredString
//
//  Created by Adrian Bobrowski on 28.05.2017.
//  Copyright © 2017 Coding lifestyle. All rights reserved.
//

import Foundation

public protocol FilteredStringParser {

    func parse(_ text: String) -> Result
}

public extension FilteredStringParser {

    public typealias Filter = (name: String, arguments: [CVarArg])

    public typealias Result = (text: String, arguments: [CVarArg], filters: [Filter])
}
