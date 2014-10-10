//
//  StringExtension.swift
//  Algorithems
//
//  Created by Ce YANG on 10/10/2014.
//  Copyright (c) 2014 Ce Yang Studio. All rights reserved.
//

import Foundation

extension String {
    subscript (i:Int) -> String {
        return String(Array(self)[i])
    }
    //String with range
    subscript (r: Range<Int>) -> String {
        get {
            let startIndex = advance(self.startIndex, r.startIndex)
            let endIndex = advance(startIndex, r.endIndex - r.startIndex)
            
            return self[Range(start: startIndex, end: endIndex)]
        }
    }
}
