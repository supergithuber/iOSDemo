//
//  DownloadQueue.swift
//  Insta360EVO
//
//  Created by Wuxi on 2017/5/19.
//  Copyright © 2017年 Danis. All rights reserved.
//

import Foundation
import Alamofire

public typealias DownloadProgressHandler = (Progress) -> Void
public typealias DownloadCompletionHandler = (Error?) -> Void

public typealias AssociatedProgressHandler = (_ fractionCompleted: Double, _ current: Int, _ total: Int) -> Void

protocol DownloadTaskCommands {
    
    func resume()
    
    func cancel()
    
    func identifyTask(_ url: URL) -> Bool
}

class Task: NSObject, DownloadTaskCommands {
    
    let source: URL
    private(set) var destination: URL
    
    var progressHandler: DownloadProgressHandler?
    var completionHandler: DownloadCompletionHandler?
    private var request: Request?
    
    private var sessionManager: SessionManager?
    
    private let commonConfiguration: URLSessionConfiguration = {
        let configuration: URLSessionConfiguration = URLSessionConfiguration.default
        configuration.requestCachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
        configuration.urlCache = nil
        configuration.timeoutIntervalForRequest = 30.0
        
        return configuration
    }()
    
    init(from source: URL, to destination: URL) {
        self.source = source
        self.destination = destination
    }
    
    func cancel() {
        if let request = request {
            request.cancel()
        }
    }
    
    func resume() {
        if let request = request {
            request.resume()
        } else {
//            if DownloadHTTPSystemProxyBlacklist.defaultList.detect(url: source) {
//                commonConfiguration.connectionProxyDictionary = [kCFNetworkProxiesHTTPEnable : false]
//            }
            
            sessionManager = SessionManager(configuration: commonConfiguration)
            request = sessionManager?.download(source) { (url, urlResponse) -> (destinationURL: URL, options: DownloadRequest.DownloadOptions) in
                return (self.destination, [.removePreviousFile, .createIntermediateDirectories])
                }.downloadProgress { [weak self] (fraction) in
                    self?.progressHandler?(fraction)
                }.response { [weak self] (response) in
                    self?.completionHandler?(response.error)
            }
        }
    }
    
    func identifyTask(_ url: URL) -> Bool {
        return url == self.source ? true : false
    }
    
    func redirectDestinationURL(_ url: URL) {
        self.destination = url
    }
}

class AssociationTask: NSObject, DownloadTaskCommands {
    
    private(set) var totalCount: Int = 0
    
    private(set) var current: Int = 1
    
    private var tasks: [Task] = [Task]()
    
    private var cachedPaths: [String] = [String]()

    private var destinationPaths: [Task : URL] = [Task : URL]()
    
    private var lock = NSLock()
    
    var progressHandler: AssociatedProgressHandler?
    var completionHandler: DownloadCompletionHandler?
    
    deinit {
        print("AssociationTask deinit")
    }
    
    init(tasks: [Task]) {
        self.tasks = tasks
        self.totalCount = tasks.count
    }
    
    func resume() {
        self.lock.lock()
        guard let task = self.tasks.first else {
            self.lock.unlock()
            
            // 从tmp路径下转存至目标路径
            for task in Array(self.destinationPaths.keys) {
                guard let destination = self.destinationPaths[task] else { continue }
                do {
                    try FileManager.default.moveItem(atPath: task.destination.path, toPath: destination.path)
                }
                catch let error {
                    self.completionHandler?(error)
                    return
                }
            }
            self.completionHandler?(nil)
            return
        }
        self.lock.unlock()
        
        // 联合任务, 其中任意任务完成后都存于tmp中, 所有联合任务都完成后再转存至对应的目标地址
        self.destinationPaths.updateValue(task.destination, forKey: task)
        let tmpURL: URL = URL(fileURLWithPath: NSTemporaryDirectory())
        let cachedURL: URL = tmpURL.appendingPathComponent(task.destination.lastPathComponent)
        task.redirectDestinationURL(cachedURL)
        
        let ratio: Double = 1.0 / Double(self.totalCount)
        
        task.progressHandler = { [unowned self] (progress) in
            let fractionCompleted: Double = progress.fractionCompleted * ratio + Double(self.current-1) * ratio
            self.progressHandler?(fractionCompleted, self.current, self.totalCount)
        }
        
        task.completionHandler = { [unowned self] (error) in
            if let error = error {
                self.lock.lock()
                if let first = self.tasks.first {
                    self.cachedPaths.append(first.destination.path)
                }
                self.tasks.removeAll()
                self.lock.unlock()
                self.cancel()
                
                self.completionHandler?(error)
            }
            else {
                self.lock.lock()
                if let first = self.tasks.first {
                    self.cachedPaths.append(first.destination.path)
                }
                self.tasks.removeFirst()
                self.current += 1
                self.lock.unlock()
                
                self.resume() // 递归处理任务
            }
        }
        
        task.resume()
    }
    
