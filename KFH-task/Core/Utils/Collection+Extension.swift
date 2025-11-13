//
//  Collection+Extension.swift
//  KFH-task
//
//  Created by iOSAYed on 13/11/2025.
//

public extension Collection where Indices.Iterator.Element == Index {

    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
