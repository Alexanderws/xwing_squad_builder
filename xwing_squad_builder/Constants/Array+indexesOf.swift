//
//  Array+indexesOf.swift
//  xwing_squad_builder
//
//  Created by Alexander on 04/01/2018.
//  Copyright © 2018 Alexander. All rights reserved.
//

import Foundation

extension Array {
    func indexesOf<T : Equatable>(object:T) -> [Int] {
        var result: [Int] = []
        for (index,obj) in enumerated() {
            if obj as! T == object {
                result.append(index)
            }
        }
        return result
    }
}
