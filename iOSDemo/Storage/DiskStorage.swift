//
//  DiskStorage.swift
//  iOSDemo
//
//  Created by wuxi on 2018/1/26.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

import UIKit
import YYKit

private let kDiskStorageKey = "com.iOSDemo.diskStorage"

private let kAppConfigutationKey = "com.insta360.StorageBucket.configuretion"

class DiskStorage: NSObject {
    static let shared = DiskStorage()
    private let diskStorage: YYCache = YYCache(name: kDiskStorageKey)!
    
    private override init() {
        super.init()
    }
    
    var appConfiguration:AppConfiguration {
        get {
            if let appConfig = diskStorage.object(forKey: kAppConfigutationKey) as? AppConfiguration {
                //YYcache可能不支持block属性的序列化
                appConfig.didUpdate = { [unowned self] in
                    self.diskStorage.setObject(appConfig, forKey: kAppConfigutationKey)
                }
                return appConfig
            }
            
            let appConfig = AppConfiguration()
            self.diskStorage.setObject(appConfig, forKey: kAppConfigutationKey)
            appConfig.didUpdate = { [unowned self] in
                self.diskStorage.setObject(appConfig, forKey: kAppConfigutationKey)
            }
            return appConfig
        }
    }
}
