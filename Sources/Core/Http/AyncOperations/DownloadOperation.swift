//
//  File.swift
//  
//
//  Created by Damodar, Namala (623-Extern) on 11/02/21.
//

import Foundation

@available(iOS 11.0, *)
class DownloadOperation : AyncOperation {
    var task: URLSessionTask!

    private var observation: NSKeyValueObservation?
    var fileProgress = Observable<(Double,String)>((0,""))

    deinit {
        observation?.invalidate()
    }

    init(session: URLSession, url: URL) {
        super.init()
        task = session.downloadTask(with: url) { temporaryURL, response, error in
            defer { self.finish() }

            guard
                let httpResponse = response as? HTTPURLResponse,
                200..<300 ~= httpResponse.statusCode
            else {
                // handle invalid return codes however you'd like
                return
            }

            guard let temporaryURL = temporaryURL, error == nil else {
                print(error ?? "Unknown error")
                return
            }

            do {
                let manager = FileManager.default
                let destinationURL = try manager.url(for: .documentDirectory,
                                                     in: .userDomainMask,
                                                     appropriateFor: nil,
                                                     create: false)
                    .appendingPathComponent(url.lastPathComponent)
                // print("destinationURL :\(destinationURL)")
                try? manager.removeItem(at: destinationURL) // remove the old one, if any
                try manager.moveItem(at: temporaryURL, to: destinationURL)    // move new one there
            } catch let moveError {
                print("\(moveError)")
            }
        }
        observation = task.progress.observe(\.fractionCompleted) { progress, _ in
            // print("progress: ", progress.fractionCompleted)
            self.fileProgress.value = (progress.fractionCompleted, url.lastPathComponent)
        }
        task.resume()
    }

    override func cancel() {
        task.cancel()
        super.cancel()
    }

    override func main() {
        task.resume()
    }
}


/*
 let queue = OperationQueue()
 let session = URLSession.shared
 for url in urls {
 let operation = DownloadOperation(session: session, url: url)
 operation.fileProgress.observe(on: self) { (progress, fileName) in
 print(fileName, progress)
 }
 queue.addOperation(operation)
 // if needed
 queue.waitUntilAllOperationsAreFinished()
 }
 */
