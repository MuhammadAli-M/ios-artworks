//
//  Double+Angle.swift
//  Artworks
//
//  Created by Muhammad Adam on 26/12/2021.
//

import Foundation

extension Double{
    static var piInDegrees: Double = 180
    
    func fromRadToDeg() -> Double {
        return self * .piInDegrees / .pi
    }
}
