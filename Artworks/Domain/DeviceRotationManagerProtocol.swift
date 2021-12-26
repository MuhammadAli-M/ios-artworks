//
//  DeviceRotationManagerProtocol.swift
//  Artworks
//
//  Created by Muhammad Adam on 25/12/2021.
//

import Foundation

protocol DeviceRotationManagerProtocol{
    typealias DeviceRotationHandler = (Result<Double, Error>) -> Void
    var updateInterval: TimeInterval { get set}
    func startUpdates(to queue: OperationQueue, withHandler handler: @escaping DeviceRotationHandler)
    func stopUpdates()
}

enum DeviceRotationManagerError: Error{
    case failedToGetData
}
