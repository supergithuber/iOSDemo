//
//  ClosureInitScrollView.swift
//  iOSDemo
//
//  Created by wuxi on 2018/1/11.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

import UIKit

class ClosureInitScrollView: UIScrollView {

    //这里通过闭包来返回标签数量和内容
    //构造函数的重载，oc中没有重载，swift中可以
    init(frame: CGRect, numberOfLabel: ()->Int, labelOfIndex: (_ index: Int)->UILabel) {
        //swift中的构造函数不需要返回值
        super.init(frame: frame)
        //实例化scrollView，并指定大小和位置
        //swift中省略self
        backgroundColor = UIColor.lightGray
        //执行闭包，并且获取标签数量
        let count = numberOfLabel()
        print("标签数量 \(count)")
        
        let margin:CGFloat = 8
        var x = margin
        //遍历count，知道标签内容，添加到scrollView
        for i in 0..<count
        {
            let label = labelOfIndex(i)
            label.frame = CGRect(x: x, y: 0, width: label.bounds.width, height: frame.height)
            //添加到scrollview
            addSubview(label)
            //递增x
            x += label.bounds.width
        }
        contentSize = CGSize(width: x+margin, height: frame.size.height)
        
        
    }
    //保证只用代码的形式写界面，一旦使用了storyboard或者xib就会报错
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
