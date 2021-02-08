//
//  File.swift
//  
//
//  Created by Damodar, Namala (623-Extern) on 08/02/21.
//

import Foundation

open class Files  {
    static public let shared = Files()
    public func contains(with name: String) -> Bool {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = NSURL(fileURLWithPath: path)
        if let pathComponent = url.appendingPathComponent(name) {
            let filePath = pathComponent.path
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: filePath) {
                print("File found with name: \(name)")
                return true
            } else {
                print("Error: file not exist with name \(name)")
                return false
            }
        } else {
            print("Error: file not exist with name \(name)")
            return false
        }
    }
}


