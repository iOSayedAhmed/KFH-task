//
//  LocalDataSourceProtocol.swift
//  KFH-task
//
//  Created by iOSAYed on 13/11/2025
//

protocol LocalDataSourceProtocol: DataSourceProtocol {
    func saveData<T: Codable>(endpoint: EndpointProtocol, data: T, completion: @escaping (Result<T, CoreError>) -> Void)
    func removeData(with endpoint: EndpointProtocol, completion: @escaping () -> Void)
}