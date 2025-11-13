//
//  DataSourceProtocol.swift
//  KFH-task
//
//  Created by iOSAYed on 13/11/2025
//

protocol DataSourceProtocol {
    func getData<T: Codable>(endpoint: EndpointProtocol, completion:  @escaping (Result<T, CoreError>) -> Void)
}