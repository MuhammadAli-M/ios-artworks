//
//  Logger.swift
//  Artworks
//
//  Created by Muhammad Adam on 22/12/2021.
//

import Foundation

func debugLog(_ message:String, file:String = #file, function:String = #function, line:Int = #line){
    print("DEBUG: \(message), ::\(function) \(file.split(separator: "/").last ?? ""):[\(line)]")
}

func errorLog(_ message:String, file:String = #file, function:String = #function, line:Int = #line){
    print("Error: \(message), ::\(function) \(file.split(separator: "/").last ?? ""):[\(line)]")
}
