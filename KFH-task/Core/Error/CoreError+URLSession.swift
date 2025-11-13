//
//  CoreError+URLSession.swift
//  KFH-task
//
//  Created by iOSAYed on 13/11/2025.
//

import Foundation

extension CoreError {

    init?(data: Data?, response: URLResponse?, error: Error?) {
        if let error = error as? URLError {
            self = .request(code: "\(error.code)", message: error.localizedDescription)
            return
        }

        if let response = response as? HTTPURLResponse,
            !(200...299).contains(response.statusCode) {
            self = .response(code: "\(response.statusCode)")
            return
        }

        return nil
    }
}
