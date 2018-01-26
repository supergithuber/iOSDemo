//
//  WXStorageBaseModel.swift
//  iOSDemo
//
//  Created by wuxi on 2018/1/26.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

import UIKit
import YYKit
//所有存储的基类，使用YYKit
class WXStorageBaseModel: NSObject, NSCoding {
    
    fileprivate var didUpdate: (() -> Void)?
    private var kvoContext = "\(Date())"
    
    deinit {
        ivarNames().forEach {
            self.removeObserver(self, forKeyPath: $0, context: &kvoContext)
        }
    }
    override init() {
        super.init()
        ivarNames().forEach {
            self.addObserver(self, forKeyPath: $0, options: [.old, .new], context: &kvoContext)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init()
        modelInit(with: aDecoder)
        ivarNames().forEach {
            self.addObserver(self, forKeyPath: $0, options: [.old, .new], context: &kvoContext)
        }
    }
    
    func encode(with aCoder: NSCoder) {
        modelEncode(with: aCoder)
    }
    
    fileprivate func ivarNames() -> [String]{
        var count :UInt32 = 0
        //class_copyPropertyList只会copy property
        guard let varList = class_copyIvarList(self.classForCoder, &count) else {
            return [String]()
        }
        //utf-8编码
        var names = [String]()
        for index in 0..<count{
            let variable = varList[Int(index)]
            //property_getName?
            if let name = String(utf8String: ivar_getName(variable)){
                names.append(name)
            }
        }
        return names
    }
    //MARK: - KVO
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard context == &kvoContext else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            return
        }
        didUpdate?()
    }
}
