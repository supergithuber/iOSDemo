//
//  WXCrashHandler.swift
//  ImageDemo
//
//  Created by Wuxi on 2019/4/1.
//  Copyright © 2019年 mick. All rights reserved.
//

import UIKit
import MachO

private typealias HUMSignalHandler = (@convention(c) (Int32, UnsafeMutablePointer<__siginfo>?, UnsafeMutableRawPointer?) -> Void)

private var previousUncaughtExceptionHandler: NSUncaughtExceptionHandler? = nil
private var previousABRTSignalHandler: HUMSignalHandler? = nil
private var previousBUSSignalHandler: HUMSignalHandler? = nil
private var previousFPESignalHandler: HUMSignalHandler? = nil
private var previousILLSignalHandler: HUMSignalHandler? = nil
private var previousPIPESignalHandler: HUMSignalHandler? = nil
private var previousSEGVSignalHandler: HUMSignalHandler? = nil
private var previousSYSSignalHandler: HUMSignalHandler? = nil
private var previousTRAPSignalHandler: HUMSignalHandler? = nil

class WXCrashHandler {
    static var slideAddress :String = ""
    private init() { }
    //在APP didFinish最前注册一下
    class func registerHandler() {
        // dSYM偏移地址(Slide Address)获取
        var slideAddress: Int64 = 0x0000000100000000
        let imageCount = _dyld_image_count()
        for i in 0 ..< imageCount {
            if let header = _dyld_get_image_header(i) {
                if header.pointee.filetype == MH_EXECUTE {
                    let slide = _dyld_get_image_vmaddr_slide(i)
                    slideAddress = slideAddress | Int64(slide)
                    break
                }
            }
        }
        let UUID = WXCrashHelper.getMainExecutableBinaryImageUUID()
        print("Incident Identifier: \(UUID)")
        print("Slide Address: \(String(format: "0x%016llx", slideAddress))")
        self.slideAddress = String(format: "0x%016llx", slideAddress)
        // CPU & 总的运行内存获取
        let hostBasicInfoCount = MemoryLayout<host_basic_info>.stride / MemoryLayout<integer_t>.stride
        var size = mach_msg_type_number_t(hostBasicInfoCount)
        var hostInfo = host_basic_info()
        let result = withUnsafeMutablePointer(to: &hostInfo) {
            $0.withMemoryRebound(to: integer_t.self, capacity: Int(size), {
                host_info(mach_host_self(), HOST_BASIC_INFO, $0, &size)
            })
        }
        if result == KERN_SUCCESS {
            let cpuType: String
            switch hostInfo.cpu_type {
            case CPU_TYPE_X86:              cpuType = "X86"
            case CPU_TYPE_X86_64:           cpuType = "X86_64"
            case CPU_TYPE_ARM:
                switch hostInfo.cpu_subtype {
                case CPU_SUBTYPE_ARM_V6:    cpuType = "ARMV6"
                case CPU_SUBTYPE_ARM_V7:    cpuType = "ARMV7"
                case CPU_SUBTYPE_ARM_V7F:   cpuType = "ARMV7F"
                case CPU_SUBTYPE_ARM_V7S:   cpuType = "ARMV7S"
                case CPU_SUBTYPE_ARM_V7K:   cpuType = "ARMV7K"
                case CPU_SUBTYPE_ARM_V8:    cpuType = "ARMV8"
                default:                    cpuType = "ARM"
                }
            case CPU_TYPE_ARM64:            cpuType = "ARM64"
            case CPU_TYPE_ARM64_32:         cpuType = "ARM64_32"
            case CPU_TYPE_I386:             cpuType = "i386"
            case CPU_TYPE_POWERPC:          cpuType = "POWERPC"
            default:                        cpuType = ""
            }
            print("CPU Type: \(cpuType)")
            print("Memory Size: \(hostInfo.max_mem)")
        }
        // 手机型号
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { (identifier, element) -> String in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        print("Phone Model: \(identifier)")
        // 其他APP信息获取
        let systemName = UIDevice.current.systemName
        let systemVersion = UIDevice.current.systemVersion
        let deviceModel = UIDevice.current.model
        let currentLanguage = Locale.preferredLanguages.first ?? ""
        let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? ""
        let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
        let buildNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? ""
        let bundleId = Bundle.main.object(forInfoDictionaryKey: "CFBundleIdentifier") as? String ?? ""
        
        print("App Name: \(appName)")
        print("App Version: \(appVersion)")
        print("Build Number: \(buildNumber)")
        print("Bundle Identifier: \(bundleId)")
        print("Device Model: \(deviceModel)")
        print("System Name: \(systemName)")
        print("System Version: \(systemVersion)")
        print("Current Language: \(currentLanguage)")
        
        // 注册【异常处理】
        previousUncaughtExceptionHandler = NSGetUncaughtExceptionHandler()
        NSSetUncaughtExceptionHandler(HUMUncaughtExceptionHandler())
        // 注册【信号处理】
        HUMBackupOriginalSignalHandler()
        HUMSignalRegister(signal: SIGABRT)
        HUMSignalRegister(signal: SIGBUS)
        HUMSignalRegister(signal: SIGFPE)
        HUMSignalRegister(signal: SIGILL)
        HUMSignalRegister(signal: SIGPIPE)
        HUMSignalRegister(signal: SIGSEGV)
        HUMSignalRegister(signal: SIGSYS)
        HUMSignalRegister(signal: SIGTRAP)
    }
}

private func HUMSaveCrashInfo(log: String, crashFilePrefix: String) {
    let cacheRoot = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as NSString
    let crashDirPath = cacheRoot.appendingPathComponent("HUMAppCrash")
    let formatter = DateFormatter()
    formatter.dateFormat = "YYYY-MM-dd HH-mm-ss"
    let time = formatter.string(from: Date())
    let newCrashFileName = String(format: "%@ %@.txt", crashFilePrefix, time)
    let crashLogFilePath = (crashDirPath as NSString).appendingPathComponent(newCrashFileName)
    
    do {
        var isDirectory: ObjCBool = false
        let fileExists = FileManager.default.fileExists(atPath: crashDirPath, isDirectory: &isDirectory)
        if fileExists {
            if !isDirectory.boolValue {
                try FileManager.default.removeItem(atPath: crashDirPath)
                try FileManager.default.createDirectory(atPath: crashDirPath, withIntermediateDirectories: true, attributes: nil)
            }
        } else {
            try FileManager.default.createDirectory(atPath: crashDirPath, withIntermediateDirectories: true, attributes: nil)
        }
        try log.write(toFile: crashLogFilePath, atomically: true, encoding: .utf8)
        print("崩溃日志写入完成:")
        print(log)
    } catch let error {
        print("写入崩溃日志失败: \(error)")
    }
}

private func HUMUncaughtExceptionHandler() -> @convention(c) (NSException) -> Void {
    return { (exception) -> Void in
        var log = ""
        log.append(WXCrashHandler.slideAddress)
        log.append("======== Uncaught Exception【未捕获异常】日志 ========\n")
        log.append(String(format: "Name: %@\n", exception.name.rawValue))
        log.append(String(format: "Reason: %@\n", exception.reason ?? ""))
        log.append("Stack Symbols: \n")
        log.append(exception.callStackSymbols.joined(separator: "\n"))
        HUMSaveCrashInfo(log: log, crashFilePrefix: "Crash(Exception)")
        if let previousUncaughtExceptionHandler = previousUncaughtExceptionHandler {
            previousUncaughtExceptionHandler(exception)
        }
        // 如果发现未捕获的异常，关闭数据库连接，退出App
//        HUMDatabaseManager.shared.closeDatabase()
        kill(getpid(), SIGKILL)
    }
}

private func HUMBackupOriginalSignalHandler() {
    var oldActionABRT = sigaction()
    sigaction(SIGABRT, nil, &oldActionABRT)
    if let action = oldActionABRT.__sigaction_u.__sa_sigaction {
        previousABRTSignalHandler = action
    }
    var oldActionBUS = sigaction()
    sigaction(SIGBUS, nil, &oldActionBUS)
    if let action = oldActionBUS.__sigaction_u.__sa_sigaction {
        previousBUSSignalHandler = action
    }
    var oldActionFPE = sigaction()
    sigaction(SIGFPE, nil, &oldActionFPE)
    if let action = oldActionFPE.__sigaction_u.__sa_sigaction {
        previousFPESignalHandler = action
    }
    var oldActionILL = sigaction()
    sigaction(SIGILL, nil, &oldActionILL)
    if let action = oldActionILL.__sigaction_u.__sa_sigaction {
        previousILLSignalHandler = action
    }
    var oldActionPIPE = sigaction()
    sigaction(SIGPIPE, nil, &oldActionPIPE)
    if let action = oldActionPIPE.__sigaction_u.__sa_sigaction {
        previousPIPESignalHandler = action
    }
    var oldActionSEGV = sigaction()
    sigaction(SIGSEGV, nil, &oldActionSEGV)
    if let action = oldActionSEGV.__sigaction_u.__sa_sigaction {
        previousSEGVSignalHandler = action
    }
    var oldActionSYS = sigaction()
    sigaction(SIGSYS, nil, &oldActionSYS)
    if let action = oldActionSYS.__sigaction_u.__sa_sigaction {
        previousSYSSignalHandler = action
    }
    var oldActionTRAP = sigaction()
    sigaction(SIGTRAP, nil, &oldActionTRAP)
    if let action = oldActionTRAP.__sigaction_u.__sa_sigaction {
        previousTRAPSignalHandler = action
    }
}

private func HUMSignalRegister(signal: Int32) {
    var action = sigaction()
    action.__sigaction_u.__sa_sigaction = HUMSigactionHandler()
    action.sa_flags = SA_NODEFER | SA_SIGINFO
    sigemptyset(&action.sa_mask)
    sigaction(signal, &action, nil)
}

private func HUMSigactionHandler() -> @convention(c) (Int32, UnsafeMutablePointer<__siginfo>?, UnsafeMutableRawPointer?) -> Void {
    return { (signal, info, context) -> Void in
        var signalName = ""
        switch signal {
        case SIGABRT:   signalName = "SIGABRT"
        case SIGBUS:    signalName = "SIGBUS"
        case SIGFPE:    signalName = "SIGFPE"
        case SIGILL:    signalName = "SIGILL"
        case SIGPIPE:   signalName = "SIGPIPE"
        case SIGSEGV:   signalName = "SIGSEGV"
        case SIGSYS:    signalName = "SIGSYS"
        case SIGTRAP:   signalName = "SIGTRAP"
        default:        signalName = String(format: "%d", signal)
        }
        
        var log = ""
        log.append(WXCrashHandler.slideAddress)
        log.append("======== Signal Exception【信号错误】日志 ========\n")
        log.append(String(format: "Thread info: %@\n", Thread.current.description))
        log.append(String(format: "Signal exception: Signal【%@】was raised.\n", signalName))
        log.append("Call stack: \n")
        let callStackSymbols = Thread.callStackSymbols
        let callStackCount = callStackSymbols.count
        if callStackCount > 1 {
            for i in 1 ..< callStackCount {
                log.append(String(format: "%@\n", callStackSymbols[i]))
            }
        }
        
        HUMSaveCrashInfo(log: log, crashFilePrefix: "Crash(Signal)")
        HUMClearSignalRegister()
        var previousSignalHandler: HUMSignalHandler? = nil
        switch signal {
        case SIGABRT:   previousSignalHandler = previousABRTSignalHandler
        case SIGBUS:    previousSignalHandler = previousABRTSignalHandler
        case SIGFPE:    previousSignalHandler = previousABRTSignalHandler
        case SIGILL:    previousSignalHandler = previousABRTSignalHandler
        case SIGPIPE:   previousSignalHandler = previousABRTSignalHandler
        case SIGSEGV:   previousSignalHandler = previousABRTSignalHandler
        case SIGSYS:    previousSignalHandler = previousABRTSignalHandler
        case SIGTRAP:   previousSignalHandler = previousABRTSignalHandler
        default:        break
        }
        if let previousSignalHandler = previousSignalHandler {
            previousSignalHandler(signal, info, context)
        }
        // 如果发现未捕获的异常，关闭数据库连接，退出App
//        HUMDatabaseManager.shared.closeDatabase()
        kill(getpid(), SIGKILL)
    }
}

private func HUMClearSignalRegister() {
    signal(SIGSEGV, SIG_DFL)
    signal(SIGFPE, SIG_DFL)
    signal(SIGBUS, SIG_DFL)
    signal(SIGTRAP, SIG_DFL)
    signal(SIGABRT, SIG_DFL)
    signal(SIGILL, SIG_DFL)
    signal(SIGPIPE, SIG_DFL)
    signal(SIGSYS, SIG_DFL)
}
