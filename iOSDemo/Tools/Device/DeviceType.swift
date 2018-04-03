//
//  DeviceType.swift
//  iOSDemo
//
//  Created by wuxi on 2018/4/2.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

import UIKit

@objc public enum DeviceType: Int {
    #if os(iOS)
    case iPhone
    case iPad
    case iPod
    case simulator
    #elseif os(OSX)
    case iMac
    case macMini
    case macPro
    case macBook
    case macBookAir
    case macBookPro
    case xserve
    #endif
    case unknowType
}
