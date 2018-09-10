//
//  Pattern.swift
//  Instagrid
//
//  Created by AMIMOBILE on 24/08/2018.
//  Copyright © 2018 lehuong. All rights reserved.
//

import Foundation

enum Pattern {
    case one
    case two
    case three
    
    var display: [Bool] {
        switch self {
        case .one:
            return [false, true, false, false]
        case .two:
            return [false, false, false, true]
        case .three:
            return [false, false, false, false]
        }
    }
}


