//
//  DefaultDeviceRotationManager.swift
//  Artworks
//
//  Created by Muhammad Adam on 25/12/2021.
//

import Foundation
import CoreMotion

class DefaultDeviceRotationManager{
    private let motionManager = CMMotionManager()
}

extension DefaultDeviceRotationManager: DeviceRotationManagerProtocol{
    func stopUpdates() {
        motionManager.stopDeviceMotionUpdates()
    }
    
    var updateInterval: TimeInterval {
        get {
            return motionManager.deviceMotionUpdateInterval
        }
        set {
            motionManager.deviceMotionUpdateInterval = newValue
        }
    }

    func startUpdates(to queue: OperationQueue, withHandler handler: @escaping DeviceRotationHandler){
        if motionManager.isDeviceMotionAvailable {
            motionManager.startDeviceMotionUpdates(to: queue) { data, error in
                
                guard let data = data else {
                    errorLog("nil")
                    handler(.failure(DeviceRotationManagerError.failedToGetData))
                    return
                }
                
//                print("grav x: \(data.gravity.x), y: \(data.gravity.y), z: \(data.gravity.z)")
                let rotationAroundZ = atan2(data.gravity.x, data.gravity.y) + .pi

                print("rotationz: \(rotationAroundZ.fromRadToDeg()) •")
                
                
                // TODO: Enhance the commented condition reset the rotationAroundZ in case of the rotationAroundX out of vertical by 30 degrees
//                if (90-30...90+30 ~= rotationAroundX.fromRadToDeg()) == false{
//                    rotationAroundZ = 0
//                }
//                print("rotationx: \(rotationAroundX.fromRadToDeg()), rotationy: \(rotationAroundY.fromRadToDeg())")
                
                handler(.success(rotationAroundZ.fromRadToDeg()))
                
            }
        }
    }
}
