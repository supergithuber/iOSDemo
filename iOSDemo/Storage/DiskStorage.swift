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
                //YYcache无法把block序列化到磁盘，取出来需要重新赋值
                appConfig.didUpdate = { [unowned self] in
                    self.diskStorage.setObject(appConfig, forKey: kAppConfigutationKey)
                }
                return appConfig
            }
            //
            let appConfig = AppConfiguration()
            appConfig.didUpdate = { [unowned self] in
                self.diskStorage.setObject(appConfig, forKey: kAppConfigutationKey)
            }
            self.diskStorage.setObject(appConfig, forKey: kAppConfigutationKey)
            return appConfig
        }
    }
}
