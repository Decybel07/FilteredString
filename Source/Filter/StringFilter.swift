//
//  StringFilter.swift
//  FilteredString
//
//  Created by Adrian Bobrowski on 29.05.2017.
//  Copyright © 2017 Coding lifestyle. All rights reserved.
//

public protocol StringFilter {

    func filter(text: String, with arguments: [CVarArg]) -> String
}