    func cancel() {
        if let task = self.tasks.first {
            task.cancel()
            self.cachedPaths.append(task.destination.path)
        }
        for path in self.cachedPaths {
            do {
                if FileManager.default.fileExists(atPath: path) {
                    try FileManager.default.removeItem(atPath: path)
                }
            }
            catch let error {
                print("Downloader task error: \(error.localizedDescription)")
            }
        }
        self.lock.lock()
        self.tasks.removeAll()
        self.lock.unlock()
    }
    
    func identifyTask(_ url: URL) -> Bool {
        for task in tasks {
            if task.source == url {
                return true
            }
        }
        return false
    }
}

public class Downloader {
    
    public static let shared = Downloader()
    
    private var tasks = Array<DownloadTaskCommands>()
    
    private var currentTask: DownloadTaskCommands?
    
    private var taskLock = NSLock()
    
    public init() {
        
    }
    
    public func download(from source: URL, to destination: URL, progress: DownloadProgressHandler?, completion: DownloadCompletionHandler?) {
        let task = Task(from: source, to: destination)
        task.progressHandler = progress
        task.completionHandler = { [unowned self] (error) in
            completion?(error)
            
            self.taskLock.lock()
            self.currentTask = nil
            self.tasks.removeFirst()
            self.resumeNext()
            self.taskLock.unlock()
        }
        
        taskLock.lock()
        tasks.append(task)
        resumeNext()
        taskLock.unlock()
    }
    
    /*
     *  用于多文件关联下载
     *  paths: [sources : destination]
     */
    public func associationTaskDownload(from paths: [URL : URL], progress: AssociatedProgressHandler?, completion: DownloadCompletionHandler?) {
        var downloadTasks: [Task] = [Task]()
        for source in Array(paths.keys) {
            guard let destination: URL = paths[source] else { continue }
            
            let task = Task(from: source, to: destination)
            downloadTasks.append(task)
        }
        
        let associationTask: AssociationTask = AssociationTask(tasks: downloadTasks)
        associationTask.progressHandler = progress
        associationTask.completionHandler = { [unowned self] (error) in
            completion?(error)
            
            self.taskLock.lock()
            self.currentTask = nil
            self.tasks.removeFirst()
            self.resumeNext()
            self.taskLock.unlock()
        }
        
        taskLock.lock()
        tasks.append(associationTask)
        resumeNext()
        taskLock.unlock()
    }

    public func cancel(_ sources: [URL]) {
        for source in sources {
            taskLock.lock()
            if currentTask?.identifyTask(source) ?? false {
                currentTask?.cancel()
                resumeNext()
            }
            else {
                for task in tasks {
                    if task.identifyTask(source) {
                        task.cancel()
                        break
                    }
                }
            }
            taskLock.unlock()
        }
    }
    
    public func cancelAll() {
        taskLock.lock()
        tasks.removeAll()
        currentTask?.cancel()
        currentTask = nil
        taskLock.unlock()
    }
    
    func resumeNext() {
        if currentTask == nil {
            currentTask = tasks.first
            currentTask?.resume()
        }
    }
}
