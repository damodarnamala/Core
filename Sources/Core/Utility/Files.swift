//
//  File.swift
//  
//
//  Created by Damodar, Namala
//

import Foundation

open class Files  {
    static public let shared = Files()
    
    public func contains(with name: String) -> Bool {
        guard let path = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                             .userDomainMask, true).first
        else {return false}
        
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
    
    static var documentDirectoryURL: URL? {
        do {
            return try FileManager.default.url( for: .documentDirectory,
                                                in: .userDomainMask,
                                                appropriateFor: nil, create: false)
        }
        catch _ {
            return nil
        }
    }
    
}

public extension FileManager {
    static func createOrFindApplicationDirectory() -> URL? {
        guard let bundleID = Bundle.main.bundleIdentifier else {
            return nil
        }
        
        // Find the application support directory in the home directory.
        let appSupportDirArray = self.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)
        
        guard let appSupportDir = appSupportDirArray.first else {
            return nil
        }
        
        // Append the bundle ID to the URL for the Application Support directory.
        let dirPath = appSupportDir.appendingPathComponent(bundleID)
        
        // If the directory does not exist, this method creates it.
        do {
            try self.default.createDirectory(at: dirPath, withIntermediateDirectories: true, attributes: nil)
            return dirPath
        } catch let error {
            print("Error creating Application Support directory with error: \(error)")
            return nil
        }
    }
    
    static func createOrFindDirectory(named name: String) -> URL? {
        guard let appSupportDir = createOrFindApplicationDirectory() else {
            return nil
        }
        
        let dirPath = appSupportDir.appendingPathComponent(name)
        
        // If the directory does not exist, this method creates it.
        do {
            try self.default.createDirectory(at: dirPath, withIntermediateDirectories: true, attributes: nil)
            return dirPath
        } catch let error {
            print("Error creating \(name) directory with error: \(error)")
            return nil
        }
    }
    
    static func directory(with path: String) -> URL? {
        guard let feedDir = createOrFindDirectory(named: path) else {
            return nil
        }
        
        let dirPath = feedDir.appendingPathComponent(path)
        
        // If the directory does not exist, this method creates it.
        do {
            try self.default.createDirectory(at: dirPath, withIntermediateDirectories: true, attributes: nil)
            return dirPath
        } catch let error {
            print("Error creating Images directory with error: \(error)")
            return nil
        }
    }
}
