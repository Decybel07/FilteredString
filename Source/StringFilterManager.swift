//
//  StringFilterManager.swift
//  FilteredString
//
//  Created by Adrian Bobrowski on 29.05.2017.
//  Copyright © 2017 Coding lifestyle. All rights reserved.
//

import Foundation

public class StringFilterManager {

    private static let skipFilter = ClosureStringFilter({ $0.0 })

    public var defaultFilter: StringFilter = StringFilterManager.skipFilter

    private var filters: [String: StringFilter] = [:]

    public var baseFilter: StringFilter = StringFilterManager.skipFilter

    public subscript(key: String) -> StringFilter {
        get {
            guard let filter = self.filters[key] else {

                #if DEBUG
                    print("[WARNING] FilteredString - filter \"\(key)\" does not exist")
                #endif

                return StringFilterManager.skipFilter
            }

            return filter
        }
        set(newValue) {
            self.filters[key] = newValue
        }
    }

    public init(filters: [String: StringFilter] = [:]) {
        self.filters = filters
    }
}

extension StringFilterManager {

    public static let `default` = StringFilterManager()
}
