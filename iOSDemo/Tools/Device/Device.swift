//
//  Device.swift
//  iOSDemo
//
//  Created by wuxi on 2018/4/2.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

import UIKit

class Device: NSObject {
    
    //MARK: - public
    static open func model() -> DeviceModel{
        return getDevice(versionCode: getDeviceCode())
    }
    static open func type() -> DeviceType{
        return getDeviceType(versionCode: getDeviceCode())
    }
    static open func isRetina() -> Bool{
        return UIScreen.main.scale > 1.0
    }
    static open func isiPhone() -> Bool{
        return type() == .iPhone
    }
    static open func isiPad() -> Bool{
        return type() == .iPad
    }
    static open func isiPod() -> Bool{
        return type() == .iPod
    }
    static open func isSimulator() -> Bool{
        return type() == .simulator
    }
    
    //MARK: - private
    /// versionCode
    ///
    /// - Returns: such as "iPhone10,1", "iPhone8,1"
    static private func getDeviceCode() -> String{
        var systemInfo = utsname()
        uname(&systemInfo)
        
        let deviceCode: String = String(validatingUTF8: NSString(bytes: &systemInfo.machine, length: Int(_SYS_NAMELEN), encoding: String.Encoding.ascii.rawValue)!.utf8String!)!
        
        return deviceCode
    }
    
    ///
    /// - Parameter versionCode: versionCode
    /// - Returns: 对应的设备名称
    static private func getDevice(versionCode: String) -> DeviceModel{
        switch versionCode {
        //iPhone
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":      return .iPhone4
        case "iPhone4,1", "iPhone4,2", "iPhone4,3":      return .iPhone4s
        case "iPhone5,1", "iPhone5,2":                   return .iPhone5
        case "iPhone5,3", "iPhone5,4":                   return .iPhone5c
        case "iPhone6,1", "iPhone6,2":                   return .iPhone5s
        case "iPhone7,2":                                return .iPhone6
        case "iPhone7,1":                                return .iPhone6Plus
        case "iPhone8,1":                                return .iPhone6s
        case "iPhone8,2":                                return .iPhone6sPlus
        case "iPhone8,4":                                return .iPhoneSE
        case "iPhone9,1", "iPhone9,3":                   return .iPhone7
        case "iPhone9,2", "iPhone9,4":                   return .iPhone7Plus
        case "iPhone10,1", "iPhone10,4":                 return .iPhone8
        case "iPhone10,2", "iPhone10,5":                 return .iPhone8Plus
        case "iPhone10,3", "iPhone10,6":                 return .iPhoneX
        
        //iPad
        case "iPad1,1":                                  return .iPad1
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4": return .iPad2
        case "iPad3,1", "iPad3,2", "iPad3,3":            return .iPad3
        case "iPad3,4", "iPad3,5", "iPad3,6":            return .iPad4
        case "iPad6,11", "iPad6,12":                     return .iPad5
        case "iPad4,1", "iPad4,2", "iPad4,3":            return .iPadAir
        case "iPad5,3", "iPad5,4":                       return .iPadAir2
        case "iPad2,5", "iPad2,6", "iPad2,7":            return .iPadMini
        case "iPad4,4", "iPad4,5", "iPad4,6":            return .iPadMini2
        case "iPad4,7", "iPad4,8", "iPad4,9":            return .iPadMini3
        case "iPad5,1", "iPad5,2":                       return .iPadMini4
        case "iPad6,7", "iPad6,8", "iPad7,1", "iPad7,2": return .iPadPro12_9Inch
        case "iPad7,3", "iPad7,4":                       return .iPadPro10_5Inch
        case "iPad6,3", "iPad6,4":                       return .iPadPro9_7Inch
        
        //iPod
        case "iPod1,1":                                  return .iPodTouch1Gen
        case "iPod2,1":                                  return .iPodTouch2Gen
        case "iPod3,1":                                  return .iPodTouch3Gen
        case "iPod4,1":                                  return .iPodTouch4Gen
        case "iPod5,1":                                  return .iPodTouch5Gen
        case "iPod7,1":                                  return .iPodTouch6Gen
        
        //模拟器
        case "i386", "x86_64":                           return .simulator
            
        default:                                         return .unknowModel
        }
    }
    static private func getDeviceType(versionCode: String) -> DeviceType {
        let versionCode = getDeviceCode()
        
        if versionCode.contains("iPhone") {
            return .iPhone
        } else if versionCode.contains("iPad") {
            return .iPad
        } else if versionCode.contains("iPod") {
            return .iPod
        } else if versionCode == "i386" || versionCode == "x86_64" {
            return .simulator
        } else {
            return .unknowType
        }
    }
}
