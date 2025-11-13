//
//  Data+Extension.swift
//  KFH-task
//
//  Created by iOSAYed on 13/11/2025.
//

import Foundation

extension Data {
    func decoded<T: Decodable>() -> T? {
        let decoder = JSONDecoder()
        return try? decoder.decode(T.self, from: self)
    }
}
